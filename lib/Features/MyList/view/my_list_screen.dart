import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:fl_downloader/fl_downloader.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/view/home_screen.dart';
import 'package:smarthealth_hcp/Features/MyList/Model/my_list_response_model/datum.dart';
import 'package:smarthealth_hcp/Features/MyList/Viewmodel/my_list_viewmodel.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/upload_consent_screen.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/intent_const.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/constants/widget_consts.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MyListScreen extends StatefulWidget {
  static String route = "/MyListScreen";
  const MyListScreen({super.key});

  @override
  MyListScreenState createState() => MyListScreenState();
}

class MyListScreenState extends State<MyListScreen> {
  bool isLoading = true;
  bool isFileDownloading = false;
  String filePath = "";
  String newPath = "";
  Directory? directory;
  Directory? shareDirectory;
  late DownloadProgress downloadProgress;
  List<String> downloadId = [];
  File? file;

  static const _kBasePadding = 10.0;
  static const kExpandedHeight = 160.0;

  final ValueNotifier<double> _titlePaddingNotifier = ValueNotifier(
    _kBasePadding,
  );

  final _scrollController = ScrollController();
  late StreamSubscription progressStream;

  double get _horizontalTitlePadding {
    const kCollapsedPadding = 45.0;

    if (_scrollController.hasClients) {
      return min(
        _kBasePadding + kCollapsedPadding,
        _kBasePadding +
            (kCollapsedPadding * _scrollController.offset) /
                (kExpandedHeight - kToolbarHeight),
      );
    }
    return _kBasePadding;
  }

  late MyListViewModel myListViewModel;
  List<ListData>? resultListData;

  @override
  void initState() {
    myListViewModel = context.read<MyListViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callMyListAPI();
    });
    startdownload();
    // resultListData = myListViewModel.listData;
    super.initState();
  }

  void startdownload() {
    FlDownloader.initialize();
    progressStream = FlDownloader.progressStream.listen((event) async {
      downloadProgress = event;
      if (event.status == DownloadStatus.running) {
        setState(() {
          isFileDownloading = true;
        });
        debugPrint("DOWNLOADING.....");
      } else if (event.status == DownloadStatus.successful) {
        setState(() {
          isFileDownloading = false;
        });
        filePath = event.filePath.toString();
        debugPrint("FILE_PATH ---> $filePath");
        CommonWidget.showErrorMessage(
          AppLocalizations.of(context)!.downloaded_successfully,
          context,
        );
        debugPrint("DOWNLOADED");
      }
    });
  }

  @override
  void dispose() {
    progressStream.cancel();
    super.dispose();
  }

  callMyListAPI() {
    myListViewModel.getMyList().then((value) {
      if (myListViewModel.userError.success != null) {
        CommonWidget.showErrorMessage(
          myListViewModel.userError.message.toString(),
          context,
        );
      } else if (myListViewModel.listResponse.success == API_SUCCESS) {
        resultListData = myListViewModel.listData;
        setState(() {
          isLoading = false;
        });
      } else if (myListViewModel.listResponse.success == API_FAIL) {
        CommonWidget.showErrorMessage(
          myListViewModel.listResponse.message.toString(),
          context,
        );
      }
    });
  }

  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    debugPrint("LIST_FILE_DOWNLOAD --> $downloadId");
    _scrollController.addListener(() {
      _titlePaddingNotifier.value = _horizontalTitlePadding;
    });

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: false,
              elevation: 0,
              expandedHeight: kExpandedHeight,
              backgroundColor: Theme.of(context).colorScheme.surface,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: Image.asset('assets/images/icon_home.png'),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 0,
                ),
                title: ValueListenableBuilder(
                  valueListenable: _titlePaddingNotifier,
                  builder: (context, value, child) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: value),
                      child: SizedBox(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            AppLocalizations.of(context)!.my_list,
                            style: appTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              // color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: searchTextController,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          resultListData = myListViewModel.listData;
                          setState(() {
                            debugPrint("Result List Data-->$resultListData");
                          });
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 1.0,
                        ),
                        hintText: AppLocalizations.of(context)!.patient_name,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: themeBlueColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (searchTextController.text.isNotEmpty) {
                          resultListData = resultListData!
                              .where(
                                (element) => element.patientName
                                    .toString()
                                    .toLowerCase()
                                    .toUpperCase()
                                    .contains(
                                      searchTextController.text
                                          .toString()
                                          .toLowerCase()
                                          .toUpperCase(),
                                    ),
                              )
                              .toList();
                        } else {
                          resultListData = myListViewModel.listData;
                        }
                        debugPrint("Result List Data-->$resultListData");
                        setState(() {});
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: themeBlueColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.search,
                            style: appTextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: isLoading
                    ? const AppLoading()
                    : resultListData!.isEmpty
                    ? Center(
                        child: Text(
                          AppLocalizations.of(context)!.no_voucher_found,
                          style: appTextStyle.copyWith(fontSize: 20),
                        ),
                      )
                    : Stack(
                        children: [
                          ListView.builder(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            shrinkWrap: true,
                            itemCount: resultListData?.length,
                            itemBuilder: (BuildContext context, int index) {
                              ListData data = resultListData![index];
                              return Consumer<MyListViewModel>(
                                builder: (context, itemLoaderState, _) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5.0,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(
                                          5.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                          left: 8.0,
                                          right: 8.0,
                                          top: 8.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (data.patientName!.isEmpty)
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  if (data
                                                      .resultUrl!
                                                      .isNotEmpty)
                                                    InkWell(
                                                      customBorder:
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  10,
                                                                ),
                                                          ),
                                                      onTap: () {
                                                        openDoc(data.resultUrl);
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 8.0,
                                                              vertical: 3.0,
                                                            ),
                                                        child: Icon(
                                                          Icons
                                                              .insert_drive_file,
                                                          color: themeBlueColor,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            if (data.patientName!.isNotEmpty)
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${data.patientName} ${data.patientLastName ?? ""}" ??
                                                        '',
                                                    style: appTextStyle
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 17,
                                                        ),
                                                  ),
                                                  if (data
                                                      .resultUrl!
                                                      .isNotEmpty)
                                                    InkWell(
                                                      customBorder:
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  10,
                                                                ),
                                                          ),
                                                      onTap: () {
                                                        openDoc(data.resultUrl);
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 8.0,
                                                              vertical: 3.0,
                                                            ),
                                                        child: Icon(
                                                          Icons
                                                              .insert_drive_file,
                                                          color: themeBlueColor,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            const SizedBox(height: 8.0),
                                            Text(
                                              "${AppLocalizations.of(context)!.voucher}, #${data.id}",
                                              style: appTextStyle.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: grey,
                                                fontSize: 17,
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            data.activeConfirmed == 1
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        CommonWidget.getDateTimeLocalFormat(
                                                          '${data.createdAt}',
                                                        ),
                                                        style: appTextStyle
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: grey,
                                                              fontSize: 17,
                                                            ),
                                                      ),
                                                      data.confirmed == 1
                                                          ? Text(
                                                              'Confirmed',
                                                              style: appTextStyle
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color:
                                                                        greenColor,
                                                                    fontSize:
                                                                        17,
                                                                  ),
                                                            )
                                                          : myListViewModel
                                                                .isLoading(
                                                                  index,
                                                                )
                                                          ? SizedBox(
                                                              height: 25,
                                                              width: 25,
                                                              child: const CircularProgressIndicator(
                                                                color:
                                                                    themeBlueColor,
                                                                strokeWidth: 3,
                                                              ),
                                                            )
                                                          : ElevatedButton(
                                                              onPressed: () async {
                                                                myListViewModel
                                                                    .setConfirmed(
                                                                      data,
                                                                      index,
                                                                    );
                                                              },
                                                              style: ButtonStyle(
                                                                backgroundColor:
                                                                    WidgetStateProperty.all(
                                                                      themeBlueColor,
                                                                    ),
                                                                shape: WidgetStateProperty.all(
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          10.0,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                "Confirm",
                                                                style: appTextStyle.copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                    ],
                                                  )
                                                : Text(
                                                    CommonWidget.getDateTimeLocalFormat(
                                                      '${data.createdAt}',
                                                    ),
                                                    style: appTextStyle
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: grey,
                                                          fontSize: 17,
                                                        ),
                                                  ),
                                            const SizedBox(height: 8.0),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/icon_lab.png",
                                                  scale: 7,
                                                ),
                                                const SizedBox(width: 10.0),
                                                Expanded(
                                                  child: Text(
                                                    data.voucherTitle ?? '',
                                                    style: appTextStyle
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: themeBlueColor,
                                                          fontSize: 17,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  data.statusCode == 0
                                                      ? "Pending"
                                                      : data.statusCode == 1
                                                      ? "Completed"
                                                      : "Accepted",
                                                  // AppLocalizations.of(context)!.in_process,
                                                  style: appTextStyle.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    // color: greenColor,
                                                    fontSize: 17,
                                                    color: data.statusCode == 2
                                                        ? greenColor
                                                        : data.statusCode == 0
                                                        ? orangeColor
                                                        : redColor,
                                                  ),
                                                ),
                                                if (data.resendConsent == 1)
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              UploadConsentScreen(
                                                                from:
                                                                    INTENT_FROM_MY_LIST,
                                                                consentId:
                                                                    data.id,
                                                              ),
                                                        ),
                                                      );
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty.all(
                                                            themeBlueColor,
                                                          ),
                                                      shape: WidgetStateProperty.all(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10.0,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.reupload_consent,
                                                      style: appTextStyle
                                                          .copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(height: 12.0),
                                            // Step Progress Indicator
                                            _buildStepIndicator(data),
                                            // Coordinator Notes
                                            if (data.notes != null && data.notes!.isNotEmpty) ...[
                                              const SizedBox(height: 10.0),
                                              Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFFFF8E1),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  border: Border.all(color: const Color(0xFFFFE082)),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Icon(
                                                      Icons.comment_outlined,
                                                      size: 18,
                                                      color: Color(0xFFF9A825),
                                                    ),
                                                    const SizedBox(width: 8.0),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            AppLocalizations.of(context)!.notes,
                                                            style: appTextStyle.copyWith(
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 13,
                                                              color: const Color(0xFFF57F17),
                                                            ),
                                                          ),
                                                          const SizedBox(height: 3.0),
                                                          Text(
                                                            data.notes!,
                                                            style: appTextStyle.copyWith(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14,
                                                              color: const Color(0xFF5D4037),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                            const SizedBox(height: 8.0),
                                            if (data.resultUrl!.isNotEmpty)
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      fldownload(
                                                        data,
                                                        data.resultUrl,
                                                      );

                                                      // saveandDownloadFile(
                                                      //     data.resultUrl!,
                                                      //     "${data.patientName}_${data.id}_${AppLocalizations.of(context)!.result}",
                                                      //     data.id.toString());
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty.all(
                                                            themeBlueColor,
                                                          ),
                                                      shape: WidgetStateProperty.all(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10.0,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.download,
                                                      style: appTextStyle
                                                          .copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                                  // if (downloadId
                                                  //     .contains(data.id.toString()))
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      share(data.resultUrl);
                                                      // ShareExtend.share(
                                                      //     file!.path, 'pdf');
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty.all(
                                                            themeBlueColor,
                                                          ),
                                                      shape: WidgetStateProperty.all(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10.0,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.share,
                                                      style: appTextStyle
                                                          .copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          if (isFileDownloading == true) const AppLoading(),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Step Progress Indicator Widget
  /// Green = completed, Gray = processing (current active step), Light = pending
  Widget _buildStepIndicator(ListData data) {
    final l10n = AppLocalizations.of(context)!;
    final stepValues = [
      data.inprogress ?? 0,
      data.sampleCollection ?? 0,
      data.sendOutProcess ?? 0,
      data.resultsAvailable ?? 0,
      data.resultsSentToDoctor ?? 0,
    ];
    final stepLabels = [
      l10n.step_in_progress,
      l10n.step_sample_collection,
      l10n.step_send_out,
      l10n.step_results_available,
      l10n.step_sent_to_doctor,
    ];

    // Determine processing step: the first uncompleted step in sequence
    int processingIndex = -1;
    for (int i = 0; i < stepValues.length; i++) {
      if (stepValues[i] != 1) {
        processingIndex = i;
        break;
      }
    }

    final steps = List.generate(stepValues.length, (i) {
      if (stepValues[i] == 1) {
        return _StepData(stepLabels[i], _StepStatus.completed);
      } else if (i == processingIndex) {
        return _StepData(stepLabels[i], _StepStatus.processing);
      } else {
        return _StepData(stepLabels[i], _StepStatus.pending);
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(steps.length * 2 - 1, (index) {
            if (index.isEven) {
              final stepIndex = index ~/ 2;
              final step = steps[stepIndex];
              return Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: step.status == _StepStatus.completed
                      ? greenColor
                      : step.status == _StepStatus.processing
                          ? Colors.grey
                          : lightGreyColor,
                  border: Border.all(
                    color: step.status == _StepStatus.completed
                        ? greenColor
                        : step.status == _StepStatus.processing
                            ? Colors.grey
                            : Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                child: step.status == _StepStatus.completed
                    ? const Icon(Icons.check, size: 13, color: Colors.white)
                    : step.status == _StepStatus.processing
                        ? Container(
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          )
                        : null,
              );
            } else {
              final prevStepIndex = index ~/ 2;
              final prevStep = steps[prevStepIndex];
              return Expanded(
                child: Container(
                  height: 2,
                  color: prevStep.status == _StepStatus.completed
                      ? greenColor
                      : lightGreyColor,
                ),
              );
            }
          }),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: steps.map((step) {
            return SizedBox(
              width: 52,
              child: Text(
                step.label,
                style: appTextStyle.copyWith(
                  fontSize: 8,
                  color: step.status == _StepStatus.completed
                      ? greenColor
                      : step.status == _StepStatus.processing
                          ? Colors.grey.shade700
                          : Colors.grey.shade400,
                  fontWeight: step.status == _StepStatus.completed
                      ? FontWeight.w600
                      : step.status == _StepStatus.processing
                          ? FontWeight.w600
                          : FontWeight.w400,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// FILE DOWNLOAD
  void fldownload(ListData data, String? url) {
    FlDownloader.download(
      url!,
      fileName:
          "${data.patientName}_${data.id}_${AppLocalizations.of(context)!.result}.pdf",
    ).then((value) {
      debugPrint("DOWNLOAD_STARTED--> Value ->$value");
      setState(() {
        isFileDownloading = true;
      });
    });
    debugPrint("DOWNLOAD_STARTED");
  }

  /// SHARE LINK
  void share(String? url) {
    SharePlus.instance.share(
      ShareParams(
        title: AppLocalizations.of(context)!.result,
        uri: Uri.parse(url ?? ""),
      ),
    );
  }

  void openDoc(String? url) async {
    debugPrint("URL--> $url");
    await launchUrlString(url!, mode: LaunchMode.externalApplication);
  }

  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
}

enum _StepStatus { completed, processing, pending }

class _StepData {
  final String label;
  final _StepStatus status;

  _StepData(this.label, this.status);
}

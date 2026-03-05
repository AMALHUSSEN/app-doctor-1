import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/view/home_screen.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/view/patient_details_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/get_projects_response_model/projects_data.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/get_projects_response_model/voucher.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/certification_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/questionnaire_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/upload_consent_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view_model/select_project_view_model.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/intent_const.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/constants/widget_consts.dart';

class SelectServiceScreen extends StatefulWidget {
  static String route = "/SelectServiceScreen";
  final int? projectIndex;
  const SelectServiceScreen({Key? key, this.projectIndex}) : super(key: key);

  @override
  SelectServiceScreenState createState() => SelectServiceScreenState();
}

class SelectServiceScreenState extends State<SelectServiceScreen> {
  List<ProjectsData> arrProjects = [];
  int? voucherIndex;
  int? selectedId;
  late SelectProjectViewModel selectProjectViewModel;
  bool isLoading = false;
  static const _kBasePadding = 10.0;
  static const kExpandedHeight = 145.0;
  Voucher? voucherData;

  final ValueNotifier<double> _titlePaddingNotifier = ValueNotifier(
    _kBasePadding,
  );

  final _scrollController = ScrollController();

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

  @override
  void initState() {
    selectProjectViewModel = context.read<SelectProjectViewModel>();

    context.read<SelectProjectViewModel>().getDoctorData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      _titlePaddingNotifier.value = _horizontalTitlePadding;
    });
    return Consumer<SelectProjectViewModel>(
      builder: (context, projectViewModel, _) {
        return Scaffold(
          body: projectViewModel.loadingDoctorData == true
              ? const AppLoading()
              : NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        floating: false,
                        elevation: 0,
                        expandedHeight: kExpandedHeight,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.background,
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
                                padding: EdgeInsets.symmetric(
                                  horizontal: value,
                                ),
                                child: SizedBox(
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.selectservice,
                                      style: appTextStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          background: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              projectViewModel
                                          .doctorDataResponse
                                          .result!
                                          .data!
                                          .status ==
                                      1
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.selectservicesubtitle,
                                        textAlign: TextAlign.left,
                                        style: appTextStyle.copyWith(
                                          color: grey,
                                          fontSize: 15,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body:
                      projectViewModel
                              .doctorDataResponse
                              .result!
                              .data!
                              .status ==
                          1
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      padding: const EdgeInsets.only(
                                        bottom: 75.0,
                                      ),
                                      itemCount: selectProjectViewModel
                                          .projectsData[widget.projectIndex ??
                                              0]
                                          .vouchers
                                          ?.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        voucherData = selectProjectViewModel
                                            .projectsData[widget.projectIndex ??
                                                0]
                                            .vouchers![index];
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            selectedId = voucherData?.id;
                                            selectProjectViewModel.checkVoucherApiCall(selectedId ?? 0).then((
                                              value,
                                            ) {
                                              if (selectProjectViewModel
                                                      .checkVoucherResponse
                                                      .success ==
                                                  1) {
                                                isLoading = false;
                                                voucherIndex = index;
                                                setState(() {});
                                                if (selectProjectViewModel
                                                        .projectsData[widget
                                                                .projectIndex ??
                                                            0]
                                                        .vouchers![voucherIndex ??
                                                            0]
                                                        .numberPageConsent ==
                                                    2) {
                                                  if (selectProjectViewModel
                                                          .projectsData[widget
                                                                  .projectIndex ??
                                                              0]
                                                          .vouchers![voucherIndex ??
                                                              0]
                                                          .skipQuestionnaire ==
                                                      1) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => CertificationScreen(
                                                          voucherIndex:
                                                              voucherIndex,
                                                          projectIndex: widget
                                                              .projectIndex,
                                                          voucherID: selectProjectViewModel
                                                              .projectsData[widget
                                                                      .projectIndex ??
                                                                  0]
                                                              .vouchers![voucherIndex ??
                                                                  0]
                                                              .id
                                                              .toString(),
                                                          projectID: selectProjectViewModel
                                                              .projectsData[widget
                                                                      .projectIndex ??
                                                                  0]
                                                              .id
                                                              .toString(),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    print(
                                                      "questionaire screen ${voucherData?.id}",
                                                    );
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            QuestionnaireScreen(
                                                              voucherIndex:
                                                                  voucherIndex,
                                                              projectIndex: widget
                                                                  .projectIndex,
                                                              voucherID:
                                                                  voucherData
                                                                      ?.id
                                                                      .toString() ??
                                                                  "0",
                                                            ),
                                                      ),
                                                    );
                                                  }
                                                } else {
                                                  /// old navigation
                                                  if (selectProjectViewModel
                                                          .projectsData[widget
                                                                  .projectIndex ??
                                                              0]
                                                          .vouchers![voucherIndex ??
                                                              0]
                                                          .skipQuestionnaire ==
                                                      1) {
                                                    if (selectProjectViewModel
                                                            .projectsData[widget
                                                                    .projectIndex ??
                                                                0]
                                                            .vouchers![voucherIndex ??
                                                                0]
                                                            .skipConsent ==
                                                        1) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => CertificationScreen(
                                                            voucherIndex:
                                                                voucherIndex,
                                                            projectIndex: widget
                                                                .projectIndex,
                                                            voucherID: selectProjectViewModel
                                                                .projectsData[widget
                                                                        .projectIndex ??
                                                                    0]
                                                                .vouchers![voucherIndex ??
                                                                    0]
                                                                .id
                                                                .toString(),
                                                            projectID: selectProjectViewModel
                                                                .projectsData[widget
                                                                        .projectIndex ??
                                                                    0]
                                                                .id
                                                                .toString(),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      print("Go To consent");
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => UploadConsentScreen(
                                                            voucherIndex:
                                                                voucherIndex,
                                                            projectIndex: widget
                                                                .projectIndex,
                                                            from:
                                                                INTENT_FROM_REGISTER,
                                                            voucherID: selectProjectViewModel
                                                                .projectsData[widget
                                                                        .projectIndex ??
                                                                    0]
                                                                .vouchers![voucherIndex ??
                                                                    0]
                                                                .id
                                                                .toString(),
                                                            projectID: selectProjectViewModel
                                                                .projectsData[widget
                                                                        .projectIndex ??
                                                                    0]
                                                                .id
                                                                .toString(),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  } else {
                                                    debugPrint(
                                                      "widget.projectIndex ${widget.projectIndex}",
                                                    );
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => QuestionnaireScreen(
                                                          voucherIndex:
                                                              voucherIndex,
                                                          projectIndex: widget
                                                              .projectIndex,
                                                          voucherID: selectProjectViewModel
                                                              .projectsData[widget
                                                                      .projectIndex ??
                                                                  0]
                                                              .vouchers![voucherIndex ??
                                                                  0]
                                                              .id
                                                              .toString(),
                                                          projectID: selectProjectViewModel
                                                              .projectsData[widget
                                                                      .projectIndex ??
                                                                  0]
                                                              .id
                                                              .toString(),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                }
                                              } else {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                                CommonWidget.showErrorMessage(
                                                  selectProjectViewModel
                                                      .checkVoucherResponse
                                                      .message!,
                                                  context,
                                                );
                                              }
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 5.0,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                // color: Colors.white,
                                                border: Border.all(
                                                  color: index == voucherIndex
                                                      ? themeBlueColor
                                                      : Colors.grey,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 5.0,
                                                    ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 80,
                                                      width: 80,
                                                      child: Image.asset(
                                                        "assets/images/icon_lab.png",
                                                        scale: 150,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              vertical: 8.0,
                                                            ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              voucherData
                                                                      ?.title ??
                                                                  '',
                                                              style: appTextStyle
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            Text(
                                                              voucherData
                                                                      ?.shortDescription ??
                                                                  '',
                                                              maxLines: 8,
                                                              style: appTextStyle
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        13,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              // Positioned(
                              //   left: 0,
                              //   right: 0,
                              //   bottom: 0,
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(bottom: 20.0),
                              //     child: SizedBox(
                              //       height: 50,
                              //       child: ElevatedButton(
                              //         onPressed: () {
                              //           if (selectProjectViewModel
                              //                   .projectsData[widget.projectIndex ?? 0]
                              //                   .skipQuestionnaire ==
                              //               1) {
                              //             if (selectProjectViewModel
                              //                     .projectsData[widget.projectIndex ?? 0]
                              //                     .skipConsent ==
                              //                 1) {
                              //               Navigator.push(
                              //                   context,
                              //                   MaterialPageRoute(
                              //                     builder: (context) => CertificationScreen(
                              //                       voucherIndex: voucherIndex,
                              //                       projectIndex: widget.projectIndex,
                              //                     ),
                              //                   ));
                              //             } else {
                              //               Navigator.push(
                              //                   context,
                              //                   MaterialPageRoute(
                              //                     builder: (context) => UploadConsentScreen(
                              //                       voucherIndex: voucherIndex,
                              //                       projectIndex: widget.projectIndex,
                              //                     ),
                              //                   ));
                              //             }
                              //           } else {
                              //             debugPrint("Voucher Data---> $voucherData");
                              //             Navigator.push(
                              //                 context,
                              //                 MaterialPageRoute(
                              //                   builder: (context) => QuestionnaireScreen(
                              //                     voucherIndex: voucherIndex,
                              //                     projectIndex: widget.projectIndex,
                              //                   ),
                              //                 ));
                              //           }
                              //         },
                              //         style: ButtonStyle(
                              //             shape: MaterialStateProperty.all(
                              //               RoundedRectangleBorder(
                              //                 borderRadius: BorderRadius.circular(25.0),
                              //               ),
                              //             ),
                              //             backgroundColor:
                              //                 MaterialStateProperty.all(themeBlueColor)),
                              //         child: Text(
                              //           AppLocalizations.of(context)!.confirm,
                              //           style: appTextStyle.copyWith(
                              //               color: white,
                              //               fontWeight: FontWeight.bold,
                              //               fontSize: 18),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // )
                              if (selectProjectViewModel.loading ||
                                  isLoading == true)
                                const AppLoading(),
                            ],
                          ),
                        )
                      : Center(
                          child: Text(
                            AppLocalizations.of(context)!.service_not_available,
                            textAlign: TextAlign.center,
                            style: appTextStyle.copyWith(
                              color: grey,
                              fontSize: 25,
                            ),
                          ),
                        ),
                ),
        );
      },
    );
  }
}

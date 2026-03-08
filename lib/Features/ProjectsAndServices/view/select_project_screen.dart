// ignore_for_file: unused_local_variable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/view/home_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/get_projects_response_model/projects_data.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/select_service_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view_model/select_project_view_model.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/constants/widget_consts.dart';

class SelectProjectScreen extends StatefulWidget {
  static String route = "/SelectProjectScreen";
  const SelectProjectScreen({Key? key}) : super(key: key);

  @override
  SelectProjectScreenState createState() => SelectProjectScreenState();
}

class SelectProjectScreenState extends State<SelectProjectScreen> {
  bool isLoading = true;
  List<ProjectsData> arrProjects = [];
  int? selectedIndex;
  bool isSelected = false;
  late SelectProjectViewModel selectProjectViewModel;
  callGetProjectAPI() {
    selectProjectViewModel.getProjects().then((value) {
      if (selectProjectViewModel.userError.success != null) {
        setState(() {
          isLoading = false;
        });
        CommonWidget.showErrorMessage(
          selectProjectViewModel.userError.message.toString(),
          context,
        );
      } else if (selectProjectViewModel.projectResponse.success ==
          API_SUCCESS) {
        debugPrint("Loading-->${selectProjectViewModel.loading}");
        setState(() {
          isLoading = false;
        });
      } else if (selectProjectViewModel.projectResponse.success == API_FAIL) {
        setState(() {
          isLoading = false;
        });
        CommonWidget.showErrorMessage(
          selectProjectViewModel.projectResponse.message.toString(),
          context,
        );
        debugPrint("Loading-->${selectProjectViewModel.loading}");
      } else if (selectProjectViewModel.projectResponse.success ==
          API_UNVERIFIED) {
        setState(() {
          isLoading = false;
        });
        CommonWidget.showErrorMessage(
          selectProjectViewModel.projectResponse.message.toString(),
          context,
        );
      }
    });
  }

  static const _kBasePadding = 10.0;
  static const kExpandedHeight = 145.0;

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callGetProjectAPI();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;

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
              backgroundColor: Theme.of(context).colorScheme.background,
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
                            AppLocalizations.of(context)!.selectproject,
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
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        AppLocalizations.of(context)!.selectprojectsubtitle,
                        textAlign: TextAlign.left,
                        style: appTextStyle.copyWith(color: grey, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: isLoading == false
                        ? ListView.builder(
                            padding: const EdgeInsets.only(bottom: 75.0),
                            itemCount:
                                selectProjectViewModel.projectsData.length,
                            itemBuilder: (BuildContext context, int index) {
                              ProjectsData data =
                                  selectProjectViewModel.projectsData[index];
                              return GestureDetector(
                                onTap: () {
                                  debugPrint("Selcted Index-->$selectedIndex");
                                  selectedIndex = index;
                                  setState(() {});
                                  debugPrint("Selcted Index-->$selectedIndex");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SelectServiceScreen(
                                        projectIndex: selectedIndex,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5.0,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      // color: Colors.white,
                                      // color: Theme.of(context).backgroundColor,
                                      border: Border.all(
                                        color: index == selectedIndex
                                            ? themeBlueColor
                                            : Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
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
                                            child: Image.network(
                                              data.logoUrl ?? '',
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
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          data.title ?? '',
                                                          style: appTextStyle
                                                              .copyWith(
                                                                fontWeight:
                                                                    FontWeight.w600,
                                                                fontSize: 15,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10.0),
                                                  Text(
                                                    data.description ?? '',
                                                    maxLines: 8,
                                                    style: appTextStyle
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13,
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
                          )
                        : const AppLoading(),
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
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => SelectServiceScreen(
              //                   projectIndex: selectedIndex),
              //             ),
              //           );
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
            ],
          ),
        ),
      ),
    );
  }
}

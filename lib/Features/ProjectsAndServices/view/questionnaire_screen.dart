// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/view/home_screen.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/view/patient_details_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/SubmitQuestionnaireResponse/submit_question_response.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/get_projects_response_model/voucher.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/questionnaire_response_bean/datum.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/questionnaire_response_bean/option.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/certification_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/upload_consent_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/voucher_detail_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/widget/questionnaire_list.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view_model/select_project_view_model.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/intent_const.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/constants/widget_consts.dart';

class QuestionnaireScreen extends StatefulWidget {
  static String route = "/QuestionnaireScreen";

  final int? voucherIndex;
  final int? projectIndex;
  final int? vouchedId;
  final int? questionnaireId;
  final int? registrationId;
  final List<int>? selectedIds;

  // final File? consentFile;
  final String? consentFile;
  final String? projectID;
  final String? voucherID;
  final String? patientName;
  final String? phone;
  final String? patientID;
  final String? countryCode;
  final String? patientCity;

  // File consent,
  // List<int> questionnaire,
  final int? questionId;
  final String? birthdate;
  final String? patientLastName;
  final Voucher? voucherData;

  const QuestionnaireScreen({
    Key? key,
    this.voucherIndex,
    this.projectIndex,
    this.vouchedId,
    this.questionnaireId,
    this.selectedIds,
    this.consentFile,
    this.registrationId,
    this.patientLastName,
    this.projectID,
    this.voucherID,
    this.patientName,
    this.phone,
    this.patientID,
    this.countryCode,
    this.patientCity,
    this.questionId,
    this.birthdate,
    this.voucherData,
  }) : super(key: key);

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  // Variables
  bool isLoading = true;
  static const _kBasePadding = 10.0;
  static const kExpandedHeight = 145.0;
  final ValueNotifier<double> _titlePaddingNotifier = ValueNotifier(
    _kBasePadding,
  );
  final _scrollController = ScrollController();
  List<int> selectedQuestionnaires = [];
  List<dynamic> getRequest = [];
  Map request = {};
  List<QuestionnaireData> questionnaireData = [];
  List<Option> questionList = [];
  List<dynamic> question = [];
  int questionnaire_id = 0;

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
    // selectProjectViewModel = context.read<SelectProjectViewModel>();
    print("widget.voucherID after navigate ${widget.voucherID}");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callQuestionnaireApi(widget.voucherID!);
    });
    super.initState();
  }

  callQuestionnaireApi(String id) {
    final selectProjectViewModel = context.read<SelectProjectViewModel>();

    print(
      "int.parse(widget.voucherID!) int.parse(widget.voucherID!) ${int.parse(widget.voucherID!)}",
    );
    setState(() {
      isLoading = true;
    });
    selectProjectViewModel.getQuestionnaire(int.parse(widget.voucherID!) ?? 0).then((
      value,
    ) {
      setState(() {
        isLoading = false;
      });
      debugPrint(
        "selectProjectViewModel.questionnaireResponse.success ${selectProjectViewModel.questionnaireResponse.success}",
      );
      if (selectProjectViewModel.userError.success != null) {
        CommonWidget.showErrorMessage(
          selectProjectViewModel.userError.message.toString(),
          context,
        );
      } else if (selectProjectViewModel.questionnaireResponse.success ==
          API_SUCCESS) {
        questionnaireData = selectProjectViewModel.questionnaireData;
        debugPrint("QUESTIONNAIREEEE_DATA heeeeeyyyy ---> $questionnaireData");
        debugPrint(
          "selectProjectViewModel.questionnaireResponse.success ${selectProjectViewModel.questionnaireResponse.success}",
        );
      } else if (selectProjectViewModel.questionnaireResponse.success ==
          API_FAIL) {
        CommonWidget.showErrorMessage(
          selectProjectViewModel.questionnaireResponse.message.toString(),
          context,
        );
      }
    });
  }

  // late SelectProjectViewModel selectProjectViewModel;
  _questionCallBack(List<dynamic> list) {
    // debugPrint("LIST _surveyQuestion--> ${questionnaireData.id}");
    debugPrint("LIST _surveyQuestion--> $list");
    question = list;
    debugPrint("LIST questionSurvey--> $question");
  }

  @override
  Widget build(BuildContext context) {
    question.clear();
    debugPrint("VOUCHER_ID--> ${int.parse(widget.voucherID!)}");
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
                            AppLocalizations.of(context)!.questionnaire,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        AppLocalizations.of(context)!.questionnairesubtitle,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: questionnaireData.isEmpty && isLoading == false
                        ? Center(
                            child: Text(
                              AppLocalizations.of(
                                context,
                              )!.no_questionnaire_found,
                              style: appTextStyle.copyWith(fontSize: 20),
                            ),
                          )
                        : QuestionNaireList(
                            vouchedId: int.parse(widget.voucherID!),
                            questionCallBack: _questionCallBack,
                          ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint("SELECTED_ID--> $selectedIds");
                        // if (getRequest.isNotEmpty) {
                        //   _callApi();
                        // } else {
                        //   CommonWidget.showErrorMessage(
                        //       AppLocalizations.of(context)!
                        //           .please_select_one_questionnaire,
                        //       context);
                        // }
                        if (question.isNotEmpty) {
                          _callApi();
                        } else {
                          CommonWidget.showErrorMessage(
                            AppLocalizations.of(
                              context,
                            )!.please_select_one_questionnaire,
                            context,
                          );
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          themeBlueColor,
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.confirm,
                        style: appTextStyle.copyWith(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (isLoading == true) const AppLoading(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _callApi() async {
    final selectProjectViewModel = context.read<SelectProjectViewModel>();
    setState(() {
      isLoading = true;
    });
    var response = selectProjectViewModel.submitQuestionApiCall(
      int.parse(widget.voucherID!) ?? 0,
      // getRequest,
      question,
    );
    response.then((apiResponse) {
      SubmitQuestionResponse surveyResponse = apiResponse;
      questionnaire_id = surveyResponse.result?.data?.resultId ?? 0;
      debugPrint("Q_QUE_ID--> $questionnaire_id");
      if (surveyResponse.success == API_SUCCESS) {
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }

      print(
        "numberPageConsent ${selectProjectViewModel.projectsData[widget.projectIndex ?? 0].vouchers![widget.voucherIndex ?? 0].numberPageConsent}",
      );

      if (selectProjectViewModel
              .projectsData[widget.projectIndex ?? 0]
              .vouchers![widget.voucherIndex ?? 0]
              .numberPageConsent ==
          2) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CertificationScreen(
              voucherIndex: widget.voucherIndex ?? 0,
              projectIndex: widget.projectIndex,
              voucherID: selectProjectViewModel
                  .projectsData[widget.projectIndex ?? 0]
                  .vouchers![widget.voucherIndex ?? 0]
                  .id
                  .toString(),
              projectID: selectProjectViewModel
                  .projectsData[widget.projectIndex ?? 0]
                  .id
                  .toString(),
            ),
          ),
        );
      } else {
        if (selectProjectViewModel
                .projectsData[widget.projectIndex ?? 0]
                .vouchers![widget.voucherIndex ?? 0]
                .skipConsent ==
            1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CertificationScreen(
                voucherIndex: widget.voucherIndex ?? 0,
                projectIndex: widget.projectIndex,
                voucherID: selectProjectViewModel
                    .projectsData[widget.projectIndex ?? 0]
                    .vouchers![widget.voucherIndex ?? 0]
                    .id
                    .toString(),
                projectID: selectProjectViewModel
                    .projectsData[widget.projectIndex ?? 0]
                    .id
                    .toString(),
              ),
            ),
          );
        } else {
          print("widget projectIndex ${widget.projectID}");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadConsentScreen(
                voucherIndex: widget.voucherIndex,
                projectIndex: widget.projectIndex,
                selectedIds: widget.selectedIds,
                questionnaireId: questionnaire_id,
                from: INTENT_FROM_REGISTER,
                registrationId: widget.registrationId,
                projectID: widget.projectID,
                voucherID: widget.voucherID,
                patientName: widget.patientName,
                phone: widget.phone,
                patientID: widget.patientID,
                countryCode: widget.countryCode,
                patientCity: widget.patientCity,
                questionId: widget.questionnaireId ?? 0,
                birthdate: widget.birthdate,
                patientLastName: widget.patientLastName,
              ),
            ),
          );
        }
      }

      /* Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CertificationScreen(
            voucherIndex: widget.voucherIndex ?? 0,
            projectIndex: widget.projectIndex,
            voucherID: selectProjectViewModel
                .projectsData[widget.projectIndex ?? 0]
                .vouchers![widget.voucherIndex ?? 0]
                .id
                .toString(),
            projectID: selectProjectViewModel
                .projectsData[widget.projectIndex ?? 0].id
                .toString(),
          ),
        ),
      ); */

      /// new reordering pages order

      /*if (selectProjectViewModel.projectsData[widget.projectIndex ?? 0]
              .vouchers![widget.voucherIndex ?? 0].skipPatientDetails ==
          1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CertificationScreen(
              voucherIndex: widget.voucherIndex ?? 0,
              projectIndex: widget.projectIndex,
              voucherID: selectProjectViewModel
                  .projectsData[widget.projectIndex ?? 0]
                  .vouchers![widget.voucherIndex ?? 0]
                  .id
                  .toString(),
              projectID: selectProjectViewModel
                  .projectsData[widget.projectIndex ?? 0].id
                  .toString(),
            ),
          ),
        );
        /* if (selectProjectViewModel
                                      .projectsData[widget.projectIndex ?? 0].vouchers![voucherIndex ?? 0]
                                      .skipQuestionnaire ==
                                      1) {
                                    if (selectProjectViewModel
                                        .projectsData[
                                    widget.projectIndex ?? 0].vouchers![voucherIndex ?? 0]
                                        .skipConsent ==
                                        1) {
                                      /// ToDo: change method
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CertificationScreen(
                                                  voucherIndex: voucherIndex,
                                                  projectIndex: widget.projectIndex,
                                                ),
                                          ));
                                    } else {

                                      /// ToDo: to change
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UploadConsentScreen(
                                                  voucherIndex: voucherIndex,
                                                  projectIndex: widget.projectIndex,
                                                  from: INTENT_FROM_REGISTER,
                                                ),
                                          ));
                                    }
                                  } */
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatientDetailsScreen(
              voucherIndex: widget.voucherIndex,
              projectIndex: widget.projectIndex,
              voucherData: selectProjectViewModel
                  .projectsData[widget.projectIndex ?? 0]
                  .vouchers![widget.voucherIndex ?? 0],
              /*selectedIds: selectedQuestionnaires,
                                        questionnaireId: questionnaire_id,*/
              // from: INTENT_FROM_REGISTER,
            ),
          ),
        );
        /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            QuestionnaireScreen(
                                          voucherIndex: voucherIndex,
                                          projectIndex: widget.projectIndex,
                                          vouchedId: voucherData?.id ?? 0,
                                        ),
                                      ));*/
      }
      */

      /* if (selectProjectViewModel
              .projectsData[widget.projectIndex ?? 0].vouchers![widget.voucherIndex ?? 0].skipConsent ==
          1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VoucherDetailsScreen(
              voucherIndex: widget.voucherIndex,
              projectIndex: widget.projectIndex,
            ),
          ),
        );
      } else {
        print("questionaire screen ");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UploadConsentScreen(
                voucherIndex: widget.voucherIndex,
                projectIndex: widget.projectIndex,
                selectedIds: widget.selectedIds,
                questionnaireId: questionnaire_id,
                from: INTENT_FROM_REGISTER,
                registrationId: widget.registrationId,
                projectID: widget.projectID,
                voucherID: widget.voucherID,
                patientName: widget.patientName,
                phone: widget.phone,
                patientID: widget.patientID,
                countryCode: widget.countryCode,
                patientCity: widget.patientCity,
                questionId: widget.questionnaireId ?? 0,
                birthdate: widget.birthdate,
                patientLastName: widget.patientLastName,
            ),
          ),
        );
        /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UploadConsentScreen(
              voucherIndex: widget.voucherIndex,
              projectIndex: widget.projectIndex,
              selectedIds: selectedQuestionnaires,
              questionnaireId: questionnaire_id,
              from: INTENT_FROM_REGISTER,
            ),
          ),
        );*/
      } */
    });
  }

  getData(int id, Map<dynamic, dynamic> request) {
    if (getRequest.contains(request)) {
      getRequest.remove(request);
      debugPrint("CONTAINS_REMOVE-> $getRequest");
      getRequest.add(request);
      debugPrint("CONTAINS_REMOVE ADDD-> $getRequest");
    } else {
      getRequest.add(request);
      debugPrint("ADDD-> $getRequest");
    }
  }

  List<int> selectedIds = [];

  _selectedIds(List<int> ids) {
    debugPrint("IDS--> $ids");
    selectedIds = ids;
  }
}

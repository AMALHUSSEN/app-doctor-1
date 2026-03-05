import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/view/home_screen.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/view/patient_details_screen.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/view_model/patient_details_screen_view_model.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/get_projects_response_model/voucher.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/questionnaire_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/upload_consent_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/voucher_detail_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view_model/select_project_view_model.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/intent_const.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/constants/widget_consts.dart';

class CertificationScreen extends StatefulWidget {
  static const route = '/CertificationScreen';
  final int? voucherIndex;
  final int? projectIndex;
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

  const CertificationScreen({
    Key? key,
    this.projectIndex,
    this.voucherIndex,
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
  State<CertificationScreen> createState() => _CertificationScreenState();
}

class _CertificationScreenState extends State<CertificationScreen> {
  bool certify = false;
  bool isLoading = false;

  late PatientdetailsViewModel patientdetailsViewModel;
  late SelectProjectViewModel selectProjectViewModel;

  @override
  void initState() {
    selectProjectViewModel = context.read<SelectProjectViewModel>();
    patientdetailsViewModel = context.read<PatientdetailsViewModel>();
    print("widget.projectID ${widget.projectID}");
    print("widget.projectIndex ${widget.projectIndex}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("SELECTED_ID--> ${widget.selectedIds}");
    debugPrint("CONSENT_NAME ${widget.consentFile}");
    debugPrint("C_QUE_ID ${widget.questionnaireId}");

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  navigatetohomescreen();
                },
                icon: Image.asset('assets/images/icon_home.png'),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ).copyWith(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.certification,
                  style: appTextStyle.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Text(
                      selectProjectViewModel
                              .projectsData[widget.projectIndex ?? 0]
                              .vouchers?[widget.voucherIndex ?? 0]
                              .certificationText ??
                          '',
                      style: appTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Transform.scale(
                      scale: 1.4,
                      child: Checkbox(
                        value: certify,
                        fillColor: MaterialStateProperty.all(
                          certify ? themeBlueColor : lightGreyColor,
                        ),
                        onChanged: (value) {
                          debugPrint("$certify");
                          certify = !certify;
                          setState(() {});
                          debugPrint("$certify");
                        },
                      ),
                    ),
                    // const SizedBox(width: 8.0),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          certify = !certify;
                          debugPrint("$certify");
                        });
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Text(
                        AppLocalizations.of(context)!.i_certify,
                        style: appTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10.0),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint(
                        "Skip consent-->${selectProjectViewModel.projectsData[widget.projectIndex ?? 0].skipConsent}",
                      );
                      debugPrint(
                        "Skip questionnaire-->${selectProjectViewModel.projectsData[widget.projectIndex ?? 0].skipQuestionnaire}",
                      );
                      debugPrint(
                        "Skip patient details-->${selectProjectViewModel.projectsData[widget.projectIndex ?? 0].skipPatientDetails}",
                      );
                      debugPrint(
                        "Skip patient NAME-->${selectProjectViewModel.projectsData[widget.projectIndex ?? 0].skipPatientName}",
                      );
                      debugPrint(
                        "Skip patient ID-->${selectProjectViewModel.projectsData[widget.projectIndex ?? 0].skipPatientId}",
                      );
                      debugPrint(
                        "Skip patient CITY-->${selectProjectViewModel.projectsData[widget.projectIndex ?? 0].skipPatientCity}",
                      );
                      debugPrint(
                        "Skip patient COUNTRY-->${selectProjectViewModel.projectsData[widget.projectIndex ?? 0].skipPatientCountry}",
                      );
                      debugPrint(
                        "Skip patient PHONE-->${selectProjectViewModel.projectsData[widget.projectIndex ?? 0].skipPatientPhone}",
                      );
                      debugPrint(
                        "Skip SHARE_VOUCHER-->${selectProjectViewModel.projectsData[widget.projectIndex ?? 0].skipShareVoucher}",
                      );
                      debugPrint(
                        "DISABLE_REQUESTCALL-->${selectProjectViewModel.projectsData[widget.projectIndex ?? 0].disableRequestCall}",
                      );
                      debugPrint(
                        "DISABLE_REDEEM_VOUCHER-->${selectProjectViewModel.projectsData[widget.projectIndex ?? 0].disableRedeemVoucher}",
                      );

                      if (selectProjectViewModel
                              .projectsData[widget.projectIndex ?? 0]
                              .vouchers![widget.voucherIndex ?? 0]
                              .numberPageConsent ==
                          2) {
                        navigateToScreen();
                      } else {
                        nevigateScreen();
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
                      AppLocalizations.of(context)!.submit_request,
                      style: appTextStyle.copyWith(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isLoading == true) const AppLoading(),
      ],
    );
  }

  callApi() {
    setState(() {
      isLoading = true;
    });
    patientdetailsViewModel
        .registerConsent(
          selectProjectViewModel.projectsData[widget.projectIndex ?? 0].id
              .toString(),
          selectProjectViewModel
              .projectsData[widget.projectIndex ?? 0]
              .vouchers![widget.voucherIndex ?? 0]
              .id
              .toString(),
        )
        .then((value) {
          if (patientdetailsViewModel.userError.success != null) {
            setState(() {
              isLoading = false;
            });
            CommonWidget.showErrorMessage(
              patientdetailsViewModel.userError.message.toString(),
              context,
            );
          } else if (patientdetailsViewModel
                  .patientRegistrationResponse
                  .success ==
              API_SUCCESS) {
            setState(() {
              isLoading = false;
            });
            CommonWidget.showErrorMessage(
              patientdetailsViewModel.patientRegistrationResponse.message
                  .toString(),
              context,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VoucherDetailsScreen(
                  voucherIndex: widget.voucherIndex,
                  projectIndex: widget.projectIndex,
                ),
              ),
            );
            // navigatetohomescreen();
          } else if (patientdetailsViewModel
                  .patientRegistrationResponse
                  .success ==
              API_FAIL) {
            setState(() {
              isLoading = false;
            });
          }
        });
  }

  callApi2() {
    setState(() {
      isLoading = true;
    });
    patientdetailsViewModel
        .registerConsent(
          selectProjectViewModel.projectsData[widget.projectIndex ?? 0].id
              .toString(),
          selectProjectViewModel
              .projectsData[widget.projectIndex ?? 0]
              .vouchers![widget.voucherIndex ?? 0]
              .id
              .toString(),
        )
        .then((value) {
          if (patientdetailsViewModel.userError.success != null) {
            setState(() {
              isLoading = false;
            });
            CommonWidget.showErrorMessage(
              patientdetailsViewModel.userError.message.toString(),
              context,
            );
          } else if (patientdetailsViewModel
                  .patientRegistrationResponse
                  .success ==
              API_SUCCESS) {
            setState(() {
              isLoading = false;
            });
            CommonWidget.showErrorMessage(
              patientdetailsViewModel.patientRegistrationResponse.message
                  .toString(),
              context,
            );
            // navigatetohomescreen();
          } else if (patientdetailsViewModel
                  .patientRegistrationResponse
                  .success ==
              API_FAIL) {
            setState(() {
              isLoading = false;
            });
          }
        });
  }

  void navigatetohomescreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }

  void nevigateScreen() {
    if (selectProjectViewModel
                .projectsData[widget.projectIndex ?? 0]
                .vouchers![widget.voucherIndex ?? 0]
                .skipPatientDetails ==
            0 &&
        certify == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PatientDetailsScreen(
            projectIndex: widget.projectIndex,
            voucherIndex: widget.voucherIndex,
            selectedIds: widget.selectedIds,
            consentFile: widget.consentFile,
            questionnaireId: widget.questionnaireId,
          ),
        ),
      );
    } else if (selectProjectViewModel
                .projectsData[widget.projectIndex ?? 0]
                .vouchers![widget.voucherIndex ?? 0]
                .skipPatientDetails ==
            1 &&
        certify == true) {
      callApi();
    } else if (certify == false) {
      CommonWidget.showErrorMessage(
        // AppLocalizations.of(context)!.please_check_certify,
        AppLocalizations.of(context)!.please_check_i_certify,
        context,
      );
    }
  }

  void nevigateScreenOld() {
    print(
      "skipQuestionnaire ${selectProjectViewModel.projectsData[widget.projectIndex ?? 0].vouchers![widget.voucherIndex ?? 0].skipQuestionnaire}",
    );
    if (selectProjectViewModel
            .projectsData[widget.projectIndex ?? 0]
            .vouchers![widget.voucherIndex ?? 0]
            .skipConsent ==
        1) {
      /// ToDo: change method
      callApi();
    } else {
      // callApi2();
      print("widget.projectID ${widget.projectID}");
      print("widget.projectIndex ${widget.projectIndex}");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UploadConsentScreen(
            voucherIndex: widget.voucherIndex,
            projectIndex: widget.projectIndex,
            selectedIds: widget.selectedIds,
            questionnaireId: widget.questionnaireId,
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
    /* if (selectProjectViewModel
                .projectsData[widget.projectIndex ?? 0].skipPatientDetails ==
            0 &&
        certify == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                QuestionnaireScreen(
                  voucherIndex: widget.voucherIndex,
                  projectIndex: widget.projectIndex,
                  //vouchedId: voucherData?.id ?? 0,
                ),
          ));

      /*Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PatientDetailsScreen(
            projectIndex: widget.projectIndex,
            voucherIndex: widget.voucherIndex,
            selectedIds: widget.selectedIds,
            consentFile: widget.consentFile,
            questionnaireId: widget.questionnaireId,
          ),
        ),
      );*/
    } else if (selectProjectViewModel
                .projectsData[widget.projectIndex ?? 0].skipPatientDetails ==
            1 &&
        certify == true) {
      callApi();
    } else if (certify == false) {
      CommonWidget.showErrorMessage(
          // AppLocalizations.of(context)!.please_check_certify,
          AppLocalizations.of(context)!.please_check_i_certify,
          context);
    }
  } */
  }

  navigateToScreen() {
    if (selectProjectViewModel
            .projectsData[widget.projectIndex ?? 0]
            .vouchers![widget.voucherIndex ?? 0]
            .skipPatientDetails ==
        1) {
      /// ToDo: change method
      if (selectProjectViewModel
              .projectsData[widget.projectIndex ?? 0]
              .vouchers![widget.voucherIndex ?? 0]
              .skipConsent ==
          1) {
        callApi();
      } else {
        print("widget.projectID ${widget.projectID}");
        print("widget.projectIndex ${widget.projectIndex}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UploadConsentScreen(
              voucherIndex: widget.voucherIndex,
              projectIndex: widget.projectIndex,
              selectedIds: widget.selectedIds,
              questionnaireId: widget.questionnaireId,
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
    } else {
      // callApi2();
      print("widget.projectID ${widget.projectID}");
      print("widget.projectIndex ${widget.projectIndex}");
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
    }
  }
}

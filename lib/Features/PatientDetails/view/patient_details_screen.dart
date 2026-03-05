import 'package:country_code_picker/country_code_picker.dart';
import 'package:smarthealth_hcp/utils/platform_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/view/home_screen.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/view/widget/cities_bottomsheet.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/view/widget/country_bottomsheet.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/view_model/patient_details_screen_view_model.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/get_projects_response_model/projects_data.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/get_projects_response_model/voucher.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/certification_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/upload_consent_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/voucher_detail_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view_model/select_project_view_model.dart';
import 'package:smarthealth_hcp/Features/new_consent_upload/view/new_consent_file.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/intent_const.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/constants/texts_consts.dart';
import 'package:smarthealth_hcp/constants/widget_consts.dart';

class PatientDetailsScreen extends StatefulWidget {
  static const route = '/PatientDetailsScreen';
  final int? voucherIndex;
  final int? projectIndex;
  final List<int>? selectedIds;
  // final File? consentFile;
  final String? consentFile;
  final int? questionnaireId;
  final Voucher? voucherData;
  const PatientDetailsScreen({
    Key? key,
    this.projectIndex,
    this.voucherIndex,
    this.selectedIds,
    this.consentFile,
    this.questionnaireId,
    this.voucherData,
  }) : super(key: key);

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController idnumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  String? phoneCode = '+966';
  late PatientdetailsViewModel patientdetailsViewModel;
  late SelectProjectViewModel selectProjectViewModel;
  ProjectsData projectData = ProjectsData();
  int? cityId;
  int? index;
  String? countryCode;
  bool isLoading = false;
  int? registrationId;
  callCitiesApi() {
    patientdetailsViewModel.getCities().then((value) {
      if (patientdetailsViewModel.userError.success != null) {
        CommonWidget.showErrorMessage(
          patientdetailsViewModel.userError.message.toString(),
          context,
        );
      } else if (patientdetailsViewModel.cityListResponse.success ==
          API_SUCCESS) {
        setState(() {});
      } else if (patientdetailsViewModel.cityListResponse.success == API_FAIL) {
        CommonWidget.showErrorMessage(
          patientdetailsViewModel.cityListResponse.message.toString(),
          context,
        );
      }
    });
  }

  callCountriesApi() {
    patientdetailsViewModel.getCountries().then((value) {
      if (patientdetailsViewModel.userError.success != null) {
        CommonWidget.showErrorMessage(
          patientdetailsViewModel.userError.message.toString(),
          context,
        );
      } else if (patientdetailsViewModel.countryListResponse.success ==
          API_SUCCESS) {
        setState(() {});
        // cityList = patientdetailsViewModel.cityListResponse.result!.data!;
      } else if (patientdetailsViewModel.countryListResponse.success ==
          API_FAIL) {
        CommonWidget.showErrorMessage(
          patientdetailsViewModel.countryListResponse.message.toString(),
          context,
        );
      }
    });
  }

  callRegisterPatientAPIOld() {
    if (formGlobalKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      patientdetailsViewModel
          .registerPatient(
            projectData.id.toString(),
            projectData.vouchers![widget.voucherIndex ?? 0].id.toString(),
            firstNameController.text,
            mobileController.text,
            idnumberController.text,
            phoneCode ?? '',
            cityController.text,
            widget.consentFile ?? "",
            widget.questionnaireId ?? 0,
            ageController.text,
            lastNameController.text,
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
                registrationId = value.result!.data!.id;
              });
              CommonWidget.showErrorMessage(
                patientdetailsViewModel.patientRegistrationResponse.message
                    .toString(),
                context,
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CertificationScreen(
                    voucherIndex: widget.voucherIndex,
                    projectIndex: widget.projectIndex,
                    selectedIds: widget.selectedIds,
                    questionnaireId: widget.questionnaireId,
                    registrationId: registrationId,
                    voucherData: widget.voucherData,
                  ),
                ),
              );
              /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UploadConsentScreen(
              voucherIndex: widget.voucherIndex,
              projectIndex: widget.projectIndex,
              selectedIds: widget.selectedIds,
              questionnaireId: widget.questionnaireId,
              from: INTENT_FROM_REGISTER,
                registrationId: registrationId
            ),
          ),
        );*/
            } else if (patientdetailsViewModel
                    .patientRegistrationResponse
                    .success ==
                API_FAIL) {
              setState(() {
                isLoading = false;
              });
              CommonWidget.showErrorMessage(
                patientdetailsViewModel.patientRegistrationResponse.message
                    .toString(),
                context,
              );
            }
          });
    }
  }

  callRegisterPatientAPI() {
    if (formGlobalKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      patientdetailsViewModel
          .registerPatient(
            projectData.id.toString(),
            projectData.vouchers![widget.voucherIndex ?? 0].id.toString(),
            firstNameController.text,
            mobileController.text,
            idnumberController.text,
            phoneCode ?? '',
            cityController.text,
            widget.consentFile ?? "",
            widget.questionnaireId ?? 0,
            ageController.text,
            lastNameController.text,
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
            } else if (patientdetailsViewModel
                    .patientRegistrationResponse
                    .success ==
                API_FAIL) {
              setState(() {
                isLoading = false;
              });
              CommonWidget.showErrorMessage(
                patientdetailsViewModel.patientRegistrationResponse.message
                    .toString(),
                context,
              );
            }
          });
    }
  }

  callPatientDetailsAPI() {
    if (formGlobalKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      patientdetailsViewModel
          .patientDetail(
            projectData.id ?? 0,
            projectData.vouchers![widget.voucherIndex ?? 0].id ?? 0,
            firstNameController.text,
            mobileController.text,
            idnumberController.text,
            phoneCode ?? '',
            cityController.text,
            widget.questionnaireId ?? 0,
            ageController.text,
            lastNameController.text,
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
            } else if (patientdetailsViewModel
                    .patientRegistrationResponse
                    .success ==
                API_FAIL) {
              setState(() {
                isLoading = false;
              });
              CommonWidget.showErrorMessage(
                patientdetailsViewModel.patientRegistrationResponse.message
                    .toString(),
                context,
              );
            }
          });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      patientdetailsViewModel = context.read<PatientdetailsViewModel>();
      selectProjectViewModel = context.read<SelectProjectViewModel>();
      callCitiesApi();
      callCountriesApi();
    });
    super.initState();
  }

  void getCity(String cityName, int cityIndex) {
    cityController.text = cityName;
    cityId = cityIndex;
  }

  void getCountry(String countryName, String countryIndex) {
    countryController.text = countryName;
    countryCode = countryIndex;
  }

  @override
  Widget build(BuildContext context) {
    selectProjectViewModel = Provider.of<SelectProjectViewModel>(context);
    projectData = selectProjectViewModel.projectsData[widget.projectIndex ?? 0];
    debugPrint("PROJECT_DATA---> $projectData");
    debugPrint(
      "projectData.skipPatientDateOfBirth---> ${projectData.skipPatientDateOfBirth}",
    );
    debugPrint("SELECTED_QUESTIONNAIRES --> ${widget.selectedIds}");
    debugPrint("CONSENT_NAME--> ${widget.consentFile}");
    debugPrint("PROJECT_INDEX--> ${widget.projectIndex}");
    debugPrint("P_QUE_ID ${widget.questionnaireId}");

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            },
            icon: Image.asset('assets/images/icon_home.png'),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ).copyWith(bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Form(
                        key: formGlobalKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.patient_details,
                              style: appTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              AppLocalizations.of(context)!.patientdtsubtitle,
                              style: appTextStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            if (selectProjectViewModel
                                    .projectsData[widget.projectIndex ?? 0]
                                    .vouchers![widget.voucherIndex ?? 0]
                                    .skipPatientName ==
                                0)
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(
                                      context,
                                    )!.please_enter_first_name;
                                  }
                                  return null;
                                },
                                controller: firstNameController,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(
                                    context,
                                  )!.first_name,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: themeBlueColor,
                                    ),
                                  ),
                                ),
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.next,
                              ),
                            if (selectProjectViewModel
                                    .projectsData[widget.projectIndex ?? 0]
                                    .vouchers![widget.voucherIndex ?? 0]
                                    .skipPatientName ==
                                0)
                              const SizedBox(height: 20.0),
                            if (selectProjectViewModel
                                    .projectsData[widget.projectIndex ?? 0]
                                    .vouchers![widget.voucherIndex ?? 0]
                                    .skipPatientLastName ==
                                0)
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(
                                      context,
                                    )!.please_enter_last_name;
                                  }
                                  return null;
                                },
                                controller: lastNameController,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(
                                    context,
                                  )!.last_name,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: themeBlueColor,
                                    ),
                                  ),
                                ),
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.next,
                              ),
                            if (selectProjectViewModel
                                    .projectsData[widget.projectIndex ?? 0]
                                    .vouchers![widget.voucherIndex ?? 0]
                                    .skipPatientLastName ==
                                0)
                              const SizedBox(height: 20.0),
                            if (selectProjectViewModel
                                    .projectsData[widget.projectIndex ?? 0]
                                    .vouchers![widget.voucherIndex ?? 0]
                                    .skipPatientPhone ==
                                0)
                              Row(
                                children: [
                                  SizedBox(
                                    width: 95,
                                    child: TextFormField(
                                      readOnly: true,
                                      validator: (value) {
                                        if (mobileController.text.isEmpty) {
                                          return "";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        suffixIcon: const Icon(
                                          Icons.arrow_drop_down,
                                        ),
                                        prefixIcon: CountryCodePicker(
                                          dialogBackgroundColor: Theme.of(
                                            context,
                                          ).colorScheme.background,
                                          showFlag: false,
                                          initialSelection: phoneCode,
                                          onChanged: (value) {
                                            debugPrint(value.dialCode);
                                            phoneCode = value.dialCode!;
                                            debugPrint(
                                              "PHONECODE--> $phoneCode",
                                            );
                                          },
                                          dialogSize: Size(
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (mobileController.text.isEmpty) {
                                          return AppLocalizations.of(
                                            context,
                                          )!.please_enter_mobile_number;
                                        }
                                        return null;
                                      },
                                      controller: mobileController,
                                      maxLines: 1,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        labelText: hintEnterMobile,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: const BorderSide(
                                            color: themeBlueColor,
                                          ),
                                        ),
                                      ),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                ],
                              ),
                            if (selectProjectViewModel
                                    .projectsData[widget.projectIndex ?? 0]
                                    .vouchers![widget.voucherIndex ?? 0]
                                    .skipPatientPhone ==
                                0)
                              const SizedBox(height: 20.0),
                            if (selectProjectViewModel
                                    .projectsData[widget.projectIndex ?? 0]
                                    .vouchers![widget.voucherIndex ?? 0]
                                    .skipPatientId ==
                                0)
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(
                                      context,
                                    )!.please_enter_id_number;
                                  }
                                  return null;
                                },
                                controller: idnumberController,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(
                                    context,
                                  )!.id_number,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: themeBlueColor,
                                    ),
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            if (selectProjectViewModel
                                    .projectsData[widget.projectIndex ?? 0]
                                    .vouchers![widget.voucherIndex ?? 0]
                                    .skipPatientId ==
                                0)
                              const SizedBox(height: 20.0),
                            if (selectProjectViewModel
                                    .projectsData[widget.projectIndex ?? 0]
                                    .vouchers![widget.voucherIndex ?? 0]
                                    .skipPatientCountry ==
                                0)
                              TextFormField(
                                readOnly: true,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    isDismissible: false,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => CountriesBottomsheet(
                                      list:
                                          patientdetailsViewModel.countriesData,
                                      getCountry: getCountry,
                                    ),
                                  );
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(
                                      context,
                                    )!.please_select_country;
                                  }
                                  return null;
                                },
                                controller: countryController,
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.arrow_drop_down),
                                  labelText: AppLocalizations.of(
                                    context,
                                  )!.choose_country,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: themeBlueColor,
                                    ),
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            if (selectProjectViewModel
                                    .projectsData[widget.projectIndex ?? 0]
                                    .vouchers![widget.voucherIndex ?? 0]
                                    .skipPatientCountry ==
                                0)
                              const SizedBox(height: 20.0),
                            if (selectProjectViewModel
                                    .projectsData[widget.projectIndex ?? 0]
                                    .vouchers![widget.voucherIndex ?? 0]
                                    .skipPatientCity ==
                                0)
                              TextFormField(
                                readOnly: true,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    isDismissible: false,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => CitiesBottomsheet(
                                      list: patientdetailsViewModel.cityData,
                                      getCity: getCity,
                                    ),
                                  );
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(
                                      context,
                                    )!.please_select_city;
                                  }
                                  return null;
                                },
                                controller: cityController,
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.arrow_drop_down),
                                  labelText: AppLocalizations.of(context)!.city,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: themeBlueColor,
                                    ),
                                  ),
                                ),
                                textInputAction: TextInputAction.done,
                              ),
                            if (selectProjectViewModel
                                    .projectsData[widget.projectIndex ?? 0]
                                    .vouchers![widget.voucherIndex ?? 0]
                                    .skipPatientCity ==
                                0)
                              const SizedBox(height: 20.0),
                            if (selectProjectViewModel
                                    .projectsData[widget.projectIndex ?? 0]
                                    .vouchers![widget.voucherIndex ?? 0]
                                    .skipPatientDateOfBirth ==
                                0)
                              TextFormField(
                                readOnly: true,
                                onTap: () {
                                  if (PlatformUtils.isAndroid) {
                                    _presentDatePicker(context);
                                  } else if (PlatformUtils.isIOS) {
                                    CommonWidget.showSheet(
                                      context,
                                      child: buildIosDatePicker(),
                                      onClicked: () =>
                                          Navigator.of(context).pop(),
                                    );
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(
                                      context,
                                    )!.please_select_birthdate;
                                  }
                                  return null;
                                },
                                controller: ageController,
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.arrow_drop_down),
                                  labelText: AppLocalizations.of(
                                    context,
                                  )!.birth_date,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: themeBlueColor,
                                    ),
                                  ),
                                ),
                                textInputAction: TextInputAction.done,
                              ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint(
                              "SKIP_CONSENT--> ${projectData.skipConsent}",
                            );
                            print(
                              "voucher data hey ${selectProjectViewModel.projectsData[widget.projectIndex ?? 0].vouchers![widget.voucherIndex ?? 0].skipPatientDateOfBirth}",
                            );
                            // callRegisterPatientAPI();
                            if (selectProjectViewModel
                                    .projectsData[widget.projectIndex ?? 0]
                                    .vouchers![widget.voucherIndex ?? 0]
                                    .skipConsent ==
                                0) {
                              print(
                                "Hello from skip consent ${widget.questionnaireId}",
                              );
                              if (formGlobalKey.currentState!.validate()) {
                                if (selectProjectViewModel
                                        .projectsData[widget.projectIndex ?? 0]
                                        .vouchers![widget.voucherIndex ?? 0]
                                        .numberPageConsent ==
                                    2) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UploadConsentScreen(
                                        voucherIndex: widget.voucherIndex,
                                        projectIndex: widget.projectIndex,
                                        selectedIds: widget.selectedIds,
                                        questionnaireId: widget.questionnaireId,
                                        from: INTENT_FROM_REGISTER,
                                        registrationId: registrationId,
                                        projectID: projectData.id.toString(),
                                        voucherID: projectData
                                            .vouchers![widget.voucherIndex ?? 0]
                                            .id
                                            .toString(),
                                        patientName: firstNameController.text,
                                        phone: mobileController.text,
                                        patientID: idnumberController.text,
                                        countryCode: phoneCode ?? '',
                                        patientCity: cityController.text,
                                        questionId: widget.questionnaireId ?? 0,
                                        birthdate: ageController.text,
                                        patientLastName:
                                            lastNameController.text,
                                      ),
                                    ),
                                  );
                                } else {
                                  callRegisterPatientAPI();
                                }
                                /* Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => CertificationScreen(
                                     voucherIndex: widget.voucherIndex,
                                     projectIndex: widget.projectIndex,
                                     selectedIds: widget.selectedIds,
                                     questionnaireId: widget.questionnaireId,
                                     registrationId: registrationId,
                                     projectID:projectData.id.toString(),
                                     voucherID:projectData.vouchers![widget.voucherIndex ?? 0].id.toString(),
                                     patientName: firstNameController.text,
                                     phone: mobileController.text,
                                     patientID: idnumberController.text,
                                     countryCode: phoneCode ?? '',
                                     patientCity:cityController.text,
                                     questionId: widget.questionnaireId ?? 0,
                                     birthdate: ageController.text,
                                     voucherData: widget.voucherData,
                                     patientLastName: lastNameController.text,

                                   ),
                                 ),
                               );*/
                              }
                              // callRegisterPatientAPI();
                            } else {
                              callPatientDetailsAPI();
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
                            AppLocalizations.of(context)!.submit,
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
                if (isLoading == true) const AppLoading(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DateTime? _selectedBirthDate;
  Future<void> _presentDatePicker(BuildContext context) async {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;

    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: themeBlueColor,
              background: Theme.of(context).colorScheme.background,
              onSurface: brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            // badgeTheme: BadgeThemeData(
            //   textStyle: appTextStyle.copyWith(
            //     fontWeight: FontWeight.w500,
            //     fontSize: 16,
            //   ),
            // ),
            textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom()),
          ),
          child: child!,
        );
      },
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedBirthDate = pickedDate;
        // DateFormat formater = DateFormat("dd-MM-yyyy");
        DateFormat formater = DateFormat("yyyy-MM-dd");
        debugPrint("fDATE-> ${formater.format(_selectedBirthDate!)}");
        ageController.value = TextEditingValue(
          text: formater.format(_selectedBirthDate!).toString(),
        );
      });
    });
  }

  Widget buildIosDatePicker() => SizedBox(
    height: 180,
    child: CupertinoDatePicker(
      initialDateTime: DateTime.now(),
      minimumYear: 1900,
      maximumYear: DateTime.now().year,
      maximumDate: DateTime.now(),
      mode: CupertinoDatePickerMode.date,
      onDateTimeChanged: (dateTime) {
        setState(() {
          _selectedBirthDate = dateTime;
          // DateFormat formater = DateFormat("dd-MM-yyyy");
          DateFormat formater = DateFormat("yyyy-MM-dd");
          debugPrint("fDATE-> ${formater.format(_selectedBirthDate!)}");
          ageController.value = TextEditingValue(
            text: formater.format(_selectedBirthDate!).toString(),
          );
        });
      },
    ),
  );
}

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/Features/CMSPage/view/cmspage_screen.dart';
import 'package:smarthealth_hcp/Features/ConsentForm/View/consentscreen.dart';
import 'package:smarthealth_hcp/Features/Registration/view/widget/specitality_widget.dart';
import 'package:smarthealth_hcp/Features/Registration/view_model/register_view_model.dart';
import 'package:smarthealth_hcp/Features/Verificarion/view/verification_screen.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/intent_const.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:smarthealth_hcp/constants/widget_consts.dart';
import 'package:country_picker/country_picker.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String countryCodes = "";
  String message = "";
  String phoneCode = '+966';
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  bool? isLoading = false;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final specialityController = TextEditingController();
  final hospitalController = TextEditingController();
  final projectCodeController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isChecked = false;
  bool isConsent = false;
  bool isFirstNameValid = false;
  bool isLastNameValid = false;
  bool isPhoneValid = false;
  bool isEmailValid = false;
  bool isspecialityValid = false;
  bool ishospitalValid = false;
  bool isProjectCodeValid = false;
  bool isCountryValid = false;
  bool isCitiValid = false;
  bool isPasswordValid = false;
  bool isConfirmPasswordValid = false;

  FocusNode firstNameFocusnode = FocusNode();
  FocusNode lastNameFocusnode = FocusNode();
  FocusNode phoneFocusnode = FocusNode();
  FocusNode emailFocusnode = FocusNode();
  FocusNode specialityFocusnode = FocusNode();
  FocusNode hospitalFocusnode = FocusNode();
  FocusNode projectCodeFocusnode = FocusNode();
  FocusNode countryFocusnode = FocusNode();
  FocusNode cityFocusnode = FocusNode();
  FocusNode passwordFocusnode = FocusNode();
  FocusNode confirmPasswordFocusnode = FocusNode();

  int? specialityId;

  late RegisterViewModel registerViewModel;

  @override
  void initState() {
    registerViewModel = context.read<RegisterViewModel>();
    registerViewModel.getAllSpeciality();
    super.initState();
  }

  // late RegisterViewModel registerViewModel;

  void isValid() {
    setState(() {
      if (firstNameController.text.toString().isEmpty) {
        message = AppLocalizations.of(context)!.please_enter_first_name;
        firstNameFocusnode = FocusNode();
        firstNameFocusnode.requestFocus();
        isFirstNameValid = true;
      } else if (lastNameController.text.toString().isEmpty) {
        message = AppLocalizations.of(context)!.please_enter__last_name;
        lastNameFocusnode = FocusNode();
        lastNameFocusnode.requestFocus();
        isLastNameValid = true;
        isFirstNameValid = false;
      } else if (emailController.text.toString().isEmpty) {
        message = AppLocalizations.of(context)!.please_enter_email;
        emailFocusnode = FocusNode();
        emailFocusnode.requestFocus();
        isEmailValid = true;
        isFirstNameValid = false;
        isLastNameValid = false;
      } else if (!RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
      ).hasMatch(emailController.text.toString())) {
        message = AppLocalizations.of(context)!.please_enter_valid_email;
        emailFocusnode = FocusNode();
        emailFocusnode.requestFocus();
        isFirstNameValid = false;
        isLastNameValid = false;
        isEmailValid = true;
      } else if (phoneController.text.toString().isEmpty) {
        message = AppLocalizations.of(context)!.please_enter_phone;
        phoneFocusnode = FocusNode();
        phoneFocusnode.requestFocus();
        isPhoneValid = true;
        isFirstNameValid = false;
        isLastNameValid = false;
        isEmailValid = false;
      } else if (countryController.text.toString().isEmpty) {
        message = AppLocalizations.of(context)!.please_select_country;
        countryFocusnode = FocusNode();
        countryFocusnode.requestFocus();
        isCountryValid = true;
        isFirstNameValid = false;
        isLastNameValid = false;
        isEmailValid = false;
        isPhoneValid = false;
      } else if (cityController.text.toString().isEmpty) {
        message = AppLocalizations.of(context)!.please_enter_city;
        cityFocusnode = FocusNode();
        cityFocusnode.requestFocus();
        isCitiValid = true;
        isCountryValid = false;
        isFirstNameValid = false;
        isLastNameValid = false;
        isEmailValid = false;
        isPhoneValid = false;
      } else if (hospitalController.text.toString().isEmpty) {
        message = AppLocalizations.of(context)!.please_enter_hospital_name;
        hospitalFocusnode = FocusNode();
        hospitalFocusnode.requestFocus();
        ishospitalValid = true;
        isCitiValid = false;
        isCountryValid = false;
        isFirstNameValid = false;
        isLastNameValid = false;
        isEmailValid = false;
        isPhoneValid = false;
      } else if (specialityController.text.toString().isEmpty) {
        message = AppLocalizations.of(context)!.please_enter_speciality;
        specialityFocusnode = FocusNode();
        specialityFocusnode.requestFocus();
        isspecialityValid = true;
        ishospitalValid = false;
        isCitiValid = false;
        isCountryValid = false;
        isFirstNameValid = false;
        isLastNameValid = false;
        isEmailValid = false;
        isPhoneValid = false;
        // } else if (projectCodeController.text.toString().isEmpty) {
        //   message = AppLocalizations.of(context)!.please_enter_project_code;
        //   projectCodeFocusnode = FocusNode();
        //   projectCodeFocusnode.requestFocus();
        //   isProjectCodeValid = true;
        //   isspecialityValid = false;
        //   ishospitalValid = false;
        //   isCitiValid = false;
        //   isCountryValid = false;
        //   isFirstNameValid = false;
        //   isLastNameValid = false;
        //   isEmailValid = false;
        //   isPhoneValid = false;
      } else if (passwordController.text.toString().isEmpty) {
        message = AppLocalizations.of(context)!.please_enter_password;
        passwordFocusnode = FocusNode();
        passwordFocusnode.requestFocus();
        isPasswordValid = true;
        // isProjectCodeValid = false;
        isspecialityValid = false;
        ishospitalValid = false;
        isCitiValid = false;
        isCountryValid = false;
        isFirstNameValid = false;
        isLastNameValid = false;
        isEmailValid = false;
        isPhoneValid = false;
      } else if (confirmPasswordController.text.toString().isEmpty) {
        message = AppLocalizations.of(context)!.please_enter_confirm_password;
        confirmPasswordFocusnode = FocusNode();
        confirmPasswordFocusnode.requestFocus();
        isConfirmPasswordValid = true;
        isPasswordValid = false;
        // isProjectCodeValid = false;
        isspecialityValid = false;
        ishospitalValid = false;
        isCitiValid = false;
        isCountryValid = false;
        isFirstNameValid = false;
        isLastNameValid = false;
        isEmailValid = false;
        isPhoneValid = false;
      } else if (confirmPasswordController.text.toString() !=
          passwordController.text.toString()) {
        message = AppLocalizations.of(context)!.confrim_password_not_match;
        isConfirmPasswordValid = true;
        isPasswordValid = false;
        // isProjectCodeValid = false;
        isspecialityValid = false;
        ishospitalValid = false;
        isCitiValid = false;
        isCountryValid = false;
        isFirstNameValid = false;
        isLastNameValid = false;
        isEmailValid = false;
        isPhoneValid = false;
      } else if (!isChecked) {
        isConfirmPasswordValid = false;
        isPasswordValid = false;
        // isProjectCodeValid = false;
        isspecialityValid = false;
        ishospitalValid = false;
        isCitiValid = false;
        isCountryValid = false;
        isFirstNameValid = false;
        isLastNameValid = false;
        isEmailValid = false;
        isPhoneValid = false;
        CommonWidget.showErrorMessage(
          AppLocalizations.of(context)!.please_agree_to_the_terms_and_condition,
          context,
        );
      } else if (!isConsent) {
        isConfirmPasswordValid = false;
        isPasswordValid = false;
        // isProjectCodeValid = false;
        isspecialityValid = false;
        ishospitalValid = false;
        isCitiValid = false;
        isCountryValid = false;
        isFirstNameValid = false;
        isLastNameValid = false;
        isEmailValid = false;
        isPhoneValid = false;
        CommonWidget.showErrorMessage(
          AppLocalizations.of(context)!.plaese_sign_consent,
          context,
        );
      } else {
        isConfirmPasswordValid = false;
        isPasswordValid = false;
        // isProjectCodeValid = false;
        isspecialityValid = false;
        ishospitalValid = false;
        isCitiValid = false;
        isCountryValid = false;
        isFirstNameValid = false;
        isLastNameValid = false;
        isEmailValid = false;
        isPhoneValid = false;
        callApi();
      }
    });
  }

  Future callApi() async {
    final registerViewModel = context.read<RegisterViewModel>();
    setState(() {
      isLoading = true;
    });
    try {
      final apiResponse = await registerViewModel.doRegister(
        firstNameController.text.toString(),
        lastNameController.text.toString(),
        emailController.text.toString(),
        phoneController.text.toString(),
        phoneCode,
        countryController.text.toString(),
        cityController.text.toString(),
        hospitalController.text.toString(),
        specialityController.text.toString(),
        projectCodeController.text.toString(),
        passwordController.text.toString(),
        confirmPasswordController.text.toString(),
      );
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      debugPrint("RESPONSE SCREEN - > $apiResponse");
      if (apiResponse.success == API_SUCCESS) {
        navigationPerform();
      } else {
        CommonWidget.showErrorMessage(
          apiResponse.message ?? 'Registration failed',
          context,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        CommonWidget.showErrorMessage(
          'An error occurred. Please try again.',
          context,
        );
      }
    }
  }

  void navigationPerform() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationScreen(
          from: INTENT_FROM_SIGN_UP,
          phone: phoneController.text.toString(),
          phoneCode: phoneCode,
        ),
      ),
    );
    // Navigator.pushNamed(context, VerificationScreen.route, arguments: {
    //   INTENT_FROM: INTENT_FROM_SIGN_UP,
    //   INTENT_PHONE: phoneController.text.toString(),
    //   INTENT_PHONE_CODE: phoneCode,
    // });
  }

  void getSpeciality(String specialityName, int specialityIndex) {
    specialityController.text = specialityName;
    specialityId = specialityIndex;
  }

  void _showCountryList(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      countryListTheme: CountryListThemeData(
        backgroundColor: Theme.of(context).cardColor,
        flagSize: 0,
        textStyle: appTextStyle.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.9,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        inputDecoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.search,
          hintText: AppLocalizations.of(context)!.start_type,
          prefixIcon: IconTheme(
            data: Theme.of(context).iconTheme,
            child: const Icon(Icons.search),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
      onSelect: (Country country) {
        debugPrint('Select country: ${country.name}');
        debugPrint('Select CODE: ${country.countryCode}');
        countryCodes = country.countryCode;
        setState(() {
          countryController.text = country.name;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: Theme.of(context).iconTheme,
          ),
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.register_account,
                          style: appTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        // FIRST_NAME
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.first_name,
                                style: appTextStyle.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                "*",
                                style: TextStyle(color: redColor),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          focusNode: firstNameFocusnode,
                          controller: firstNameController,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(
                              context,
                            )!.enter_first_name,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: themeBlueColor,
                              ),
                            ),
                            errorText: isFirstNameValid ? message : null,
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),

                        /// LAST NAME
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.last_name,
                                style: appTextStyle.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                "*",
                                style: TextStyle(color: redColor),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          focusNode: lastNameFocusnode,
                          controller: lastNameController,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(
                              context,
                            )!.enter_last_name,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: themeBlueColor,
                              ),
                            ),
                            errorText: isLastNameValid ? message : null,
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),

                        /// EMAIL
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.email,
                                style: appTextStyle.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                "*",
                                style: TextStyle(color: redColor),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          focusNode: emailFocusnode,
                          controller: emailController,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.enter_email,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: themeBlueColor,
                              ),
                            ),
                            errorText: isEmailValid ? message : null,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),

                        /// CONTACT NUMBER
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.contact_number,
                                style: appTextStyle.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                "*",
                                style: TextStyle(color: redColor),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 95,
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      CountryCodePicker(
                                        showFlag: false,
                                        initialSelection: phoneCode,
                                        onChanged: (value) {
                                          debugPrint(value.dialCode);
                                          phoneCode = value.dialCode!;
                                        },
                                        dialogSize: Size(
                                          MediaQuery.of(context).size.width *
                                              0.8,
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.arrow_drop_down),
                                  ),
                                  prefixIcon: CountryCodePicker(
                                    dialogBackgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                    showFlag: false,
                                    initialSelection: phoneCode,
                                    onChanged: (value) {
                                      debugPrint(value.dialCode);
                                      phoneCode = value.dialCode!;
                                    },
                                    dialogSize: Size(
                                      MediaQuery.of(context).size.width * 0.8,
                                      MediaQuery.of(context).size.height * 0.8,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
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
                                focusNode: phoneFocusnode,
                                controller: phoneController,
                                maxLines: 1,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(
                                    context,
                                  )!.enter_number,
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
                                  errorText: isPhoneValid ? message : null,
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ],
                        ),

                        /// COUNTRY NAME
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.country_name,
                                style: appTextStyle.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                "*",
                                style: TextStyle(color: redColor),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          focusNode: countryFocusnode,
                          controller: countryController,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(
                              context,
                            )!.enter_country,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: themeBlueColor,
                              ),
                            ),
                            suffixIcon: IconTheme(
                              data: Theme.of(context).iconTheme,
                              child: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 15,
                              ),
                            ),
                            errorText: isCountryValid ? message : null,
                          ),
                          onTap: () async {
                            _showCountryList(context);
                          },
                          readOnly: true,
                          showCursor: false,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.none,
                          textInputAction: TextInputAction.next,
                        ),

                        /// CITY NAME
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.city_name,
                                style: appTextStyle.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                "*",
                                style: TextStyle(color: redColor),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: cityController,
                          focusNode: cityFocusnode,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.enter_city,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: themeBlueColor,
                              ),
                            ),
                            errorText: isCitiValid ? message : null,
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),

                        /// HOSPITAL NAME
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.hospital_name,
                                style: appTextStyle.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                "*",
                                style: TextStyle(color: redColor),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: hospitalController,
                          focusNode: hospitalFocusnode,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(
                              context,
                            )!.enter_hospitalname,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: themeBlueColor,
                              ),
                            ),
                            errorText: ishospitalValid ? message : null,
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),

                        /// SPECIALITY
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.spefciality,
                                style: appTextStyle.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                "*",
                                style: TextStyle(color: redColor),
                              ),
                            ],
                          ),
                        ),

                        TextFormField(
                          readOnly: true,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              isDismissible: false,
                              backgroundColor: Colors.transparent,
                              builder: (context) => SpecialityBottomsheet(
                                list: registerViewModel.specialityData,
                                getSpeciality: getSpeciality,
                              ),
                            );
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(
                                context,
                              )!.please_enter_speciality;
                            }
                            return null;
                          },
                          controller: specialityController,
                          focusNode: specialityFocusnode,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(
                              context,
                            )!.enter_speciality,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: themeBlueColor,
                              ),
                            ),
                            errorText: isspecialityValid ? message : null,
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),
                        /* TextFormField(
                          controller: specialityController,
                          focusNode: specialityFocusnode,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.enter_speciality,
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
                            errorText: isspecialityValid ? message : null,
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),
*/
                        /// PROJECT CODE
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: Text(
                            AppLocalizations.of(context)!.project_code,
                            style: appTextStyle.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: projectCodeController,
                          focusNode: projectCodeFocusnode,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(
                              context,
                            )!.enter_projectcode,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: themeBlueColor,
                              ),
                            ),
                            // errorText: isProjectCodeValid ? message : null,
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),

                        /// PASSWORD
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.enter_password,
                                style: appTextStyle.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                "*",
                                style: TextStyle(color: redColor),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          focusNode: passwordFocusnode,
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: isPasswordVisible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              splashRadius: 20.0,
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              icon: IconTheme(
                                data: Theme.of(context).iconTheme,
                                child: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: themeBlueColor,
                                ),
                              ),
                            ),
                            hintText: AppLocalizations.of(
                              context,
                            )!.enter_password,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: themeBlueColor,
                              ),
                            ),
                            errorText: isPasswordValid ? message : null,
                          ),
                          textInputAction: TextInputAction.next,
                        ),

                        /// CONFIRM PASSWORD
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.confirm_password,
                                style: appTextStyle.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                "*",
                                style: TextStyle(color: redColor),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: confirmPasswordController,
                          focusNode: confirmPasswordFocusnode,
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              splashRadius: 20.0,
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordVisible =
                                      !isConfirmPasswordVisible;
                                });
                              },
                              icon: IconTheme(
                                data: Theme.of(context).iconTheme,
                                child: Icon(
                                  isConfirmPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: themeBlueColor,
                                ),
                              ),
                            ),
                            hintText: AppLocalizations.of(
                              context,
                            )!.enter_cpassword,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: themeBlueColor,
                              ),
                            ),
                            errorText: isConfirmPasswordValid ? message : null,
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(height: 10.0),

                        /// TERMS AND CONDITION
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 25,
                              width: 25,
                              child: Checkbox(
                                activeColor: themeBlueColor,
                                checkColor: Colors.white,
                                splashRadius: 20.0,
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: const BorderSide(
                                    width: 0.5,
                                    color: appTextBoxColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              // I_AGREE,
                              AppLocalizations.of(context)!.i_agree,
                              style: appTextStyle.copyWith(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all(
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  CMSPageScreen.route,
                                  arguments: {
                                    INTENT_CMS_PAGE: INTENT_TERMS_CONDITION,
                                  },
                                );
                              },
                              child: Text(
                                // TERMS_AND_CONDITION,
                                AppLocalizations.of(context)!.terms_condition,
                                style: appTextStyle.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: themeBlueColor,
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// CONSENT FORM
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 25,
                              width: 25,
                              child: Checkbox(
                                activeColor: themeBlueColor,
                                checkColor: Colors.white,
                                splashRadius: 20.0,
                                value: isConsent,
                                onChanged: (value) {
                                  setState(() {
                                    isConsent = value!;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: const BorderSide(
                                    width: 0.5,
                                    color: appTextBoxColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            TextButton(
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all(
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ConsentScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.i_consent,
                                style: appTextStyle.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: themeBlueColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                isValid();
                              },
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                                backgroundColor: WidgetStateProperty.all(
                                  themeBlueColor,
                                ),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.register,
                                style: appTextStyle.copyWith(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                // ALREADY_HAVE_ACCOUNT,
                                AppLocalizations.of(
                                  context,
                                )!.already_have_account,
                                style: appTextStyle.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  padding: WidgetStateProperty.all(
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  // LOGIN,
                                  AppLocalizations.of(context)!.log_in,
                                  style: appTextStyle.copyWith(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: themeBlueColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // if (registerViewModel.loading) const AppLoading()
        if (isLoading == true) const AppLoading(),
      ],
    );
  }
}

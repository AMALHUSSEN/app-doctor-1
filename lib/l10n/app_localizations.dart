import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @welcomeback.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeback;

  /// No description provided for @enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enter_password;

  /// No description provided for @enter_cpassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Confirm Password'**
  String get enter_cpassword;

  /// No description provided for @please_enter_mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter mobile number'**
  String get please_enter_mobile_number;

  /// No description provided for @please_enter_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get please_enter_password;

  /// No description provided for @please_enter_cpassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter confirm password'**
  String get please_enter_cpassword;

  /// No description provided for @please_enter_atlist_digit_passwor.
  ///
  /// In en, this message translates to:
  /// **'Please Enter atlist 5 Digit Password'**
  String get please_enter_atlist_digit_passwor;

  /// No description provided for @forgotpassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forgotpassword;

  /// No description provided for @resetpassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetpassword;

  /// No description provided for @resetpwdsubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please choose your new password'**
  String get resetpwdsubtitle;

  /// No description provided for @both_password_must_be_same.
  ///
  /// In en, this message translates to:
  /// **'Both Password Must Be Same'**
  String get both_password_must_be_same;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @verification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verification;

  /// No description provided for @verificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We have sent a verification code to your email address And mobile number'**
  String get verificationSubtitle;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @patient_details.
  ///
  /// In en, this message translates to:
  /// **'Patient\'s Details'**
  String get patient_details;

  /// No description provided for @patientdtsubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter the patient\'s Details'**
  String get patientdtsubtitle;

  /// No description provided for @please_enter_name.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Name'**
  String get please_enter_name;

  /// No description provided for @patient_name.
  ///
  /// In en, this message translates to:
  /// **'Patient Name'**
  String get patient_name;

  /// No description provided for @please_enter_id_number.
  ///
  /// In en, this message translates to:
  /// **'Please Enter ID Number'**
  String get please_enter_id_number;

  /// No description provided for @id_number.
  ///
  /// In en, this message translates to:
  /// **'ID number'**
  String get id_number;

  /// No description provided for @choose_country.
  ///
  /// In en, this message translates to:
  /// **'Choose country'**
  String get choose_country;

  /// No description provided for @please_select_city.
  ///
  /// In en, this message translates to:
  /// **'Please select City'**
  String get please_select_city;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @example_share.
  ///
  /// In en, this message translates to:
  /// **'Example share'**
  String get example_share;

  /// No description provided for @example_choose.
  ///
  /// In en, this message translates to:
  /// **'Example Chooser Title'**
  String get example_choose;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @in_process.
  ///
  /// In en, this message translates to:
  /// **'In Process'**
  String get in_process;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @project_name.
  ///
  /// In en, this message translates to:
  /// **'Project Name'**
  String get project_name;

  /// No description provided for @doctor_name.
  ///
  /// In en, this message translates to:
  /// **'Doctor Name'**
  String get doctor_name;

  /// No description provided for @doctor_email.
  ///
  /// In en, this message translates to:
  /// **'Doctor Email'**
  String get doctor_email;

  /// No description provided for @serial_no.
  ///
  /// In en, this message translates to:
  /// **'Serial Number'**
  String get serial_no;

  /// No description provided for @generated_on.
  ///
  /// In en, this message translates to:
  /// **'Generated on'**
  String get generated_on;

  /// No description provided for @exp_date.
  ///
  /// In en, this message translates to:
  /// **'Exp.Date'**
  String get exp_date;

  /// No description provided for @voucher.
  ///
  /// In en, this message translates to:
  /// **'Voucher'**
  String get voucher;

  /// No description provided for @my_list.
  ///
  /// In en, this message translates to:
  /// **'My List'**
  String get my_list;

  /// No description provided for @welcometosmarthealth.
  ///
  /// In en, this message translates to:
  /// **'Welcome to SmartHealth'**
  String get welcometosmarthealth;

  /// No description provided for @homescreensubtitle.
  ///
  /// In en, this message translates to:
  /// **'We are here to facilitate best diagnosis for HCPs through funding extensive lab work for efficient treatment service for our patients'**
  String get homescreensubtitle;

  /// No description provided for @new_request.
  ///
  /// In en, this message translates to:
  /// **'New Request'**
  String get new_request;

  /// No description provided for @request_a_call.
  ///
  /// In en, this message translates to:
  /// **'Request A Call'**
  String get request_a_call;

  /// No description provided for @validate_voucher.
  ///
  /// In en, this message translates to:
  /// **'Validate voucher'**
  String get validate_voucher;

  /// No description provided for @smarthealth.
  ///
  /// In en, this message translates to:
  /// **'SmartHealth'**
  String get smarthealth;

  /// No description provided for @are_you_sure_you_want_to_logout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to Logout?'**
  String get are_you_sure_you_want_to_logout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @forgotpwdsubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your Email or Mobile Number associated with your account.'**
  String get forgotpwdsubtitle;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @certification.
  ///
  /// In en, this message translates to:
  /// **'Certification'**
  String get certification;

  /// No description provided for @i_certify.
  ///
  /// In en, this message translates to:
  /// **'I Certify'**
  String get i_certify;

  /// No description provided for @please_check_certify.
  ///
  /// In en, this message translates to:
  /// **'Please Check Certify'**
  String get please_check_certify;

  /// No description provided for @submit_request.
  ///
  /// In en, this message translates to:
  /// **'Submit Request'**
  String get submit_request;

  /// No description provided for @questionnaire.
  ///
  /// In en, this message translates to:
  /// **'Questionnaire'**
  String get questionnaire;

  /// No description provided for @questionnairesubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please select the questionnaire.'**
  String get questionnairesubtitle;

  /// No description provided for @selectproject.
  ///
  /// In en, this message translates to:
  /// **'Select Project'**
  String get selectproject;

  /// No description provided for @selectprojectsubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please select the project'**
  String get selectprojectsubtitle;

  /// No description provided for @selectservice.
  ///
  /// In en, this message translates to:
  /// **'Select Services'**
  String get selectservice;

  /// No description provided for @selectservicesubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please select the service'**
  String get selectservicesubtitle;

  /// No description provided for @upload_consent.
  ///
  /// In en, this message translates to:
  /// **'Upload Consent'**
  String get upload_consent;

  /// No description provided for @upload_new_consent.
  ///
  /// In en, this message translates to:
  /// **'Upload New Consent'**
  String get upload_new_consent;

  /// No description provided for @upload_consent_form.
  ///
  /// In en, this message translates to:
  /// **'Upload consent form'**
  String get upload_consent_form;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @validatevoucher.
  ///
  /// In en, this message translates to:
  /// **'Validate voucher'**
  String get validatevoucher;

  /// No description provided for @validatevouchersubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter serial number or scan qr code'**
  String get validatevouchersubtitle;

  /// No description provided for @please_enter_serial_number.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Serial Number'**
  String get please_enter_serial_number;

  /// No description provided for @scan_qr_code.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scan_qr_code;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @barcode_type.
  ///
  /// In en, this message translates to:
  /// **'Barcode Type'**
  String get barcode_type;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @scan_n_code.
  ///
  /// In en, this message translates to:
  /// **'Scan a Code'**
  String get scan_n_code;

  /// No description provided for @requestacall.
  ///
  /// In en, this message translates to:
  /// **'Request A Call'**
  String get requestacall;

  /// No description provided for @yourconcern.
  ///
  /// In en, this message translates to:
  /// **'Your concern'**
  String get yourconcern;

  /// No description provided for @please_enter_your_concern.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Concern'**
  String get please_enter_your_concern;

  /// No description provided for @enter_your_concern_here.
  ///
  /// In en, this message translates to:
  /// **'Enter your concern here'**
  String get enter_your_concern_here;

  /// No description provided for @choose_option.
  ///
  /// In en, this message translates to:
  /// **'Choose Option'**
  String get choose_option;

  /// No description provided for @photo_library.
  ///
  /// In en, this message translates to:
  /// **'Photo Library'**
  String get photo_library;

  /// No description provided for @pdf.
  ///
  /// In en, this message translates to:
  /// **'PDF'**
  String get pdf;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @please_select_one_questionnaire.
  ///
  /// In en, this message translates to:
  /// **'Please select atleast one Questionnaire'**
  String get please_select_one_questionnaire;

  /// No description provided for @country_name.
  ///
  /// In en, this message translates to:
  /// **'Country Name'**
  String get country_name;

  /// No description provided for @city_name.
  ///
  /// In en, this message translates to:
  /// **'City Name'**
  String get city_name;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @downloaded_sussfully.
  ///
  /// In en, this message translates to:
  /// **'File Downloaded Successfully'**
  String get downloaded_sussfully;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @terms_condition.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get terms_condition;

  /// No description provided for @i_certify_the_approval.
  ///
  /// In en, this message translates to:
  /// **'I Certify the Approval'**
  String get i_certify_the_approval;

  /// No description provided for @please_check_i_certify.
  ///
  /// In en, this message translates to:
  /// **'Please check I Certify.'**
  String get please_check_i_certify;

  /// No description provided for @register_now.
  ///
  /// In en, this message translates to:
  /// **'Register now'**
  String get register_now;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_account;

  /// No description provided for @register_account.
  ///
  /// In en, this message translates to:
  /// **'Register Account'**
  String get register_account;

  /// No description provided for @first_name.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get first_name;

  /// No description provided for @enter_first_name.
  ///
  /// In en, this message translates to:
  /// **'Enter First Name'**
  String get enter_first_name;

  /// No description provided for @last_name.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get last_name;

  /// No description provided for @enter_last_name.
  ///
  /// In en, this message translates to:
  /// **'Enter Last Name'**
  String get enter_last_name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enter_email.
  ///
  /// In en, this message translates to:
  /// **'Enter Email'**
  String get enter_email;

  /// No description provided for @spefciality.
  ///
  /// In en, this message translates to:
  /// **'Speciality'**
  String get spefciality;

  /// No description provided for @select_spefciality.
  ///
  /// In en, this message translates to:
  /// **'Select Speciality'**
  String get select_spefciality;

  /// No description provided for @hospital_name.
  ///
  /// In en, this message translates to:
  /// **'Hospital name'**
  String get hospital_name;

  /// No description provided for @select_hospital_name.
  ///
  /// In en, this message translates to:
  /// **'Select Hospital name'**
  String get select_hospital_name;

  /// No description provided for @project_code.
  ///
  /// In en, this message translates to:
  /// **'Project Code'**
  String get project_code;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @i_agree.
  ///
  /// In en, this message translates to:
  /// **'I agree the'**
  String get i_agree;

  /// No description provided for @contact_number.
  ///
  /// In en, this message translates to:
  /// **'Contact Number'**
  String get contact_number;

  /// No description provided for @enter_number.
  ///
  /// In en, this message translates to:
  /// **'5XXXXXXXXXX'**
  String get enter_number;

  /// No description provided for @enter_country.
  ///
  /// In en, this message translates to:
  /// **'Enter Country'**
  String get enter_country;

  /// No description provided for @enter_city.
  ///
  /// In en, this message translates to:
  /// **'Enter City'**
  String get enter_city;

  /// No description provided for @enter_hospitalname.
  ///
  /// In en, this message translates to:
  /// **'Enter HospitalName'**
  String get enter_hospitalname;

  /// No description provided for @enter_speciality.
  ///
  /// In en, this message translates to:
  /// **'Enter Speciality'**
  String get enter_speciality;

  /// No description provided for @enter_projectcode.
  ///
  /// In en, this message translates to:
  /// **'Enter Project Code'**
  String get enter_projectcode;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @please_enter_first_name.
  ///
  /// In en, this message translates to:
  /// **'Please Enter First Name'**
  String get please_enter_first_name;

  /// No description provided for @please_enter__last_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter last name'**
  String get please_enter__last_name;

  /// No description provided for @please_enter_phone.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone'**
  String get please_enter_phone;

  /// No description provided for @please_enter_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter email'**
  String get please_enter_email;

  /// No description provided for @please_enter_valid_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid email'**
  String get please_enter_valid_email;

  /// No description provided for @please_enter_project_code.
  ///
  /// In en, this message translates to:
  /// **'Please enter project code'**
  String get please_enter_project_code;

  /// No description provided for @please_enter_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter confirm password'**
  String get please_enter_confirm_password;

  /// No description provided for @confrim_password_not_match.
  ///
  /// In en, this message translates to:
  /// **'Confirm password doesn’t match with password'**
  String get confrim_password_not_match;

  /// No description provided for @please_select_country.
  ///
  /// In en, this message translates to:
  /// **'Please Select Country'**
  String get please_select_country;

  /// No description provided for @please_enter_city.
  ///
  /// In en, this message translates to:
  /// **'Please enter City'**
  String get please_enter_city;

  /// No description provided for @please_enter_hospital_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter Hospital name'**
  String get please_enter_hospital_name;

  /// No description provided for @please_enter_speciality.
  ///
  /// In en, this message translates to:
  /// **'Please enter Speciality'**
  String get please_enter_speciality;

  /// No description provided for @please_agree_to_the_terms_and_condition.
  ///
  /// In en, this message translates to:
  /// **'Please agree to the Terms and Conditions'**
  String get please_agree_to_the_terms_and_condition;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_account;

  /// No description provided for @log_in.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get log_in;

  /// No description provided for @start_type.
  ///
  /// In en, this message translates to:
  /// **'Start typing to search'**
  String get start_type;

  /// No description provided for @please_enter_verification_code.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Verification Code'**
  String get please_enter_verification_code;

  /// No description provided for @from_drive.
  ///
  /// In en, this message translates to:
  /// **'Drive'**
  String get from_drive;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @downloaded_successfully.
  ///
  /// In en, this message translates to:
  /// **'File Downloaded Successfully'**
  String get downloaded_successfully;

  /// No description provided for @no_voucher_found.
  ///
  /// In en, this message translates to:
  /// **'No Voucher found'**
  String get no_voucher_found;

  /// No description provided for @consent_form.
  ///
  /// In en, this message translates to:
  /// **'Consent Form'**
  String get consent_form;

  /// No description provided for @plaese_sign_consent.
  ///
  /// In en, this message translates to:
  /// **'Please sign the Consent form.'**
  String get plaese_sign_consent;

  /// No description provided for @i_consent.
  ///
  /// In en, this message translates to:
  /// **'I consent'**
  String get i_consent;

  /// No description provided for @no_patient_detail.
  ///
  /// In en, this message translates to:
  /// **'Voucher cannot be generated because there is no patient details'**
  String get no_patient_detail;

  /// No description provided for @please_upload_consent_form.
  ///
  /// In en, this message translates to:
  /// **'Please upload the consent form'**
  String get please_upload_consent_form;

  /// No description provided for @no_questionnaire_found.
  ///
  /// In en, this message translates to:
  /// **'No questionnaire found'**
  String get no_questionnaire_found;

  /// No description provided for @choose_from.
  ///
  /// In en, this message translates to:
  /// **'Choose from'**
  String get choose_from;

  /// No description provided for @consent.
  ///
  /// In en, this message translates to:
  /// **'Consent'**
  String get consent;

  /// No description provided for @signature.
  ///
  /// In en, this message translates to:
  /// **'Signature'**
  String get signature;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @please_add_signature.
  ///
  /// In en, this message translates to:
  /// **'Please add signature'**
  String get please_add_signature;

  /// No description provided for @please_select_birthdate.
  ///
  /// In en, this message translates to:
  /// **'Please select birthdate'**
  String get please_select_birthdate;

  /// No description provided for @select_birth_date.
  ///
  /// In en, this message translates to:
  /// **'Select birth date'**
  String get select_birth_date;

  /// No description provided for @birth_date.
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get birth_date;

  /// No description provided for @reupload_consent.
  ///
  /// In en, this message translates to:
  /// **'Re-upload consent'**
  String get reupload_consent;

  /// No description provided for @please_upload_consent.
  ///
  /// In en, this message translates to:
  /// **'Please upload consent'**
  String get please_upload_consent;

  /// No description provided for @please_provide_camera_permission.
  ///
  /// In en, this message translates to:
  /// **'SmartHealth needs to access camera to upload consent, Please go to app settings and provide camera permission.'**
  String get please_provide_camera_permission;

  /// No description provided for @cookies_policy.
  ///
  /// In en, this message translates to:
  /// **'Cookies Policy'**
  String get cookies_policy;

  /// No description provided for @add_new_file.
  ///
  /// In en, this message translates to:
  /// **'Add New Consent'**
  String get add_new_file;

  /// No description provided for @would_you_like_to_add_new_file.
  ///
  /// In en, this message translates to:
  /// **'Would you like to add new file'**
  String get would_you_like_to_add_new_file;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @technical_issue.
  ///
  /// In en, this message translates to:
  /// **'Technical Issue'**
  String get technical_issue;

  /// No description provided for @are_you_sure_you_want_to_submit_technical_issue_request.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to submit technical support request ?'**
  String get are_you_sure_you_want_to_submit_technical_issue_request;

  /// No description provided for @request_support.
  ///
  /// In en, this message translates to:
  /// **'Request Support'**
  String get request_support;

  /// No description provided for @thank_you_support.
  ///
  /// In en, this message translates to:
  /// **'Thank you, your request under is process'**
  String get thank_you_support;

  /// No description provided for @new_app_version.
  ///
  /// In en, this message translates to:
  /// **'New Version'**
  String get new_app_version;

  /// No description provided for @for_better_use.
  ///
  /// In en, this message translates to:
  /// **'To improve your experience, please update the application'**
  String get for_better_use;

  /// No description provided for @update_now.
  ///
  /// In en, this message translates to:
  /// **'Update Now'**
  String get update_now;

  /// No description provided for @navigate_to_website.
  ///
  /// In en, this message translates to:
  /// **'Navigate To website'**
  String get navigate_to_website;

  /// No description provided for @would_you_like_to_go_to_website.
  ///
  /// In en, this message translates to:
  /// **'Would you like to go to the website'**
  String get would_you_like_to_go_to_website;

  /// No description provided for @link_not_valid.
  ///
  /// In en, this message translates to:
  /// **'Link not valid'**
  String get link_not_valid;

  /// No description provided for @you_are_now_leaving.
  ///
  /// In en, this message translates to:
  /// **'You are now leaving the SmartHealth HCP App!'**
  String get you_are_now_leaving;

  /// No description provided for @this_link_will_take_you.
  ///
  /// In en, this message translates to:
  /// **'This link will take you to a website to which our'**
  String get this_link_will_take_you;

  /// No description provided for @does_not_apply.
  ///
  /// In en, this message translates to:
  /// **'does not apply. You are solely responsible for your interactions with that website.'**
  String get does_not_apply;

  /// No description provided for @continue_btn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_btn;

  /// No description provided for @please_enter_last_name.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Last Name'**
  String get please_enter_last_name;

  /// No description provided for @speciality_name.
  ///
  /// In en, this message translates to:
  /// **'Speciality name'**
  String get speciality_name;

  /// No description provided for @service_not_available.
  ///
  /// In en, this message translates to:
  /// **'Service is not available'**
  String get service_not_available;

  /// No description provided for @license.
  ///
  /// In en, this message translates to:
  /// **'License'**
  String get license;

  /// No description provided for @licenses.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licenses;

  /// No description provided for @license_status.
  ///
  /// In en, this message translates to:
  /// **'License Status'**
  String get license_status;

  /// No description provided for @license_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get license_active;

  /// No description provided for @license_expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get license_expired;

  /// No description provided for @license_suspended.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get license_suspended;

  /// No description provided for @license_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get license_cancelled;

  /// No description provided for @license_plan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get license_plan;

  /// No description provided for @license_expires_on.
  ///
  /// In en, this message translates to:
  /// **'Expires on'**
  String get license_expires_on;

  /// No description provided for @license_days_remaining.
  ///
  /// In en, this message translates to:
  /// **'days remaining'**
  String get license_days_remaining;

  /// No description provided for @license_auto_renew.
  ///
  /// In en, this message translates to:
  /// **'Auto Renew'**
  String get license_auto_renew;

  /// No description provided for @license_patients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get license_patients;

  /// No description provided for @license_doctors.
  ///
  /// In en, this message translates to:
  /// **'Doctors'**
  String get license_doctors;

  /// No description provided for @license_voucher_services.
  ///
  /// In en, this message translates to:
  /// **'Voucher Services'**
  String get license_voucher_services;

  /// No description provided for @license_no_licenses.
  ///
  /// In en, this message translates to:
  /// **'No licenses found'**
  String get license_no_licenses;

  /// No description provided for @license_expiring_soon.
  ///
  /// In en, this message translates to:
  /// **'License expiring soon!'**
  String get license_expiring_soon;

  /// No description provided for @license_expired_warning.
  ///
  /// In en, this message translates to:
  /// **'Project license has expired. Please contact your administrator.'**
  String get license_expired_warning;

  /// No description provided for @license_of.
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get license_of;

  /// No description provided for @license_unlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get license_unlimited;

  /// No description provided for @step_in_progress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get step_in_progress;

  /// No description provided for @step_sample_collection.
  ///
  /// In en, this message translates to:
  /// **'Sample Collection'**
  String get step_sample_collection;

  /// No description provided for @step_send_out.
  ///
  /// In en, this message translates to:
  /// **'Send Out'**
  String get step_send_out;

  /// No description provided for @step_results_available.
  ///
  /// In en, this message translates to:
  /// **'Results Available'**
  String get step_results_available;

  /// No description provided for @step_sent_to_doctor.
  ///
  /// In en, this message translates to:
  /// **'Sent to Doctor'**
  String get step_sent_to_doctor;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

// Success

// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import '../services/remote_config_service.dart';

const SUCCESS = 200;

// Errors
const USER_INVALID_RESPONSE = 100;
const NO_INTERNET = 101;
const INVALID_FORMAT = 102;
const UNKNOWN_ERROR = 103;

const API_SUCCESS = 1;
const API_FAIL = 0;
const API_UNVERIFIED = 2;

// Api URLs - Dynamic based on Firebase Remote Config
String get BASE_URL => RemoteConfigService().apiBaseUrl;

String get LOGIN_API => "${BASE_URL}login";

String get REGISTER => "${BASE_URL}signup";

String get VERIFICATION_API => "${BASE_URL}forgot-password/verify";

String get UPDATE_PROFILE => "${BASE_URL}auth/update-user";

String get HOMESCREEN_API => "${BASE_URL}auth/home";

String get GET_PROJECTS_API => '${BASE_URL}auth/projects';

String get MY_LIST_API => '${BASE_URL}auth/my-list';

String get GET_REQUEST_A_CALL_API => '${BASE_URL}auth/contacts';

String get COUNTRIES_API => '${BASE_URL}country';

String get CITIES_API => '${BASE_URL}city';

String get LOGOUT_API => "${BASE_URL}auth/logout";

String get FORGOTPASS_API => "${BASE_URL}forgot-password";

String get RESETPASS_API => "${BASE_URL}forgot-password";

String get RESEND_OTP_API => "${BASE_URL}resend/verification-code";

String get CHANGE_PASSWORD => "${BASE_URL}auth/change_password";

String get GET_USER_DETAILS => "${BASE_URL}auth/user";

String get PATIENT_REG_API => "${BASE_URL}auth/registrations";

String get SCAN_QRCODE_API => "${BASE_URL}auth/scan";

String get PRIVACY_POLICY_API => "${BASE_URL}pages/privacy-policy";

String get COOKIES_API => "${BASE_URL}pages/cookies";

String get TERMS_CONDITION_API => "${BASE_URL}pages/terms";

String get APP_SETTING_API => "${BASE_URL}app-settings";

String get REGISTER_API => "${BASE_URL}registration";

String get REGISTER_VERIFICATION_API => "${BASE_URL}verify-code";

String get CONSENTFORM_API => "${BASE_URL}consent-form";

String get GET_QUESTIONNAIRE_API => '${BASE_URL}auth/questionnarie-option';

String get SUBMIT_QUESTIONNAIRE_API => '${BASE_URL}auth/options';

String get CHECK_VOUCHER_API => '${BASE_URL}auth/check-voucher';

String get PROJECT_CONSENT_DETAIL_API => "${BASE_URL}project-details";

String get CONSENT_SUBMIT_API => "${BASE_URL}project-consent";

String get RE_UPLOAD_CONSENT_API => "${BASE_URL}auth/reupload-consent";

String get UPLOAD_NEW_CONSENT_API => "${BASE_URL}registrations/upleodImageRegistration";

String get APP_VERSION_API => "${BASE_URL}version-apps";

String get GET_BLOCK_PROJECTS_API => '${BASE_URL}auth/BlockProject';

String get SPECIALITY_API => '${BASE_URL}specialitie';

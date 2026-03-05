// ignore_for_file: constant_identifier_names

// import 'package:hatch_app/model/AuthActivityModel/auth_model_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

const AGORA_APP_ID = "66bdc21baf134bdc86605ba4848463e3";
// const AGORA_TOKEN =
//     "00666bdc21baf134bdc86605ba4848463e3IACHi1pgcU8N1vBBBGMqRFDDyi5mmQ20MiZiKJQD6xndXgx+f9gAAAAAEAANqJukUp1XYgEAAQBSnVdi";
const AGORA_TOKEN =
    "00666bdc21baf134bdc86605ba4848463e3IACOSLTuKKTZv48IQRugZ7iU9MyRWrnmkDjlID6XvDQkLJQzDCgAAAAAEAANqJukPqZXYgEAAQA+pldi";

class Shared {
  static SharedPreferences pref =
      SharedPreferences.getInstance() as SharedPreferences;
}

const FROM = "FROM";
const FROM_LOGIN = "FROM_LOGIN";
const FROM_SIGNUP = "FROM_SIGNUP";
const INTENT_EMAIL = "INTENT_EMAIL";
const INTENT_NAME = "INTENT_NAME";
const INTENT_PASWORD = "INTENT_PASWORD";
const INTENT_GENDER = "INTENT_GENDER";
const INTENT_BIRTHDATE = "INTENT_BIRTHDATE";
const INTENT_TAGS = "INTENT_TAGS";
const INTENT_AVATAR_ID = "INTENT_AVATAR_ID";
const INTENT_TAGS_MODEL = "INTENT_TAGS_MODEL";
const INTENT_EGG_COLOR_ID = "INTENT_EGG_COLOR_ID";
const INTENT_LOGIN_MODEL = "INTENT_LOGIN_MODEL";

// SharedPref
const PREF_USER_PHONE = 'PREF_USER_PHONE';
const PREF_IS_LOGGED_IN = "PREF_IS_LOGGED_IN";
const PREF_USER_ACCESS_TOKEN = "PREF_USER_ACCESS_TOKEN";
const USER_STATUS = "USER_STATUS";
const PREF_USER_ID = "PREF_USER_ID";
const PREF_USER_NAME = "PREF_USER_NAME";
const PREF_USER_AVATAR = "PREF_USER_AVATAR";
const PREF_USER_EMAIL = "PREF_USER_EMAIL";
const PREF_USER_BIRTHDATE = "PREF_USER_BIRTHDATE";
const PREF_USER_GENDER = "PREF_USER_GENDER";
const PREF_USER_EGG_COLOR = "PREF_USER_EGG_COLOR";
const PREF_IS_NOTIFICATION = "PREF_IS_NOTIFICATION";
const PREF_IS_PROFILE_COMPLETED = "PREF_IS_PROFILE_COMPLETED";
// const PREF_ACCESS_TOKEN = "Device_Token";
const PREF_LATITUDE = "PREF_LATITUDE";
const PREF_LONGITUDE = "PREF_LONGITUDE";
const SKIP_PATIENT_CITY = "SKIP_PATIENT_CITY";
const SKIP_PATIENT_COUNTRY = "SKIP_PATIENT_COUNTRY";
const SKIP_QUESTIONNAIRE = 'SKIP_QUESTIONNAIRE';
const VOUCHER_STRING = 'VOUCHER';
const SKIP_CONSENT = 'SKIP_CONSENT';
const SKIP_PATIENT_NAME = 'SKIP_PATIENT_NAME';
const SKIP_PATIENT_ID = 'SKIP_PATIENT_ID';
const SKIP_SHARE_VOUCHER = 'SKIP_SHARE_VOUCHER';
const DISABLE_REDEEM_VOUCHER = 'DISABLE_REDEEM_VOUCHER';
const DISABLE_REQUEST_CALL = 'DISABLE_REQUEST_CALL';
const PROJECT_NAME = 'PROJECT_NAME';
const SKIP_PATIENT_DETAILS = 'SKIP_PATIENT_DETAILS';

const PREF_USER_FIRST_NAME = "PREF_USER_FIRST_NAME";
const PREF_USER_LAST_NAME = "PREF_USER_LAST_NAME";
const PREF_USER_COUNTRY = "PREF_USER_COUNTRY";
const PREF_USER_COUNTRY_CODE = "PREF_USER_COUNTRY_CODE";
const PREF_USER_CITY = "PREF_USER_CITY";
const PREF_USER_HOSPITAL_NAME = "PREF_USER_HOSPITAL_NAME";
const PREF_USER_SPECIALITY = "PREF_USER_SPECIALITY";
const PREF_USER_PROJECT_CODE = "PREF_USER_PROJECT_CODE";

const PREF_LICENSE_STATUS = "PREF_LICENSE_STATUS";
const PREF_LICENSE_DAYS_REMAINING = "PREF_LICENSE_DAYS_REMAINING";
const PREF_LICENSE_PLAN_NAME = "PREF_LICENSE_PLAN_NAME";

const PREF_FCM_TOKEN = "PREF_FCM_TOKEN";
const PREF_CURRENT_LANGUAGE = "PREF_CURRENT_LANGUAGE";

// getLikeCount() {
//   return Shared.pref.getInt(LIKE_COUNT) ?? 0;
// }

// String getChatEndTime() {
//   return Shared.pref.getString(CHAT_END_TIME) ?? '';
// }

// Future<void> setChatEndTime(String value) async {
//   await Shared.pref.setString(CHAT_END_TIME, value);
// }

// Future<void> setLiveChatPrefs(
//     {required int receiverId,
//     required String receiverName,
//     required String receiverImage,
//     required String chatConvId}) async {
//   await Shared.pref.setInt(RECEIVER_ID, receiverId);
//   await Shared.pref.setString(RECEIVER_IMG, receiverImage);
//   await Shared.pref.setString(RECEIVER_NAME, receiverName);
//   await Shared.pref.setString(CHAT_CONV_ID, chatConvId);
// }

Future<void> clearLiveChatPref() async {
  // await Shared.pref.remove(RECEIVER_ID);
  // await Shared.pref.remove(RECEIVER_IMG);
  // await Shared.pref.remove(RECEIVER_NAME);
  // await Shared.pref.remove(CHAT_END_TIME);
}

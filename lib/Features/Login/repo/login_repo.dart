import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/utils/platform_utils.dart';
import 'package:http/http.dart' as http;
import 'package:smarthealth_hcp/Features/Login/model/LoginResponse/login_response.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';

class LoginService {
  static Future<Object> loginAPICall(
      String phoneCode, String username, String password) async {
    try {
      Map request = {
        'username': username,
        'password': password,
        'country_code': phoneCode,
        'device_token': Shared.pref.getString(PREF_FCM_TOKEN),
        'device_type': PlatformUtils.isAndroid ? '1' : '2',
      };
      var url =
          "$LOGIN_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("LoginApi-> $url");
      debugPrint("LoginService REQUEST-> $request");
      var response = await http.post(Uri.parse(url), body: request);
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body---> ${response.body}");
        return Success(response: LoginResponse.fromJson(response.body));
      }
      return Failure(
          code: USER_INVALID_RESPONSE,
          errorResponse: "Oops! Something went wrong");
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: "No Internet Connection");
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: "No Internet Connection");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      debugPrint("LOGIN_ERROR--> $e");
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown Error-->$e");
    }
  }

  
}

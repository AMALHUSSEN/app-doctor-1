import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/Features/ForgotPassword/model/forgot_password_response/forgot_password_response.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordService {
  static Future<Object> forgotPasswordAPICall(
      String phone, String phoneCode) async {
    try {
      Map request = {'username': phone, 'country_code': phoneCode};
      var url =
          "$FORGOTPASS_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("Forgot password Api---> $url");
      debugPrint("ForgotPassService REQUEST-> $request");
      var response = await http.post(Uri.parse(url), body: request);
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");
      if (response.statusCode == 200) {
        debugPrint("Response body---> ${response.body}");
        return Success(
            response: ForgotPasswordResponse.fromJson(response.body));
      }
      return Failure(
          code: USER_INVALID_RESPONSE,
          errorResponse: 'Oops! Something went wrong.');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }
}

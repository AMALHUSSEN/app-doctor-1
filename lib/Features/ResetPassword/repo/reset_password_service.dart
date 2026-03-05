import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smarthealth_hcp/Features/ResetPassword/model/reset_pass_request.dart';
import 'package:smarthealth_hcp/Features/ResetPassword/model/reset_password_response/reset_password_response.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';

import '../../../api_commons/api_status.dart';

class ResetPassService {
  static Future<Object> callResetPasswordApi(
      ResetPassRequest resetPassRequest) async {
    try {
      var url =
          "$RESETPASS_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("Reset password Api---> $url");
      // debugPrint("ResetPassService REQUEST-> ${jsonEncode(resetPassRequest)}");
      var request = {
        'username': resetPassRequest.username,
        'password': resetPassRequest.password,
        'password_confirmation': resetPassRequest.password_confirmation
      };
      debugPrint("Response body---> $request");
      var response = await http.put(Uri.parse(url), body: request);
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body---> ${response.body}");
        return Success(response: ResetPasswordResponse.fromJson(response.body));
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

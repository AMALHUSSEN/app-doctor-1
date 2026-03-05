import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smarthealth_hcp/Features/RequestCall/model/request_a_call_response_model/request_a_call_response_model/request_a_call_response_model.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';

class RequestACallService {
  static Future<Object> requestCallApi(String message) async {
    try {

      var url =
          "$GET_REQUEST_A_CALL_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("REQUEST CALL API-> $url");
      // debugPrint("REQUEST CAL REQUEST-> $request");
      var response = await http.post(Uri.parse(url),
          headers: {
            "Authorization":
                "Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}"
          },);
      debugPrint("REQUEST CAL Status Code---> ${response.statusCode}");
      debugPrint("REQUEST CAL Response body---> ${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body---> ${response.body}");
        return Success(response: RequestACallResponse.fromJson(response.body));
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
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown Error");
    }
  }
}

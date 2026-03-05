import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smarthealth_hcp/Features/License/model/license_response/license_response.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';

class LicenseService {
  static Future<Object> getLicenses() async {
    try {
      var url =
          "$LICENSE_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("Get Licenses Api-> $url");
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization':
            'Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}',
      });
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body---> ${response.body}");
        return Success(response: LicenseResponse.fromJson(response.body));
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
      debugPrint("LICENSE_ERROR---> $e");
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown Error");
    }
  }
}

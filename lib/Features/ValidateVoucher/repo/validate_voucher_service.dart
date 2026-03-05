import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smarthealth_hcp/Features/ValidateVoucher/model/validate_voucher_response/validate_voucher_response.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';

class ValidateVoucherService {
  static Future<Object> validateVoucher(String id) async {
    try {
      var url =
          '$SCAN_QRCODE_API/$id?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}';
      debugPrint("Scan qrcode Api-> $url");
      debugPrint("Token ---> ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}");
      var response = await http.post(Uri.parse(url), headers: {
        'Authorization':
            'Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}',
      });
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body---> ${response.body}");
        return Success(
            response: ValidateVoucherResponse.fromJson(response.body));
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

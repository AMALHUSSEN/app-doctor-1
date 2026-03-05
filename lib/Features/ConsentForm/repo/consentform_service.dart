// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:smarthealth_hcp/Features/ConsentForm/model/ConsentFormResponseBean/consent_form_response_bean.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';

class ConsentFormService {
  static Future<Object> getConsentFormServiceCall() async {
    try {
      var url;
      url =
          "$CONSENTFORM_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("CONSENTFORM_API --> $url");

      var response = await http.get(Uri.parse(url));
      debugPrint("CONSENTFORM RESPONSE--> ${response.body}");
      debugPrint("CONSENTFORM RESPONSE_CODE--> ${response.statusCode}");
      if (SUCCESS == response.statusCode) {
        debugPrint("CONSENTFORM RESPONSE--> ${response.body}");
        return Success(
            response: ConsentFormResponseBean.fromJson(response.body));
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Respnse');
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

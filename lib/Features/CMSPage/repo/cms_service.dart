// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:smarthealth_hcp/Features/CMSPage/model/cms_response/cms_response.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/intent_const.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';

class CMSPageService {
  static Future<Object> getCMSPageServiceCall(String cmsType) async {
    try {
      var url;
      if (cmsType == INTENT_TERMS_CONDITION) {
        url =
        "$TERMS_CONDITION_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      } else if(cmsType == INTENT_COOKIES_POLICY) {
        url =
        "$COOKIES_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      }else {
        url =
        "$PRIVACY_POLICY_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      }
      debugPrint("cmspageService API --> $url");

      var response = await http.get(Uri.parse(url));
      debugPrint("cmspageService RESPONSE--> ${response.body}");
      debugPrint("cmspageService RESPONSE_CODE--> ${response.statusCode}");
      if (SUCCESS == response.statusCode) {
        debugPrint("cmspageService RESPONSE--> ${response.body}");
        return Success(response: CmsResponse.fromJson(response.body));
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

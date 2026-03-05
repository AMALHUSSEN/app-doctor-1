// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:smarthealth_hcp/Features/ProjectConsent/model/project_consent_detail_response/project_consent_detail_response.dart';
import 'package:smarthealth_hcp/Features/ProjectConsent/model/submit_consent_response/submit_consent_response.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';

class ProjectConsentService {
  static Future<Object> getProjectDetail(String userId) async {
    try {
      var url =
          "$PROJECT_CONSENT_DETAIL_API/$userId?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("PROJECT_CONSENT_DETAIL_API -> $url");
      debugPrint(
          "PROJECT_CONSENT_DETAIL_API Token ---> ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}");
      var response = await http.get(Uri.parse(url));
      debugPrint(
          "PROJECT_CONSENT_DETAIL_API Status Code---> ${response.statusCode}");
      debugPrint(
          "PROJECT_CONSENT_DETAIL_API Response body---> ${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body---> ${response.body}");
        return Success(
            response: ProjectConsentDetailResponse.fromJson(response.body));
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
      debugPrint("PROJECT_CONSENT_DETAIL_API ERROR--> $e");
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown Error");
    }
  }

  static Future<Object> submitConsent(int pivotId, String signature) async {
    try {
      var request;
      Map<String, String> headers = {};
      var uri = Uri.parse(
          "$CONSENT_SUBMIT_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}");
      debugPrint("CONSENT_SUBMIT_API REQUEST_API--> $uri");
      request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath(""
          'signature', signature.toString(),
          contentType: http_parser.MediaType('signature', 'jpg')));
      request.fields['pivot_id'] = pivotId.toString();

      debugPrint("FILE: --> ${request.files}");
      debugPrint("FIELD: --> ${request.fields}");

      // headers = {
      //   // "Authorization": "Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}",
      //   "Content-type": "multipart/form-data"
      // };
      request.headers.addAll(headers);
      debugPrint("CONSENT_SUBMIT_API REQUEST: --> ${request.files}");
      var res = await request.send();
      debugPrint("CONSENT_SUBMIT_API This is response: -> ${res.statusCode}");
      final response = await res.stream.bytesToString();
      debugPrint("CONSENT_SUBMIT_API This is responseString: -> $response");
      if (SUCCESS == res.statusCode) {
        debugPrint("DoctorConsent RESPONSE--> $response");
        return Success(
            response: SubmitConsentResponse.fromJson(response.toString()));
      }

      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
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

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:smarthealth_hcp/Features/Login/model/LoginResponse/login_response.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/SubmitQuestionnaireResponse/submit_question_response.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/check_voucher_response.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/get_projects_response_model/get_projects_response_model.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/questionnaire_response_bean/questionnaire_response_bean.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/re_upload_consent_response/re_upload_consent_response.dart';
import 'package:smarthealth_hcp/Features/new_consent_upload/new_consent_responce.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';

class SelectProjectService {
  static Future<Object> getProjects() async {
    try {
      var url =
          "$GET_PROJECTS_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("Get Projects Api-> $url");
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization':
            'Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}',
      });
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body---> ${response.body}");
        return Success(response: ProjectsResponse.fromJson(response.body));
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

  static Future<Object> getQuestionnaireList(int id) async {
    try {
      var url =
          "$GET_QUESTIONNAIRE_API/$id?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("getQuestionnaireList Api-> $url");
      debugPrint(
          "Projects TOKEN-> ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}");
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization':
            'Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}',
      });
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("getQuestionnaireList Response body---> ${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("getQuestionnaireList Response body---> ${response.body}");
        return Success(response: QuestionnaireResponse.fromJson(response.body));
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
      debugPrint("QUESTIONNAIRE_ERROR---> $e");
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown Error");
    }
  }

  static Future<Object> submitQuestion(int id, List<dynamic> questions) async {
    try {
      debugPrint("submitQuestion questions--> ${questions.length}");
      debugPrint("submitQuestion questions--> $questions");
      Map request = {};
      for (var i = 0; i < questions.length; i++) {
        request.addAll({'questions[$i]': jsonEncode(questions[i])});
      }
      var url = "$SUBMIT_QUESTIONNAIRE_API/$id";
      debugPrint("submitQuestion REQUEST_API--> $url");
      debugPrint("submitQuestion REQUEST--> ${json.encode(request)}");
      var response = await http.post(Uri.parse(url),
          // body: json.encode(request),
          body: request,
          headers: {
            "Authorization":
                "Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)!}"
          });
      debugPrint("submitQuestion STATUS_CODE--> ${response.statusCode}");
      debugPrint("submitQuestion RESPONSE--> ${response.body}");
      if (SUCCESS == response.statusCode) {
        debugPrint("submitQuestion RESPONSE--> ${response.body}");
        return Success(
            response: SubmitQuestionResponse.fromJson(response.body));
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Interbet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      debugPrint("submitQuestion ERROR--> $e");
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }

  static Future<Object> checkVoucher(int id) async {
    try {
      var url =
          "$CHECK_VOUCHER_API/$id?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("checkVoucher Api-> $url");
      debugPrint(
          "Projects TOKEN-> ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}");
      var response = await http.post(Uri.parse(url), headers: {
        'Authorization':
            'Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}',
      });
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("checkVoucher Response body---> ${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("checkVoucher Response body---> ${response.body}");
        return Success(response: CheckVoucherResponse.fromJson(response.body));
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
      debugPrint("CHECK_VOUCHER_ERROR---> $e");
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown Error");
    }
  }

  static Future<Object> reUploadConsent(int id, String consent) async {
    try {
      http.MultipartRequest request;
      Map<String, String> headers = {};
      var uri = Uri.parse(
          "$RE_UPLOAD_CONSENT_API/$id?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}");
      debugPrint("RE_UPLOAD_CONSENT_API REQUEST_API--> $uri");
      request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath(
          'consent', consent.toString(),
          contentType: http_parser.MediaType('consent', 'jpg')));

      debugPrint("FILE: --> ${request.files}");

      headers = {
        "Authorization":
            "Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}",
        "Content-type": "multipart/form-data"
      };
      request.headers.addAll(headers);
      debugPrint("RE_UPLOAD_CONSENT_API REQUEST: --> ${request.files}");
      var res = await request.send();
      debugPrint(
          "RE_UPLOAD_CONSENT_API This is response: -> ${res.statusCode}");
      final response = await res.stream.bytesToString();
      debugPrint("RE_UPLOAD_CONSENT_API This is responseString: -> $response");
      if (SUCCESS == res.statusCode) {
        debugPrint("DoctorConsent RESPONSE--> $response");
        return Success(
            response: ReUploadConsentResponse.fromJson(response.toString()));
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
      debugPrint("RE_UPLOAD_CONSENT_API ERROR --> $e");
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }

  static Future<Object> uploadNewConsent(int id, String consent) async {
    try {
      http.MultipartRequest request;
      Map<String, String> headers = {};
      var uri = Uri.parse(
          "$UPLOAD_NEW_CONSENT_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}");
      debugPrint("RE_UPLOAD_CONSENT_API REQUEST_API--> $uri");
      request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath(
          'consents', consent.toString(),
          contentType: http_parser.MediaType('consents', 'pdf')));

      debugPrint("FILE: --> ${request.files}");
      request.fields["registration_id"] = id.toString();

      headers = {
        "Authorization":
        "Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}",
        "Content-type": "multipart/form-data"
      };
      request.headers.addAll(headers);
      debugPrint("RE_UPLOAD_CONSENT_API REQUEST: --> ${request.files}");
      var res = await request.send();
      debugPrint(
          "RE_UPLOAD_CONSENT_API This is response: -> ${res.statusCode}");
      final response = await res.stream.bytesToString();
      debugPrint("RE_UPLOAD_CONSENT_API This is responseString: -> $response");
      if (SUCCESS == res.statusCode) {
        debugPrint("DoctorConsent RESPONSE--> $response");
        return Success(
            response: NewConsentResponse.fromJson(json.decode(response)));
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
      debugPrint("RE_UPLOAD_CONSENT_API ERROR --> $e");
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }

  static Future<Object> getDoctorData() async {
    try {
      var url =
          "$GET_USER_DETAILS?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("Get Projects Api-> $url");
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization':
        'Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}',
      });
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
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown Error");
    }
  }



}

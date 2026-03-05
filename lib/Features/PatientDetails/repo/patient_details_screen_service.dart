import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:smarthealth_hcp/Features/PatientDetails/models/city_list_response_model/city_list_response_model.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/models/country_list_response_model/country_list_response_model.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/models/patient_registration_response/patient_registration_response.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';

class PatientDetailsService {
  static Future<Object> getCities() async {
    try {
      var url =
          "$CITIES_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("Cities Api-> $url");
      var response = await http.get(Uri.parse(url));
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body---> ${response.body}");
        return Success(response: CityListResponse.fromJson(response.body));
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

  static Future<Object> getCountries() async {
    try {
      var url =
          "$COUNTRIES_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("Cities Api-> $url");
      var response = await http.get(Uri.parse(url));
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body---> ${response.body}");
        return Success(response: CountryListResponse.fromJson(response.body));
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

  static Future<Object> registerPatient(
      int projectID,
      int voucherID,
      String patientName,
      String phone,
      String patientID,
      String countryCode,
      String patientCity,
      // List<int> questionnaire,
      int questionId,
      String birthdate,
      String lastName,
      ) async {
    try {
      var request = {
        "project_id": projectID.toString(),
        "voucher_id": voucherID.toString(),
        "patient_name": patientName,
        "country_code": countryCode,
        "patient_phone": phone,
        "patient_id_number": patientID,
        "patient_city": patientCity,
        'result_id': questionId.toString(),
        'patient_date_of_birth': birthdate,
        'patient_last_name': lastName,
      };
      // for (var i = 0; i < questionnaire.length; i++) {
      //   request.addAll({'questionnaires[$i]': questionnaire[i].toString()});
      // }
      var url =
          "$PATIENT_REG_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("Patient Registration Api-> $url");
      debugPrint("Patient Registration request-> $request");
      var response = await http.post(Uri.parse(url),
          headers: {
            'Authorization':
            'Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}'
          },
          body: request);
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");
      debugPrint("Request body---> ${response.request}");
      debugPrint("TOKEN --> ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body---> ${response.body}");
        return Success(
            response: PatientRegistrationResponse.fromJson(response.body));
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
      debugPrint("Patient Registration ERROR --> $e");
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown Error");
    }
  }

  static Future<Object> registerConsent(
      String projectID,
      String voucherID,
      ) async {
    try {
      var request = {
        "project_id": projectID,
        "voucher_id": voucherID,
      };
      var url =
          "$PATIENT_REG_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("Patient Registration Api-> $url");
      debugPrint("Patient Registration request-> $request");
      var response = await http.post(Uri.parse(url),
          headers: {
            'Authorization':
            'Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}'
          },
          body: request);
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");
      debugPrint("Request body---> ${response.request}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body---> ${response.body}");
        return Success(
            response: PatientRegistrationResponse.fromJson(response.body));
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

  static Future<Object> registerConsentFile(
      String projectID,
      String voucherID,
      String patientName,
      String phone,
      String patientID,
      String countryCode,
      String patientCity,
      String consent,
      // List<int> questionnaire,
      int questionId,
      String birthdate,
      String lastName,
      ) async {
    try {
      http.MultipartRequest request;
      var uri = Uri.parse(
          "$PATIENT_REG_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}");
      request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath(
          'consent', consent.toString(),
          contentType: http_parser.MediaType('consent', 'pdf')));
      request.fields['project_id'] = projectID;
      request.fields['voucher_id'] = voucherID;
      request.fields['patient_name'] = patientName;
      request.fields['country_code'] = countryCode;
      request.fields['patient_phone'] = phone;
      request.fields['patient_id_number'] = patientID;
      request.fields['patient_city'] = patientCity;
      request.fields['result_id'] = questionId.toString();
      request.fields['patient_date_of_birth'] = birthdate;
      request.fields['patient_last_name'] = lastName;

      // for (var i = 0; i < questionnaire.length; i++) {
      //   request.fields
      //       .addAll({'questionnaires[$i]': questionnaire[i].toString()});
      // }

      Map<String, String> headers = {
        "Authorization":
        "Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}",
        "Content-type": "multipart/form-data"
      };
      request.headers.addAll(headers);
      debugPrint("REQUEST_FILES --> ${request.files}");
      debugPrint("REQUEST_FIELDES --> ${request.fields}");
      var res = await request.send();
      debugPrint("REGISTER_CONSENT_FILE REQUEST_API-> $uri");
      debugPrint("This is response: -> ${res.statusCode}");
      final response = await res.stream.bytesToString();
      debugPrint("This is response: -> ${response.toString()}");
      if (SUCCESS == res.statusCode) {
        return Success(
            response:
            PatientRegistrationResponse.fromJson(response.toString()));
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
      debugPrint("E--> $e");
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }
}

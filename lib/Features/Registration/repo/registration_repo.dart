import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smarthealth_hcp/Features/Registration/model/RegisterResponse/register_response.dart';
import 'package:smarthealth_hcp/Features/Registration/model/SpecialityResponse/speciality_list_response_model.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';

class RegisterService {
  static Future<Object> getRegister(
    String firstName,
    String lastName,
    String email,
    String phone,
    String countryCode,
    String countryName,
    String city,
    String hospitalName,
    String speciality,
    String projectCode,
    String password,
    String confirmPassword,
  ) async {
    try {
      Map request = {
        'name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'hospital': hospitalName,
        'speciality': speciality,
        'project_code': projectCode,
        'country_code': countryCode,
        'country': countryName,
        'city': city,
        'password': password,
        'password_confirmation': confirmPassword
      };
      var url =
          "$REGISTER_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";

      debugPrint("RegisterService REQUEST_API-> $url");
      debugPrint("RegisterService REQUEST-> $request");
      var response = await http.post(
        Uri.parse(url),
        body: request,
      );
      debugPrint("RegisterService RESPONSE CODE-> ${response.statusCode}");
      debugPrint("RegisterService RESPONSE-> ${response.body}");
      if (SUCCESS == response.statusCode) {
        debugPrint("RegisterService RESPONSE-> ${response.body}");
        return Success(response: RegisterResponse.fromJson(response.body));
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
      log("REGISTRATION_ERROR----> $e");
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }


  static Future<Object> getSpecialities() async {
    try {
      var url =
          "$SPECIALITY_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("Cities Api-> $url");
      var response = await http.get(Uri.parse(url));
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body---> ${response.body}");
        return Success(response: SpecialityListResponse.fromJson(response.body));
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

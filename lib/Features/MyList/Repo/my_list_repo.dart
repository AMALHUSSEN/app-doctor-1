import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/Features/MyList/Model/my_list_response_model/my_list_response_model.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';
import 'package:http/http.dart' as http;

class MyListService {
  static Future<Object> getMyList() async {
    try {
      var url =
          "$MY_LIST_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("My List Api-> $url");
      debugPrint("Token ---> ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}");
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization':
            'Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}',
      });
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body List heyyyy---> ${response.body}");
        return Success(response: MyListResponse.fromJson(response.body));
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

  static Future<Object> setConfirmed(int id) async{
    try {
      var url =
          "https://app.smarthealth-sa.com/api/auth/registrationConfirmed/$id";
      debugPrint("My List Api-> $url");
      debugPrint("Token ---> ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}");
      var response = await http.post(Uri.parse(url), headers: {
        'Authorization':
        'Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}',
      });
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body List heyyyy---> ${response.body}");
        return Success(response: true);
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

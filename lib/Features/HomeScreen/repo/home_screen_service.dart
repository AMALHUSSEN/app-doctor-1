import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smarthealth_hcp/Features/HomeScreen/model/app_setting_response/app_setting_response.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/model/app_version_response/app_version_response.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/model/block_project/block_project_response.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/model/home_response_model/home_response_model.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/model/logout_response/logout_response.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';

class HomeScreenService {
  static Future<Object> homeScreenApi() async {
    try {
      var url =
          "$HOMESCREEN_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("Homescreen Api---> $url");
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization':
            'Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}'
      });
      debugPrint(
          "Homescreen TOKEN---> ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}");
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body---> ${response.body}");
        return Success(response: HomeScreenResponse.fromJson(response.body));
      }
      return Failure(
          code: USER_INVALID_RESPONSE,
          errorResponse: 'Oops! Something went wrong.');
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

  static Future<Object> logoutApi() async {
    try {
      var url =
          "$LOGOUT_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("Homescreen Api---> $url");
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization':
            'Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}'
      });
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body---> ${response.body}");
        return Success(response: LogoutResponse.fromJson(response.body));
      }
      return Failure(
          code: USER_INVALID_RESPONSE,
          errorResponse: 'Oops! Something went wrong.');
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

  static Future<Object> appSettingApi() async {
    try {
      var url =
          "$APP_SETTING_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("App Setting Api --> $url");
      var response = await http.get(Uri.parse(url));
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");

      if (response.statusCode == SUCCESS) {
        debugPrint("Response body---> ${response.body}");
        return Success(response: AppSettingResponse.fromJson(response.body));
      }
      return Failure(
          code: USER_INVALID_RESPONSE,
          errorResponse: 'Oops! Something went wrong.');
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

  static Future<Object> checkAppVersion() async {
    try {
      var url = APP_VERSION_API;
      debugPrint("App Setting Api --> $url");
      var response = await http.get(Uri.parse(url));
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");

      if (response.statusCode == SUCCESS) {
        debugPrint("Response body---> ${response.body}");
        return Success(response: AppVersionResponse.fromJson(jsonDecode(response.body)));
      }
      return Failure(
          code: USER_INVALID_RESPONSE,
          errorResponse: 'Oops! Something went wrong.');
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

  static Future<Object> getBlockProjects() async {
    try {
      var url =
          "$GET_BLOCK_PROJECTS_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("Get Projects Api-> $url");
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization':
        'Bearer ${Shared.pref.getString(PREF_USER_ACCESS_TOKEN)}',
      });
      debugPrint("Status Code---> ${response.statusCode}");
      debugPrint("Response body---> ${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body block project ---> ${response.body}");
        return Success(response: BlockProjectResponse.fromJson(jsonDecode(response.body)));
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smarthealth_hcp/Features/Login/model/LoginResponse/login_response.dart';
import 'package:smarthealth_hcp/Features/Verificarion/model/RegisterVerificationResponse/register_verification_response.dart';
import 'package:smarthealth_hcp/Features/Verificarion/model/resend_code_response/resend_code_response.dart';
import 'package:smarthealth_hcp/Features/Verificarion/model/verification_response/verification_response.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';

class VerificationService {
  static Future<Object> doVerification(
      String phone, String phoneCode, String verificationCode) async {
    try {
      Map request = {
        'username': phone,
        'country_code': phoneCode,
        'verification_code': verificationCode
      };
      var url =
          "$VERIFICATION_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("Request--> $request");
      debugPrint("Request_API--> $url");
      var response = await http.post(Uri.parse(url), body: request);
      debugPrint("Response code-->${response.statusCode}");
      debugPrint("Response body-->${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body-->${response.body}");
        return Success(response: VerificationResponse.fromJson(response.body));
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

  static Future<Object> resendOTP(String phone) async {
    try {
      Map request = {
        'username': phone,
      };
      debugPrint("Request--> $request");
      var url =
          "$RESEND_OTP_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("Request_API--> $url");
      var response = await http.post(Uri.parse(url), body: request);
      debugPrint("Response code-->${response.statusCode}");
      debugPrint("Response body-->${response.body}");
      if (response.statusCode == SUCCESS) {
        debugPrint("Response body-->${response.body}");
        return Success(response: ResendCodeResponse.fromJson(response.body));
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

  static Future<Object> getRegisterOTPVerify(
    String verificationCode,
  ) async {
    try {
      Map request = {
        'verification_code': verificationCode,
      };
      var url =
          "$REGISTER_VERIFICATION_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("Verify REGISTER OtpService REQUEST_API-> $url");
      debugPrint("Verify REGISTER OtpService REQUEST-> $request");
      var response = await http.post(Uri.parse(url), body: request);
      if (SUCCESS == response.statusCode) {
        debugPrint("Verify REGISTER OtpService RESPONSE-> ${response.body}");
        return Success(
            response: RegisterVerificationResponse.fromJson(response.body));
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

  static Future<Object> getLoginOTPVerify(
    String verificationCode,
  ) async {
    try {
      Map request = {
        'verification_code': verificationCode,
      };
      var url =
          "$REGISTER_VERIFICATION_API?lang=${Shared.pref.getString(PREF_CURRENT_LANGUAGE) ?? 'en'}";
      debugPrint("Verify REGISTER OtpService REQUEST_API-> $url");
      debugPrint("Verify REGISTER OtpService REQUEST-> $request");
      var response = await http.post(Uri.parse(url), body: request);
      if (SUCCESS == response.statusCode) {
        debugPrint("Verify REGISTER OtpService RESPONSE-> ${response.body}");
        return Success(response: LoginResponse.fromJson(response.body));
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

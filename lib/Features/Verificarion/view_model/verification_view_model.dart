// ignore_for_file: unused_field, prefer_typing_uninitialized_variables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/Features/Login/model/LoginResponse/login_response.dart';
import 'package:smarthealth_hcp/Features/Verificarion/model/RegisterVerificationResponse/data.dart';
import 'package:smarthealth_hcp/Features/Verificarion/model/RegisterVerificationResponse/register_verification_response.dart';
import 'package:smarthealth_hcp/Features/Verificarion/model/resend_code_response/resend_code_response.dart';
import 'package:smarthealth_hcp/Features/Verificarion/model/verification_response/verification_response.dart';
import 'package:smarthealth_hcp/Features/Verificarion/repo/verification_service.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';
import '../../../api_commons/api_errors.dart';

class VerificationViewModel extends ChangeNotifier {
  bool _loading = false;
  UserError _userError = UserError();
  VerificationResponse _verifyResponse = VerificationResponse();
  VerificationResponse get verifyResponse => _verifyResponse;

  UserError get userError => _userError;
  bool get loading => _loading;
  setVerificationModel(VerificationResponse verifyResponse) {
    _verifyResponse = verifyResponse;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  Future<VerificationResponse> verifyPhone(
      String phone, String phoneCode, String verificationCode) async {
    setLoading(true);
    _userError = UserError();
    var result;
    var response = await VerificationService.doVerification(
        phone, phoneCode, verificationCode);
    if (response is Success) {
      debugPrint("VerifyPhone view model-> ${response.response}");
      setVerificationModel(response.response as VerificationResponse);
      result = response.response;
    }
    if (response is Failure) {
      UserError userError = UserError(
        success: response.code,
        message: response.errorResponse.toString(),
      );
      setUserError(userError);
      result = response;
    }
    setLoading(false);
    return result;
  }

  ResendCodeResponse _resendCodeResponse = ResendCodeResponse();
  ResendCodeResponse get resendCodeResponse => _resendCodeResponse;

  setResendModel(ResendCodeResponse resendCodeResponse) {
    _resendCodeResponse = resendCodeResponse;
  }

  Future<ResendCodeResponse> resendVerification(String phone) async {
    setLoading(true);
    _userError = UserError();
    var result;
    var response = await VerificationService.resendOTP(phone);
    if (response is Success) {
      debugPrint("Resend otp view model  Response-> ${response.response}");
      setResendModel(response.response as ResendCodeResponse);
      result = response.response;
    }
    if (response is Failure) {
      UserError userError = UserError(
        success: response.code,
        message: response.errorResponse.toString(),
      );
      setUserError(userError);
      result = response;
    }
    setLoading(false);
    return result;
  }

  RegisterVerificationResponse _registerVerificationResponse =
      RegisterVerificationResponse();
  RegisterVerificationData _registerVerificationData =
      RegisterVerificationData();

  RegisterVerificationResponse get registerVerificationResponse =>
      _registerVerificationResponse;
  RegisterVerificationData get registerVerificationData =>
      _registerVerificationData;

  setRegisteOtpUserModel(
      RegisterVerificationResponse registerVerificationResponse) {
    registerVerificationResponse = _registerVerificationResponse;
  }

  Future<RegisterVerificationResponse> registerVerification(
      String verificationCode) async {
    setLoading(true);
    _userError = UserError();
    var result;
    var response =
        await VerificationService.getRegisterOTPVerify(verificationCode);
    if (response is Success) {
      debugPrint("REGISTER otp VIEW MODEL  Response-> ${response.response}");
      setRegisteOtpUserModel(response.response as RegisterVerificationResponse);
      result = response.response;
    }
    if (response is Failure) {
      UserError userError = UserError(
        success: response.code,
        message: response.errorResponse.toString(),
      );
      setUserError(userError);
      result = response;
    }
    setLoading(false);
    return result;
  }

  LoginResponse _loginResponse = LoginResponse();
  LoginResponse get loginResponse => _loginResponse;

  setLoginUserModel(LoginResponse loginResponse) {
    loginResponse = _loginResponse;
  }

  Future<LoginResponse> loginVerification(String verificationCode) async {
    setLoading(true);
    _userError = UserError();
    var result;
    var response =
        await VerificationService.getLoginOTPVerify(verificationCode);
    if (response is Success) {
      debugPrint("REGISTER otp VIEW MODEL  Response-> ${response.response}");
      setLoginUserModel(response.response as LoginResponse);
      result = response.response;
    }
    if (response is Failure) {
      UserError userError = UserError(
        success: response.code,
        message: response.errorResponse.toString(),
      );
      setUserError(userError);
      result = response;
    }
    setLoading(false);
    return result;
  }
}

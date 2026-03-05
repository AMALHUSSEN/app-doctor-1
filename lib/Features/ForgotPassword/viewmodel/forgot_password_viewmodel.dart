// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/Features/ForgotPassword/model/forgot_password_response/forgot_password_response.dart';
import 'package:smarthealth_hcp/Features/ForgotPassword/repo/forgot_password_repo.dart';
import 'package:smarthealth_hcp/api_commons/api_errors.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';

class ForgotpassViewModel extends ChangeNotifier {
  bool _loading = false;
  ForgotPasswordResponse _forgotpassResponse = ForgotPasswordResponse();
  UserError _userError = UserError();

  ForgotPasswordResponse get forgotpassResponse => _forgotpassResponse;
  UserError get userError => _userError;
  bool get loading => _loading;
  setForgotPassUserModel(ForgotPasswordResponse forgotpassResponse) {
    _forgotpassResponse = forgotpassResponse;
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  doForgotPassword(String phone, String phoneCode) async {
    setLoading(true);
    _userError = UserError();
    var result;
    var response =
        await ForgotPasswordService.forgotPasswordAPICall(phone, phoneCode);
    if (response is Success) {
      debugPrint("Login view model-> ${response.response}");
      setForgotPassUserModel(response.response as ForgotPasswordResponse);
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

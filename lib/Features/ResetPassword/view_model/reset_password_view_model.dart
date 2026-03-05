// ignore_for_file: prefer_final_fields, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/Features/ResetPassword/model/reset_pass_request.dart';
import 'package:smarthealth_hcp/Features/ResetPassword/model/reset_password_response/reset_password_response.dart';
import 'package:smarthealth_hcp/Features/ResetPassword/repo/reset_password_service.dart';
import '../../../api_commons/api_errors.dart';
import '../../../api_commons/api_status.dart';

class ResetPassViewModel extends ChangeNotifier {
  bool _loading = false;
  ResetPasswordResponse _resetpassResponse = ResetPasswordResponse();
  UserError _userError = UserError();
  bool get loading => _loading;
  ResetPasswordResponse get resetpassResponse => _resetpassResponse;
  UserError get userError => _userError;

  setResetPassModel(ResetPasswordResponse resetpassResponse) {
    _resetpassResponse = resetpassResponse;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  Future<ResetPasswordResponse> resetPassword(
      ResetPassRequest resetPassRequest) async {
    setLoading(true);
    var result;

    var response =
        await ResetPassService.callResetPasswordApi(resetPassRequest);

    if (response is Success) {
      debugPrint("Resetpass view model-> ${response.response}");
      setResetPassModel(response.response as ResetPasswordResponse);
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

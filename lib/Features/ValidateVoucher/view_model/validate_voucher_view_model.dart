// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/Features/ValidateVoucher/model/validate_voucher_response/validate_voucher_response.dart';
import 'package:smarthealth_hcp/Features/ValidateVoucher/repo/validate_voucher_service.dart';
import 'package:smarthealth_hcp/api_commons/api_errors.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';

class ValidateVoucherViewModel extends ChangeNotifier {
  bool _loading = false;
  ValidateVoucherResponse _validateVoucherResponse = ValidateVoucherResponse();
  UserError _userError = UserError();

  bool get loading => _loading;
  ValidateVoucherResponse get validateVoucherResponse =>
      _validateVoucherResponse;
  UserError get userError => _userError;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setValidateVoucherViewModel(ValidateVoucherResponse validateVoucherResponse) {
    _validateVoucherResponse = validateVoucherResponse;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  validateVoucher(String id) async {
    setLoading(true);
    _userError = UserError();
    var result;
    var response = await ValidateVoucherService.validateVoucher(id);
    if (response is Success) {
      debugPrint("Login view model-> ${response.response}");
      setValidateVoucherViewModel(response.response as ValidateVoucherResponse);
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

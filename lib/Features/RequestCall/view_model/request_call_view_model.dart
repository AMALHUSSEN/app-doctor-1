// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/Features/RequestCall/model/request_a_call_response_model/request_a_call_response_model/request_a_call_response_model.dart';
import 'package:smarthealth_hcp/Features/RequestCall/repo/request_call_service.dart';
import 'package:smarthealth_hcp/api_commons/api_errors.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';

class RequestACallViewModel extends ChangeNotifier {
  bool _loading = false;
  RequestACallResponse _requestCallResponse = RequestACallResponse();
  UserError _userError = UserError();

  bool get loading => _loading;
  RequestACallResponse get requestCallResponse => _requestCallResponse;
  UserError get userError => _userError;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setRequestCallViewModel(RequestACallResponse requestCallResponse) {
    _requestCallResponse = requestCallResponse;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  requestACall(String message) async {
    setLoading(true);
    _userError = UserError();
    var result;
    var response = await RequestACallService.requestCallApi(message);
    if (response is Success) {
      debugPrint("Request a call model-> ${response.response}");
      setRequestCallViewModel(response.response as RequestACallResponse);
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

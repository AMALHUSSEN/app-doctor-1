// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/Features/ProjectConsent/model/project_consent_detail_response/project_consent_detail_response.dart';
import 'package:smarthealth_hcp/Features/ProjectConsent/model/submit_consent_response/submit_consent_response.dart';
import 'package:smarthealth_hcp/Features/ProjectConsent/repo/projectconsent_service.dart';
import 'package:smarthealth_hcp/api_commons/api_errors.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';

class ProjectConsentViewModel extends ChangeNotifier {
  bool _loading = false;
  UserError _userError = UserError();

  bool get loading => _loading;
  UserError get userError => _userError;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  ProjectConsentDetailResponse _projectConsentDetailResponse =
      ProjectConsentDetailResponse();

  ProjectConsentDetailResponse get projectConsentDetailResponse =>
      _projectConsentDetailResponse;

  setConsentUserModel(ProjectConsentDetailResponse response) {
    _projectConsentDetailResponse = response;
  }

  getConsentProjectDetail(String userId) async {
    setLoading(true);
    _userError = UserError();
    var result;
    var response = await ProjectConsentService.getProjectDetail(userId);
    if (response is Success) {
      debugPrint("Login view model-> ${response.response}");
      setConsentUserModel(response.response as ProjectConsentDetailResponse);
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

  SubmitConsentResponse _submitConsentResponse = SubmitConsentResponse();
  SubmitConsentResponse get submitConsentResponse => _submitConsentResponse;

  setDoctorConsentUserModel(SubmitConsentResponse doctorConsentResponseBean) {
    _submitConsentResponse = doctorConsentResponseBean;
  }

  Future<SubmitConsentResponse> doctorConsent(
      int pivotId, String signature) async {
    setLoading(true);
    var result;
    var response =
        await ProjectConsentService.submitConsent(pivotId, signature);
    if (response is Success) {
      debugPrint("addConsentFromProject VIEW_MODEL--> $response");
      setDoctorConsentUserModel(response.response as SubmitConsentResponse);
      result = response.response;
      debugPrint("RESULT--> $result");
      // notifyListeners();
    }
    if (response is Failure) {
      UserError userError = UserError(
        message: response.errorResponse.toString(),
        success: response.code,
      );
      setUserError(userError);
      result = response;
    }
    setLoading(false);
    return result;
  }
}

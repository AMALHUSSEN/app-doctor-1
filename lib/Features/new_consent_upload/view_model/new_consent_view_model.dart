import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/get_projects_response_model/get_projects_response_model.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/re_upload_consent_response/re_upload_consent_response.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/repo/select_project_service.dart';
import 'package:smarthealth_hcp/Features/new_consent_upload/new_consent_responce.dart';
import 'package:smarthealth_hcp/api_commons/api_errors.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';

class NewConsentFileViewModel extends ChangeNotifier{
  bool _loading = false;
  ProjectsResponse _projectResponse = ProjectsResponse();
  UserError _userError = UserError();

  bool get loading => _loading;
  ProjectsResponse get projectResponse => _projectResponse;
  UserError get userError => _userError;

  NewConsentResponse _newConsentResponse =
  NewConsentResponse();
  NewConsentResponse get newConsentResponse =>
      _newConsentResponse;

  setNewConsentViewModel(NewConsentResponse response) {
    _newConsentResponse = response;
  }


  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  Future<NewConsentResponse> uploadNewConsent(
      int id, String consent) async {
    setLoading(true);
    var result;
    var response = await SelectProjectService.uploadNewConsent(id, consent);
    if (response is Success) {
      setNewConsentViewModel(response.response as NewConsentResponse);
      debugPrint("REUPLOAD_CONSENT VIEW_MODEL--> $response");
      result = response.response;
      debugPrint("REUPLOAD_CONSENT RESULT--> $result");
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
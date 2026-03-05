// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/Features/Login/model/LoginResponse/login_response.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/SubmitQuestionnaireResponse/submit_question_response.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/check_voucher_response.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/get_projects_response_model/get_projects_response_model.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/get_projects_response_model/projects_data.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/questionnaire_response_bean/datum.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/questionnaire_response_bean/questionnaire_response_bean.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/re_upload_consent_response/re_upload_consent_response.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/repo/select_project_service.dart';
import 'package:smarthealth_hcp/api_commons/api_errors.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';

class SelectProjectViewModel extends ChangeNotifier {
  bool _loading = false;
  bool _loadingDoctorData = false;
  ProjectsResponse _projectResponse = ProjectsResponse();
  LoginResponse _doctorDataResponse = LoginResponse();
  UserError _userError = UserError();

  bool get loading => _loading;
  bool get loadingDoctorData => _loadingDoctorData;
  ProjectsResponse get projectResponse => _projectResponse;
  LoginResponse get doctorDataResponse => _doctorDataResponse;
  UserError get userError => _userError;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setLoadingDoctorData(bool loading) async {
    _loadingDoctorData = loading;
    notifyListeners();
  }

  List<ProjectsData> _projectsData = [];
  List<ProjectsData> get projectsData => _projectsData;

  setProjectViewModel(ProjectsResponse projectResponse) {
    _projectResponse = projectResponse;
    _projectsData = projectResponse.result?.data ?? [];
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setDoctorData(LoginResponse data) {
    _doctorDataResponse = data;
  }

  getProjects() async {
    setLoading(true);
    _userError = UserError();
    var result;
    var response = await SelectProjectService.getProjects();
    if (response is Success) {
      debugPrint("Login view model-> ${response.response}");
      setProjectViewModel(response.response as ProjectsResponse);
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

  QuestionnaireResponse _questionnaireResponse = QuestionnaireResponse();
  List<QuestionnaireData> _questionnaireData = [];

  QuestionnaireResponse get questionnaireResponse => _questionnaireResponse;
  List<QuestionnaireData> get questionnaireData => _questionnaireData;

  setQuestionnaireViewModel(QuestionnaireResponse questionnaireResponse) {
    _questionnaireResponse = questionnaireResponse;
    _questionnaireData = questionnaireResponse.result?.data ?? [];
  }

  getQuestionnaire(int id) async {
    setLoading(true);
    _userError = UserError();
    var result;
    var response = await SelectProjectService.getQuestionnaireList(id);
    if (response is Success) {
      debugPrint("Questionnaire view model-> ${response.response}");
      setQuestionnaireViewModel(response.response as QuestionnaireResponse);
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

  SubmitQuestionResponse _submitQuestionResponse = SubmitQuestionResponse();
  SubmitQuestionResponse get submitQuestionResponse => _submitQuestionResponse;

  setSubmitSurveyUserModel(SubmitQuestionResponse submitQuestionResponse) {
    _submitQuestionResponse = submitQuestionResponse;
  }

  Future<SubmitQuestionResponse> submitQuestionApiCall(
      int id, List<dynamic> list) async {
    setLoading(true);
    var result;
    var response = await SelectProjectService.submitQuestion(id, list);
    if (response is Success) {
      debugPrint("Survey_ViewModel--> ${response.response}");
      setSubmitSurveyUserModel(response.response as SubmitQuestionResponse);
      result = response.response;
    }
    if (response is Failure) {
      UserError userError = UserError(
          success: response.code, message: response.errorResponse.toString());
      setUserError(userError);
      result = response;
    }

    setLoading(false);
    return result;
  }

  CheckVoucherResponse _checkVoucherResponse = CheckVoucherResponse();
  CheckVoucherResponse get checkVoucherResponse => _checkVoucherResponse;

  setCheckVoucherModel(CheckVoucherResponse checkVoucherResponse) {
    _checkVoucherResponse = checkVoucherResponse;
  }

  Future<CheckVoucherResponse> checkVoucherApiCall(int id) async {
    setLoading(true);
    var result;
    var response = await SelectProjectService.checkVoucher(id);
    if (response is Success) {
      debugPrint("SelectProjectViewModel-> ${response.response}");
      setCheckVoucherModel(response.response as CheckVoucherResponse);
      result = response.response;
      notifyListeners();
    }
    if (response is Failure) {
      UserError userError = UserError(
        success: response.code,
        message: response.errorResponse.toString(),
      );
      setUserError(userError);
      result = response;
      notifyListeners();
    }
    setLoading(false);
    return result;
  }

  ReUploadConsentResponse _reUploadConsentResponse = ReUploadConsentResponse();

  ReUploadConsentResponse get reUploadConsentResponse =>
      _reUploadConsentResponse;

  setReUploadConsentUserModel(
      ReUploadConsentResponse doctorConsentResponseBean) {
    _reUploadConsentResponse = doctorConsentResponseBean;
  }

  Future<ReUploadConsentResponse> reUploadConsent(
      int id, String consent) async {
    setLoading(true);
    var result;
    var response = await SelectProjectService.reUploadConsent(id, consent);
    if (response is Success) {
      debugPrint("REUPLOAD_CONSENT VIEW_MODEL--> $response");
      setReUploadConsentUserModel(response.response as ReUploadConsentResponse);
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



  Future<void> uploadNewConsent(int registrationId, String consent) async {
    var response = await SelectProjectService.uploadNewConsent(registrationId, consent);
    if (response is Success) {
      debugPrint("UPLOAD_NEW_CONSENT SUCCESS");
    }
    if (response is Failure) {
      debugPrint("UPLOAD_NEW_CONSENT FAILED: ${(response as Failure).errorResponse}");
    }
  }

  getDoctorData() async {
    setLoadingDoctorData(true);
    _userError = UserError();
    var result;
    var response = await SelectProjectService.getDoctorData();
    if (response is Success) {
      debugPrint("Login view model-> ${response.response}");
      setDoctorData(response.response as LoginResponse);
      result = response.response;
      setLoadingDoctorData(false);
    }
    if (response is Failure) {
      UserError userError = UserError(
        success: response.code,
        message: response.errorResponse.toString(),
      );
      setUserError(userError);
      result = response;
      setLoadingDoctorData(false);
    }
    setLoadingDoctorData(false);
    return result;
  }
}

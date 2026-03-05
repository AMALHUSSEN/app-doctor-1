// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:smarthealth_hcp/Features/ConsentForm/model/ConsentFormResponseBean/consent_form_response_bean.dart';
import 'package:smarthealth_hcp/Features/ConsentForm/model/ConsentFormResponseBean/data.dart';
import 'package:smarthealth_hcp/Features/ConsentForm/repo/consentform_service.dart';
import 'package:smarthealth_hcp/api_commons/api_errors.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';

class ConsentFormViewModel extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  UserError _userError = UserError();
  UserError get userError => _userError;

  ConsentFormResponseBean _consentFormResponseBean = ConsentFormResponseBean();
  ConsentFormResponseBean get consentFormResponseBean =>
      _consentFormResponseBean;

  ConsentFormData _consentFormData = ConsentFormData();
  ConsentFormData get consentFormData => _consentFormData;

  setLoading(bool loading) async {
    _loading = loading;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setConsentFormDataUserModel(ConsentFormResponseBean consentFormResponseBean) {
    _consentFormResponseBean = consentFormResponseBean;
    _consentFormData = consentFormResponseBean.result!.data!;
  }

  Future<ConsentFormResponseBean> getConsentFormResponse() async {
    setLoading(true);
    var result;
    var response = await ConsentFormService.getConsentFormServiceCall();
    if (response is Success) {
      debugPrint("CMSPAGE_ViewModel--> ${response.response}");
      setConsentFormDataUserModel(response.response as ConsentFormResponseBean);
      result = response.response;
      notifyListeners();
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
}

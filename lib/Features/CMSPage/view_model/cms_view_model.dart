// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:smarthealth_hcp/Features/CMSPage/model/cms_response/cms_response.dart';
import 'package:smarthealth_hcp/Features/CMSPage/model/cms_response/data.dart';
import 'package:smarthealth_hcp/Features/CMSPage/repo/cms_service.dart';
import 'package:smarthealth_hcp/api_commons/api_errors.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';

class CMSPageViewModel extends ChangeNotifier {
  bool _loading = false;
  CmsResponse _cmsResponse = CmsResponse();
  CMSData _cmsData = CMSData();
  UserError _userError = UserError();

  bool get loading => _loading;
  CmsResponse get cmsResponse => _cmsResponse;
  CMSData get cmsData => _cmsData;
  UserError get userError => _userError;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setCMSUserModel(CmsResponse cmsResponse) {
    _cmsResponse = cmsResponse;
    _cmsData = cmsResponse.result!.data!;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  Future<CmsResponse> getCMSResponse(String cmsType) async {
    setLoading(true);
    var result;
    var response = await CMSPageService.getCMSPageServiceCall(cmsType);
    if (response is Success) {
      debugPrint("CMSPAGE_ViewModel--> ${response.response}");
      setCMSUserModel(response.response as CmsResponse);
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

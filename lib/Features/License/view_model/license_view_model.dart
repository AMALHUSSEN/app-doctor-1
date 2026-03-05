// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/Features/License/model/license_response/license_data.dart';
import 'package:smarthealth_hcp/Features/License/model/license_response/license_response.dart';
import 'package:smarthealth_hcp/Features/License/repo/license_service.dart';
import 'package:smarthealth_hcp/api_commons/api_errors.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';

class LicenseViewModel extends ChangeNotifier {
  bool _loading = false;
  LicenseResponse _licenseResponse = LicenseResponse();
  UserError _userError = UserError();
  List<LicenseData> _licensesData = [];

  bool get loading => _loading;
  LicenseResponse get licenseResponse => _licenseResponse;
  UserError get userError => _userError;
  List<LicenseData> get licensesData => _licensesData;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setLicenseViewModel(LicenseResponse licenseResponse) {
    _licenseResponse = licenseResponse;
    _licensesData = licenseResponse.result?.data ?? [];
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  getLicenses() async {
    setLoading(true);
    _userError = UserError();
    var result;
    var response = await LicenseService.getLicenses();
    if (response is Success) {
      debugPrint("License view model-> ${response.response}");
      setLicenseViewModel(response.response as LicenseResponse);
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

  LicenseData? getLicenseForProject(int projectId) {
    try {
      return _licensesData.firstWhere((l) => l.projectId == projectId);
    } catch (e) {
      return null;
    }
  }

  bool hasActiveLicense(int projectId) {
    var license = getLicenseForProject(projectId);
    return license?.isActive == true;
  }

  bool hasExpiringLicense() {
    return _licensesData.any(
        (l) => l.isActive == true && l.daysRemaining != null && l.daysRemaining! <= 7);
  }

  LicenseData? getExpiringLicense() {
    try {
      return _licensesData.firstWhere(
          (l) => l.isActive == true && l.daysRemaining != null && l.daysRemaining! <= 7);
    } catch (e) {
      return null;
    }
  }
}

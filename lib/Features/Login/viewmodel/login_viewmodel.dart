// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/model/app_version_response/app_version_response.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/model/app_version_response/data.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/repo/home_screen_service.dart';
import 'package:smarthealth_hcp/Features/Login/model/LoginResponse/login_response.dart';
import 'package:smarthealth_hcp/Features/Login/repo/login_repo.dart';
import '../../../api_commons/api_errors.dart';
import '../../../api_commons/api_status.dart';

class LoginViewModel extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  AppVersionResponse _appVersionResponse = AppVersionResponse();
  AppVersionData _appVersionData = AppVersionData();

  AppVersionResponse get appVersionResponse => _appVersionResponse;
  AppVersionData get appVersionData => _appVersionData;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  UserError _userError = UserError();
  UserError get userError => _userError;

  setUserError(UserError userError) {
    _userError = userError;
  }

  LoginResponse _loginResponse = LoginResponse();
  LoginResponse get loginResponse => _loginResponse;

  setLoginUserModel(LoginResponse loginResponse) {
    _loginResponse = loginResponse;
  }

  setAppVersionModel(AppVersionResponse appVersionResponse) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    _appVersionResponse = appVersionResponse;
    _appVersionData =
        appVersionResponse.result?.data ??
        AppVersionData(version: packageInfo.version);
  }

  doLogin(String phoneCode, String phone, String password) async {
    setLoading(true);
    _userError = UserError();
    var result;
    var response = await LoginService.loginAPICall(phoneCode, phone, password);
    if (response is Success) {
      debugPrint("Login view model-> ${response.response}");
      setLoginUserModel(response.response as LoginResponse);
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

  checkAppVersion() async {
    _userError = UserError();
    var result;
    var response = await HomeScreenService.checkAppVersion();
    if (response is Success) {
      result = response.response;
      setAppVersionModel(response.response as AppVersionResponse);
    }
    if (response is Failure) {
      UserError userError = UserError(
        success: response.code,
        message: response.errorResponse.toString(),
      );
      setUserError(userError);
      result = response;
    }
    return result;
  }
}

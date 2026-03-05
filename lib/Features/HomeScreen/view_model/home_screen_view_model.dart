// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/model/app_setting_response/app_setting_response.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/model/app_setting_response/data.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/model/app_version_response/app_version_response.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/model/app_version_response/data.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/model/block_project/block_project_response.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/model/block_project/data.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/model/home_response_model/home_response_model.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/model/logout_response/logout_response.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/repo/home_screen_service.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/repo/select_project_service.dart';
import 'package:smarthealth_hcp/api_commons/api_errors.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';

class HomeScreenViewModel extends ChangeNotifier {
  bool _loading = false;
  HomeScreenResponse _homescreenResponse = HomeScreenResponse();
  UserError _userError = UserError();

  HomeScreenResponse get homescreenResponse => _homescreenResponse;
  UserError get userError => _userError;
  bool get loading => _loading;
  setHomescreenViewModel(HomeScreenResponse homescreenResponse) {
    _homescreenResponse = homescreenResponse;
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  homescreenAPI() async {
    setLoading(true);
    _userError = UserError();
    var result;
    var response = await HomeScreenService.homeScreenApi();
    if (response is Success) {
      debugPrint("Login view model-> ${response.response}");
      setHomescreenViewModel(response.response as HomeScreenResponse);
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

  LogoutResponse _logoutResponse = LogoutResponse();
  LogoutResponse get logoutResponse => _logoutResponse;

  setLogoutViewModel(LogoutResponse logoutResponse) {
    _logoutResponse = logoutResponse;
  }

  logoutApi() async {
    setLoading(true);
    _userError = UserError();
    var result;
    var response = await HomeScreenService.logoutApi();
    if (response is Success) {
      debugPrint("Login view model-> ${response.response}");
      setLogoutViewModel(response.response as LogoutResponse);
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

  AppSettingResponse _appSettingResponse = AppSettingResponse();
  AppSettingData _appSettingData = AppSettingData();
  AppVersionResponse _appVersionResponse = AppVersionResponse();
  AppVersionData _appVersionData = AppVersionData();
  BlockProjectResponse _blockProjectResponse = BlockProjectResponse();
  List<BlockProjectData> _blockProjectData = [];

  AppSettingResponse get appSettingResponse => _appSettingResponse;
  AppVersionResponse get appVersionResponse => _appVersionResponse;
  AppSettingData get appSettingData => _appSettingData;
  AppVersionData get appVersionData => _appVersionData;
  List<BlockProjectData> get blockProjectData => _blockProjectData;

  setAppSettingUserModel(AppSettingResponse appSettingResponse) {
    _appSettingResponse = appSettingResponse;
    _appSettingData = appSettingResponse.result!.data!;
  }

  setAppVersionModel(AppVersionResponse appVersionResponse) {
    _appVersionResponse = appVersionResponse;
    _appVersionData = appVersionResponse.result!.data!;
  }

  setBlockProjectViewModel(BlockProjectResponse blockProjectResponse) {
    _blockProjectResponse = blockProjectResponse;
    _blockProjectData = blockProjectResponse.result!.data!;
  }

  Future<AppSettingResponse> appSettingApi() async {
    setLoading(true);
    var result;
    var response = await HomeScreenService.appSettingApi();
    if (response is Success) {
      debugPrint("APP SETTING VIEW MODEL--> ${response.response}");
      setAppSettingUserModel(response.response as AppSettingResponse);
      result = response.response;
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

  checkAppVersion() async {
    _userError = UserError();
    var result;
    var response = await HomeScreenService.checkAppVersion();
    if (response is Success) {
      debugPrint("Login view model-> ${response.response}");

      result = response.response;
      setAppVersionModel(response.response as AppVersionResponse);
      print("waaa sa7bi ${_appVersionData.version}");
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


  getBlockProjects() async {
    setLoading(true);
    _userError = UserError();
    var result;
    var response = await HomeScreenService.getBlockProjects();
    if (response is Success) {
      debugPrint("Login view model-> ${response.response}");
      setBlockProjectViewModel(response.response as BlockProjectResponse);
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

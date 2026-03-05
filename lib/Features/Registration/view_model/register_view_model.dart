// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/Features/Registration/model/RegisterResponse/register_response.dart';
import 'package:smarthealth_hcp/Features/Registration/model/SpecialityResponse/speciality_data.dart';
import 'package:smarthealth_hcp/Features/Registration/model/SpecialityResponse/speciality_list_response_model.dart';
import 'package:smarthealth_hcp/Features/Registration/repo/registration_repo.dart';
import 'package:smarthealth_hcp/api_commons/api_errors.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';

class RegisterViewModel extends ChangeNotifier {
  bool _loading = false;
  RegisterResponse _registerResponse = RegisterResponse();
  UserError _userError = UserError();
  SpecialityListResponse _specialityListResponse = SpecialityListResponse();

  bool get loading => _loading;
  RegisterResponse get registerResponse => _registerResponse;
  UserError get userError => _userError;

  List<SpecialityData> _specialityData = [];
  List<SpecialityData> get specialityData => _specialityData;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setRegisterModel(RegisterResponse registerResponse) {
    _registerResponse = registerResponse;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setSpecialityModel(SpecialityListResponse specialityListResponse) {
    _specialityListResponse = specialityListResponse;
    _specialityData = specialityListResponse.result?.data ?? [];
  }

  Future<SpecialityListResponse> getAllSpeciality() async {
    setLoading(true);
    var result;

    var response = await RegisterService.getSpecialities();

    if (response is Success) {
      debugPrint("Resetpass view model-> ${response.response}");
      setSpecialityModel(response.response as SpecialityListResponse);
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

  Future<RegisterResponse> doRegister(
    String firstName,
    String lastName,
    String email,
    String phone,
    String countryCode,
    String countryName,
    String city,
    String hospitalName,
    String speciality,
    String projectCode,
    String password,
    String confirmPassword,
  ) async {
    setLoading(true);
    _userError = UserError();
    var response = await RegisterService.getRegister(
      firstName,
      lastName,
      email,
      phone,
      countryCode,
      countryName,
      city,
      hospitalName,
      speciality,
      projectCode,
      password,
      confirmPassword,
    );
    RegisterResponse result;
    if (response is Success) {
      debugPrint("RegisterViewModel  Response-> ${response.response}");
      setRegisterModel(response.response as RegisterResponse);
      result = response.response as RegisterResponse;
    } else if (response is Failure) {
      UserError userError = UserError(
        success: response.code,
        message: response.errorResponse.toString(),
      );
      setUserError(userError);
      result = RegisterResponse(
        success: API_FAIL,
        message: response.errorResponse.toString(),
      );
    } else {
      result = RegisterResponse(
        success: API_FAIL,
        message: 'Unknown error occurred',
      );
    }
    setLoading(false);
    return result;
  }
}

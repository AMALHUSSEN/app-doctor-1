// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/models/city_list_response_model/city_data.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/models/city_list_response_model/city_list_response_model.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/models/country_list_response_model/country_list_response_model.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/models/country_list_response_model/datum.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/models/patient_registration_response/patient_registration_response.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/repo/patient_details_screen_service.dart';
import 'package:smarthealth_hcp/api_commons/api_errors.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';

class PatientdetailsViewModel extends ChangeNotifier {
  bool _loading = false;
  CityListResponse _cityListResponse = CityListResponse();
  UserError _userError = UserError();
  bool get loading => _loading;
  CityListResponse get cityListResponse => _cityListResponse;
  UserError get userError => _userError;

  setCitiesModel(CityListResponse cityListResponse) {
    _cityListResponse = cityListResponse;
    _cityData = cityListResponse.result?.data ?? [];
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  List<CityData> _cityData = [];
  List<CityData> get cityData => _cityData;

  Future<CityListResponse> getCities() async {
    setLoading(true);
    var result;

    var response = await PatientDetailsService.getCities();

    if (response is Success) {
      debugPrint("Resetpass view model-> ${response.response}");
      setCitiesModel(response.response as CityListResponse);
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

  CountryListResponse _countryListResponse = CountryListResponse();
  CountryListResponse get countryListResponse => _countryListResponse;

  List<CountriesData> _countriesData = [];
  List<CountriesData> get countriesData => _countriesData;

  setCountriesViewModel(CountryListResponse countryListResponse) {
    _countryListResponse = countryListResponse;
    _countriesData = countryListResponse.result?.data ?? [];
  }

  Future<CountryListResponse> getCountries() async {
    setLoading(true);
    var result;
    var response = await PatientDetailsService.getCountries();

    if (response is Success) {
      debugPrint("Resetpass view model-> ${response.response}");
      setCountriesViewModel(response.response as CountryListResponse);
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

  PatientRegistrationResponse _patientRegistrationResponse =
      PatientRegistrationResponse();
  PatientRegistrationResponse get patientRegistrationResponse =>
      _patientRegistrationResponse;

  setPatientViewModel(PatientRegistrationResponse patientRegistrationResponse) {
    _patientRegistrationResponse = patientRegistrationResponse;
  }

  Future<PatientRegistrationResponse> registerPatient(
    String projectID,
    String voucherID,
    String patientName,
    String phone,
    String patientID,
    String countryCode,
    String patientCity,
    // File consent,
    String consent,
    // List<int> questionnaire,
    int questionId,
    String birthdate,
    String lastName,
  ) async {
    setLoading(true);
    var result;
    var response = await PatientDetailsService.registerConsentFile(
      projectID,
      voucherID,
      patientName,
      phone,
      patientID,
      countryCode,
      patientCity,
      consent,
      // questionnaire,
      questionId,
      birthdate,
      lastName,
    );

    print("response response $response");

    if (response is Success) {
      debugPrint("Resetpass view model register -> ${response.response}");
      setPatientViewModel(response.response as PatientRegistrationResponse);
      result = response.response;
    }else if (response is Failure) {
      UserError userError = UserError(
        success: response.code,
        message: response.errorResponse.toString(),
      );
      setUserError(userError);
      result = response;
    }
    setLoading(false);
    debugPrint("RESULT--> $result");
    return result;
  }

  Future<PatientRegistrationResponse> registerPatientAndUploadNewConsent(
      String projectID,
      String voucherID,
      String patientName,
      String phone,
      String patientID,
      String countryCode,
      String patientCity,
      // File consent,
      String consent,
      // List<int> questionnaire,
      int questionId,
      String birthdate,
      String lastName,
      ) async {
    setLoading(true);
    var result;
    var response = await PatientDetailsService.registerConsentFile(
      projectID,
      voucherID,
      patientName,
      phone,
      patientID,
      countryCode,
      patientCity,
      consent,
      // questionnaire,
      questionId,
      birthdate,
      lastName,
    );

    if (response is Success) {
      debugPrint("Resetpass view model-> ${response.response}");
      setPatientViewModel(response.response as PatientRegistrationResponse);
      result = response.response;
    }else if (response is Failure) {
      UserError userError = UserError(
        success: response.code,
        message: response.errorResponse.toString(),
      );
      setUserError(userError);
      result = response;
    }
    setLoading(false);
    debugPrint("RESULT--> $result");
    return result;
  }

  Future<PatientRegistrationResponse> registerConsent(
    String projectID,
    String voucherID,
  ) async {
    setLoading(true);
    var result;
    var response = await PatientDetailsService.registerConsent(
      projectID,
      voucherID,
    );

    if (response is Success) {
      debugPrint("Resetpass view model-> ${response.response}");
      setPatientViewModel(response.response as PatientRegistrationResponse);
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

  Future<PatientRegistrationResponse> patientDetail(
    int projectID,
    int voucherID,
    String patientName,
    String phone,
    String patientID,
    String countryCode,
    String patientCity,
    // List<int> questionnaire,
    int questionId,
    String birthdate,
    String lastName
  ) async {
    setLoading(true);
    var result;
    var response = await PatientDetailsService.registerPatient(
        projectID,
        voucherID,
        patientName,
        phone,
        patientID,
        countryCode,
        patientCity,
        // questionnaire,
        questionId,
        birthdate,
        lastName
    );

    if (response is Success) {
      debugPrint("Resetpass view model-> ${response.response}");
      setPatientViewModel(response.response as PatientRegistrationResponse);
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
    debugPrint("RESULT--> $result");
    return result;
  }
}

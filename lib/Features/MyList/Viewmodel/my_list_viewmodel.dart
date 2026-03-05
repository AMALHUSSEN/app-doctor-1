import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/Features/MyList/Model/my_list_response_model/datum.dart';
import 'package:smarthealth_hcp/Features/MyList/Model/my_list_response_model/my_list_response_model.dart';
import 'package:smarthealth_hcp/Features/MyList/Repo/my_list_repo.dart';
import 'package:smarthealth_hcp/api_commons/api_errors.dart';
import 'package:smarthealth_hcp/api_commons/api_status.dart';

class MyListViewModel extends ChangeNotifier {
  bool _loading = false;
  bool _loadingConfirmed = false;
  MyListResponse _listResponse = MyListResponse();
  UserError _userError = UserError();

  bool get loading => _loading;
  bool get loadingConfirmed => _loadingConfirmed;
  MyListResponse get listResponse => _listResponse;
  UserError get userError => _userError;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  bool isLoading(int index) {
    return _listData[index].loading ?? false;
  }

  setLoadingConfirmed(bool loading, int index) async {
    _listData[index].loading = loading;
    notifyListeners();
  }

  List<ListData> _listData = [];
  List<ListData> get listData => _listData;

  setMyListViewModel(MyListResponse listResponse) {
    _listResponse = listResponse;
    _listData = listResponse.result?.data?.data ?? [];
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  getMyList() async {
    setLoading(true);
    _userError = UserError();
    Object? result;
    var response = await MyListService.getMyList();
    if (response is Success) {
      debugPrint("Login view model-> ${response.response}");
      setMyListViewModel(response.response as MyListResponse);
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


  setConfirmed(ListData data, int index) async{
    // setLoadingConfirmed(true);
    setLoadingConfirmed(true,index);
    notifyListeners();
    _userError = UserError();
    Object? result;
    var response = await MyListService.setConfirmed(data.id!);
    if (response is Success) {
      debugPrint("Login view model-> ${response.response}");
      setLoadingConfirmed(false,index);
      _listData[index].confirmed =1;
      notifyListeners();
    }
    if (response is Failure) {
      UserError userError = UserError(
        success: response.code,
        message: response.errorResponse.toString(),
      );
      setUserError(userError);
      result = response;
      data.loading = false;
    }
    // setLoadingConfirmed(false);
    notifyListeners();
    return result;
  }
}

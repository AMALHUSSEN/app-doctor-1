import 'package:smarthealth_hcp/Features/HomeScreen/model/app_version_response/result.dart';

class AppVersionResponse {
  int? success;
  AppVersionResult? result;
  String? message;

  AppVersionResponse({this.success, this.result, this.message});

  AppVersionResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result =
    json['result'] != null ? AppVersionResult.fromJson(json['result']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}
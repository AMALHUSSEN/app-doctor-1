import 'package:smarthealth_hcp/Features/HomeScreen/model/app_version_response/data.dart';

class AppVersionResult {
  AppVersionData? data;

  AppVersionResult({this.data});

  AppVersionResult.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new AppVersionData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
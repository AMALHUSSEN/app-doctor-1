
import 'result.dart';

class BlockProjectResponse {
  int? success;
  BlockProjectResult? result;
  String? message;

  BlockProjectResponse({this.success, this.result, this.message});

  BlockProjectResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result =
    json['result'] != null ? BlockProjectResult.fromJson(json['result']) : null;
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
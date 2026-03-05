import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class LicenseResponse {
  int? success;
  Result? result;
  String? message;

  LicenseResponse({this.success, this.result, this.message});

  @override
  String toString() {
    return 'LicenseResponse(success: $success, result: $result, message: $message)';
  }

  factory LicenseResponse.fromMap(Map<String, dynamic> data) {
    return LicenseResponse(
      success: data['success'] as int?,
      result: data['result'] == null
          ? null
          : Result.fromMap(data['result'] as Map<String, dynamic>),
      message: data['message'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'success': success,
        'result': result?.toMap(),
        'message': message,
      };

  factory LicenseResponse.fromJson(String data) {
    return LicenseResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  LicenseResponse copyWith({
    int? success,
    Result? result,
    String? message,
  }) {
    return LicenseResponse(
      success: success ?? this.success,
      result: result ?? this.result,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LicenseResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ result.hashCode ^ message.hashCode;
}

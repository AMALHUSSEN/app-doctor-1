import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class AppSettingResponse {
  int? success;
  AppSettingResult? result;
  String? message;

  AppSettingResponse({this.success, this.result, this.message});

  @override
  String toString() {
    return 'AppSettingResponse(success: $success, result: $result, message: $message)';
  }

  factory AppSettingResponse.fromMap(Map<String, dynamic> data) {
    return AppSettingResponse(
      success: data['success'] as int?,
      result: data['result'] == null
          ? null
          : AppSettingResult.fromMap(data['result'] as Map<String, dynamic>),
      message: data['message'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'success': success,
        'result': result?.toMap(),
        'message': message,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AppSettingResponse].
  factory AppSettingResponse.fromJson(String data) {
    return AppSettingResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AppSettingResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  AppSettingResponse copyWith({
    int? success,
    AppSettingResult? result,
    String? message,
  }) {
    return AppSettingResponse(
      success: success ?? this.success,
      result: result ?? this.result,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AppSettingResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ result.hashCode ^ message.hashCode;
}

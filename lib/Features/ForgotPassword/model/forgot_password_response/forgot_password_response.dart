// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class ForgotPasswordResponse {
  int? success;
  Result? result;
  String? message;

  ForgotPasswordResponse({this.success, this.result, this.message});

  factory ForgotPasswordResponse.fromMap(Map<String, dynamic> data) {
    return ForgotPasswordResponse(
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

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ForgotPasswordResponse].
  factory ForgotPasswordResponse.fromJson(String data) {
    return ForgotPasswordResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ForgotPasswordResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ForgotPasswordResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ result.hashCode ^ message.hashCode;
}

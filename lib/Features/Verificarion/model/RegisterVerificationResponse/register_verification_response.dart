import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class RegisterVerificationResponse {
  int? success;
  RegisterVerificationResult? result;
  String? message;
  String? token;

  RegisterVerificationResponse({
    this.success,
    this.result,
    this.message,
    this.token,
  });

  @override
  String toString() {
    return 'RegisterVerificationResponse(success: $success, result: $result, message: $message, token: $token)';
  }

  factory RegisterVerificationResponse.fromMap(Map<String, dynamic> data) {
    return RegisterVerificationResponse(
      success: data['success'] as int?,
      result: data['result'] == null
          ? null
          : RegisterVerificationResult.fromMap(
              data['result'] as Map<String, dynamic>),
      message: data['message'] as String?,
      token: data['token'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'success': success,
        'result': result?.toMap(),
        'message': message,
        'token': token,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RegisterVerificationResponse].
  factory RegisterVerificationResponse.fromJson(String data) {
    return RegisterVerificationResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RegisterVerificationResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  RegisterVerificationResponse copyWith({
    int? success,
    RegisterVerificationResult? result,
    String? message,
    String? token,
  }) {
    return RegisterVerificationResponse(
      success: success ?? this.success,
      result: result ?? this.result,
      message: message ?? this.message,
      token: token ?? this.token,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RegisterVerificationResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      success.hashCode ^ result.hashCode ^ message.hashCode ^ token.hashCode;
}

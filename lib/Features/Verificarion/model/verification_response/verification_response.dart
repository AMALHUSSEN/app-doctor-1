import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class VerificationResponse {
  int? success;
  Result? result;
  String? message;
  String? token;

  VerificationResponse({
    this.success,
    this.result,
    this.message,
    this.token,
  });

  @override
  String toString() {
    return 'VerificationResponse(success: $success, result: $result, message: $message, token: $token)';
  }

  factory VerificationResponse.fromMap(Map<String, dynamic> data) {
    return VerificationResponse(
      success: data['success'] as int?,
      result: data['result'] == null
          ? null
          : Result.fromMap(data['result'] as Map<String, dynamic>),
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
  /// Parses the string and returns the resulting Json object as [VerificationResponse].
  factory VerificationResponse.fromJson(String data) {
    return VerificationResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [VerificationResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  VerificationResponse copyWith({
    int? success,
    Result? result,
    String? message,
    String? token,
  }) {
    return VerificationResponse(
      success: success ?? this.success,
      result: result ?? this.result,
      message: message ?? this.message,
      token: token ?? this.token,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! VerificationResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      success.hashCode ^ result.hashCode ^ message.hashCode ^ token.hashCode;
}

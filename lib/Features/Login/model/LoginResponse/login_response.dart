import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class LoginResponse {
  int? success;
  Result? result;
  String? message;
  String? token;

  LoginResponse({this.success, this.result, this.message, this.token});

  @override
  String toString() {
    return 'AuthResponseModel(success: $success, result: $result, message: $message, token: $token)';
  }

  factory LoginResponse.fromMap(Map<String, dynamic> data) {
    return LoginResponse(
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
  /// Parses the string and returns the resulting Json object as [LoginResponse].
  factory LoginResponse.fromJson(String data) {
    return LoginResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  LoginResponse copyWith({
    int? success,
    Result? result,
    String? message,
    String? token,
  }) {
    return LoginResponse(
      success: success ?? this.success,
      result: result ?? this.result,
      message: message ?? this.message,
      token: token ?? this.token,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LoginResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      success.hashCode ^ result.hashCode ^ message.hashCode ^ token.hashCode;
}

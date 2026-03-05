import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class RegisterResponse {
  int? success;
  RegisterResult? result;
  String? message;

  RegisterResponse({this.success, this.result, this.message});

  @override
  String toString() {
    return 'RegisterResponse(success: $success, result: $result, message: $message)';
  }

  factory RegisterResponse.fromMap(Map<String, dynamic> data) {
    return RegisterResponse(
      success: data['success'] as int?,
      result: data['result'] == null
          ? null
          : RegisterResult.fromMap(data['result'] as Map<String, dynamic>),
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
  /// Parses the string and returns the resulting Json object as [RegisterResponse].
  factory RegisterResponse.fromJson(String data) {
    return RegisterResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RegisterResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  RegisterResponse copyWith({
    int? success,
    RegisterResult? result,
    String? message,
  }) {
    return RegisterResponse(
      success: success ?? this.success,
      result: result ?? this.result,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RegisterResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ result.hashCode ^ message.hashCode;
}

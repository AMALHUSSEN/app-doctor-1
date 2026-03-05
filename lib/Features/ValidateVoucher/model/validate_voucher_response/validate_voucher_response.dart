import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class ValidateVoucherResponse {
  int? success;
  Result? result;
  String? message;

  ValidateVoucherResponse({this.success, this.result, this.message});

  factory ValidateVoucherResponse.fromMap(Map<String, dynamic> data) {
    return ValidateVoucherResponse(
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
  /// Parses the string and returns the resulting Json object as [ValidateVoucherResponse].
  factory ValidateVoucherResponse.fromJson(String data) {
    return ValidateVoucherResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ValidateVoucherResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ValidateVoucherResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ result.hashCode ^ message.hashCode;
}

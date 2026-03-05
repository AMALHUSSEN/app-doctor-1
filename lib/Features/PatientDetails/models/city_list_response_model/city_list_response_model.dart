import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class CityListResponse {
  int? success;
  Result? result;
  String? message;

  CityListResponse({this.success, this.result, this.message});

  @override
  String toString() {
    return 'CityListResponseModel(success: $success, result: $result, message: $message)';
  }

  factory CityListResponse.fromMap(Map<String, dynamic> data) {
    return CityListResponse(
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
  /// Parses the string and returns the resulting Json object as [CityListResponse].
  factory CityListResponse.fromJson(String data) {
    return CityListResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CityListResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  CityListResponse copyWith({
    int? success,
    Result? result,
    String? message,
  }) {
    return CityListResponse(
      success: success ?? this.success,
      result: result ?? this.result,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CityListResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ result.hashCode ^ message.hashCode;
}

import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class ProjectConsentDetailResponse {
  int? success;
  Result? result;
  String? message;

  ProjectConsentDetailResponse({this.success, this.result, this.message});

  @override
  String toString() {
    return 'ProjectConsentDetailResponse(success: $success, result: $result, message: $message)';
  }

  factory ProjectConsentDetailResponse.fromMap(Map<String, dynamic> data) {
    return ProjectConsentDetailResponse(
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
  /// Parses the string and returns the resulting Json object as [ProjectConsentDetailResponse].
  factory ProjectConsentDetailResponse.fromJson(String data) {
    return ProjectConsentDetailResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProjectConsentDetailResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  ProjectConsentDetailResponse copyWith({
    int? success,
    Result? result,
    String? message,
  }) {
    return ProjectConsentDetailResponse(
      success: success ?? this.success,
      result: result ?? this.result,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ProjectConsentDetailResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ result.hashCode ^ message.hashCode;
}

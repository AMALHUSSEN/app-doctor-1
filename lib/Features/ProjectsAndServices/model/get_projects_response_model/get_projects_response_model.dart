import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class ProjectsResponse {
  int? success;
  Result? result;
  String? message;

  ProjectsResponse({this.success, this.result, this.message});

  @override
  String toString() {
    return 'GetProjectsResponseModel(success: $success, result: $result, message: $message)';
  }

  factory ProjectsResponse.fromMap(Map<String, dynamic> data) {
    return ProjectsResponse(
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
  /// Parses the string and returns the resulting Json object as [ProjectsResponse].
  factory ProjectsResponse.fromJson(String data) {
    return ProjectsResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProjectsResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  ProjectsResponse copyWith({
    int? success,
    Result? result,
    String? message,
  }) {
    return ProjectsResponse(
      success: success ?? this.success,
      result: result ?? this.result,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ProjectsResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ result.hashCode ^ message.hashCode;
}

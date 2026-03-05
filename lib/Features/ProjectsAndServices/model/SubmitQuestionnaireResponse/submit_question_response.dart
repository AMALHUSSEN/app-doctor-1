import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class SubmitQuestionResponse {
  int? success;
  Result? result;
  String? message;

  SubmitQuestionResponse({this.success, this.result, this.message});

  @override
  String toString() {
    return 'SubmitQuestionResponse(success: $success, result: $result, message: $message)';
  }

  factory SubmitQuestionResponse.fromMap(Map<String, dynamic> data) {
    return SubmitQuestionResponse(
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
  /// Parses the string and returns the resulting Json object as [SubmitQuestionResponse].
  factory SubmitQuestionResponse.fromJson(String data) {
    return SubmitQuestionResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SubmitQuestionResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  SubmitQuestionResponse copyWith({
    int? success,
    Result? result,
    String? message,
  }) {
    return SubmitQuestionResponse(
      success: success ?? this.success,
      result: result ?? this.result,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SubmitQuestionResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ result.hashCode ^ message.hashCode;
}

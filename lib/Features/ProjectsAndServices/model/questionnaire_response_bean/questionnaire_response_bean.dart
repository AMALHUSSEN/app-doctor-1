import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class QuestionnaireResponse {
  int? success;
  Result? result;
  String? message;

  QuestionnaireResponse({this.success, this.result, this.message});

  @override
  String toString() {
    return 'QuestionnaireResponseBean(success: $success, result: $result, message: $message)';
  }

  factory QuestionnaireResponse.fromMap(Map<String, dynamic> data) {
    return QuestionnaireResponse(
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
  /// Parses the string and returns the resulting Json object as [QuestionnaireResponse].
  factory QuestionnaireResponse.fromJson(String data) {
    return QuestionnaireResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [QuestionnaireResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  QuestionnaireResponse copyWith({
    int? success,
    Result? result,
    String? message,
  }) {
    return QuestionnaireResponse(
      success: success ?? this.success,
      result: result ?? this.result,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! QuestionnaireResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ result.hashCode ^ message.hashCode;
}

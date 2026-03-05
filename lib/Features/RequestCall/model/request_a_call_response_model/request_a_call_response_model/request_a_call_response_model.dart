import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class RequestACallResponse {
  int? success;
  Result? result;
  String? message;

  RequestACallResponse({this.success, this.result, this.message});

  @override
  String toString() {
    return 'RequestACallResponseModel(success: $success, result: $result, message: $message)';
  }

  factory RequestACallResponse.fromMap(Map<String, dynamic> data) {
    return RequestACallResponse(
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
  /// Parses the string and returns the resulting Json object as [RequestACallResponse].
  factory RequestACallResponse.fromJson(String data) {
    return RequestACallResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RequestACallResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  RequestACallResponse copyWith({
    int? success,
    Result? result,
    String? message,
  }) {
    return RequestACallResponse(
      success: success ?? this.success,
      result: result ?? this.result,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RequestACallResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ result.hashCode ^ message.hashCode;
}

import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class MyListResponse {
  int? success;
  Result? result;
  String? message;

  MyListResponse({this.success, this.result, this.message});

  @override
  String toString() {
    return 'MyListResponseModel(success: $success, result: $result, message: $message)';
  }

  factory MyListResponse.fromMap(Map<String, dynamic> data) {
    return MyListResponse(
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
  /// Parses the string and returns the resulting Json object as [MyListResponse].
  factory MyListResponse.fromJson(String data) {
    return MyListResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MyListResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  MyListResponse copyWith({
    int? success,
    Result? result,
    String? message,
  }) {
    return MyListResponse(
      success: success ?? this.success,
      result: result ?? this.result,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MyListResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ result.hashCode ^ message.hashCode;
}

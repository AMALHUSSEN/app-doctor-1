import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class CmsResponse {
  int? success;
  CMSResult? result;
  String? message;

  CmsResponse({this.success, this.result, this.message});

  @override
  String toString() {
    return 'CmsResponse(success: $success, result: $result, message: $message)';
  }

  factory CmsResponse.fromMap(Map<String, dynamic> data) => CmsResponse(
        success: data['success'] as int?,
        result: data['result'] == null
            ? null
            : CMSResult.fromMap(data['result'] as Map<String, dynamic>),
        message: data['message'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'success': success,
        'result': result?.toMap(),
        'message': message,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CmsResponse].
  factory CmsResponse.fromJson(String data) {
    return CmsResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CmsResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  CmsResponse copyWith({
    int? success,
    CMSResult? result,
    String? message,
  }) {
    return CmsResponse(
      success: success ?? this.success,
      result: result ?? this.result,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CmsResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ result.hashCode ^ message.hashCode;
}

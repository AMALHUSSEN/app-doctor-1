import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class ConsentFormResponseBean {
  int? success;
  ConsentFormResult? result;
  String? message;

  ConsentFormResponseBean({this.success, this.result, this.message});

  @override
  String toString() {
    return 'ConsentFormResponseBean(success: $success, result: $result, message: $message)';
  }

  factory ConsentFormResponseBean.fromMap(Map<String, dynamic> data) {
    return ConsentFormResponseBean(
      success: data['success'] as int?,
      result: data['result'] == null
          ? null
          : ConsentFormResult.fromMap(data['result'] as Map<String, dynamic>),
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
  /// Parses the string and returns the resulting Json object as [ConsentFormResponseBean].
  factory ConsentFormResponseBean.fromJson(String data) {
    return ConsentFormResponseBean.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ConsentFormResponseBean] to a JSON string.
  String toJson() => json.encode(toMap());

  ConsentFormResponseBean copyWith({
    int? success,
    ConsentFormResult? result,
    String? message,
  }) {
    return ConsentFormResponseBean(
      success: success ?? this.success,
      result: result ?? this.result,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ConsentFormResponseBean) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ result.hashCode ^ message.hashCode;
}

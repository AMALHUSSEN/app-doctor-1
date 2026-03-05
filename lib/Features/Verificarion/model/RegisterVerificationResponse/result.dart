import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class RegisterVerificationResult {
  RegisterVerificationData? data;

  RegisterVerificationResult({this.data});

  @override
  String toString() => 'Result(data: $data)';

  factory RegisterVerificationResult.fromMap(Map<String, dynamic> data) =>
      RegisterVerificationResult(
        data: data['data'] == null
            ? null
            : RegisterVerificationData.fromMap(
                data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RegisterVerificationResult].
  factory RegisterVerificationResult.fromJson(String data) {
    return RegisterVerificationResult.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RegisterVerificationResult] to a JSON string.
  String toJson() => json.encode(toMap());

  RegisterVerificationResult copyWith({
    RegisterVerificationData? data,
  }) {
    return RegisterVerificationResult(
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RegisterVerificationResult) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => data.hashCode;
}

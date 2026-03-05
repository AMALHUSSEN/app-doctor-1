import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class RegisterResult {
  RegisterData? data;

  RegisterResult({this.data});

  @override
  String toString() => 'Result(data: $data)';

  factory RegisterResult.fromMap(Map<String, dynamic> data) => RegisterResult(
        data: data['data'] == null
            ? null
            : RegisterData.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RegisterResult].
  factory RegisterResult.fromJson(String data) {
    return RegisterResult.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RegisterResult] to a JSON string.
  String toJson() => json.encode(toMap());

  RegisterResult copyWith({
    RegisterData? data,
  }) {
    return RegisterResult(
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RegisterResult) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => data.hashCode;
}

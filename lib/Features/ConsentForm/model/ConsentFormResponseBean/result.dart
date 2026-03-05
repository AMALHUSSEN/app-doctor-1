import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class ConsentFormResult {
  ConsentFormData? data;

  ConsentFormResult({this.data});

  @override
  String toString() => 'Result(data: $data)';

  factory ConsentFormResult.fromMap(Map<String, dynamic> data) =>
      ConsentFormResult(
        data: data['data'] == null
            ? null
            : ConsentFormData.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ConsentFormResult].
  factory ConsentFormResult.fromJson(String data) {
    return ConsentFormResult.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ConsentFormResult] to a JSON string.
  String toJson() => json.encode(toMap());

  ConsentFormResult copyWith({
    ConsentFormData? data,
  }) {
    return ConsentFormResult(
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ConsentFormResult) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => data.hashCode;
}

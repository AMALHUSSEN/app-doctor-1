// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class CMSResult {
  CMSData? data;

  CMSResult({this.data});

  @override
  String toString() => 'Result(data: $data)';

  factory CMSResult.fromMap(Map<String, dynamic> data) => CMSResult(
        data: data['data'] == null
            ? null
            : CMSData.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CMSResult].
  factory CMSResult.fromJson(String data) {
    return CMSResult.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CMSResult] to a JSON string.
  String toJson() => json.encode(toMap());

  CMSResult copyWith({
    CMSData? data,
  }) {
    return CMSResult(
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CMSResult) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => data.hashCode;
}

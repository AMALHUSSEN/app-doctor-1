import 'dart:convert';

import 'package:collection/collection.dart';

class Result {
  List<dynamic>? data;

  Result({this.data});

  factory Result.fromMap(Map<String, dynamic> data) => Result(
        data: data['data'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'data': data,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Result].
  factory Result.fromJson(String data) {
    return Result.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Result] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Result) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => data.hashCode;
}

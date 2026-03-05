import 'dart:convert';

import 'package:collection/collection.dart';

import 'city_data.dart';

class Result {
  List<CityData>? data;

  Result({this.data});

  @override
  String toString() => 'Result(data: $data)';

  factory Result.fromMap(Map<String, dynamic> data) => Result(
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => CityData.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.map((e) => e.toMap()).toList(),
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

  Result copyWith({
    List<CityData>? data,
  }) {
    return Result(
      data: data ?? this.data,
    );
  }

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

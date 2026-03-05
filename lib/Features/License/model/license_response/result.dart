import 'dart:convert';

import 'package:collection/collection.dart';

import 'license_data.dart';

class Result {
  List<LicenseData>? data;

  Result({this.data});

  @override
  String toString() => 'Result(data: $data)';

  factory Result.fromMap(Map<String, dynamic> data) => Result(
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => LicenseData.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.map((e) => e.toMap()).toList(),
      };

  factory Result.fromJson(String data) {
    return Result.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  Result copyWith({
    List<LicenseData>? data,
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

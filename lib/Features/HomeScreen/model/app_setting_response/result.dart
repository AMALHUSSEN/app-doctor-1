import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class AppSettingResult {
  AppSettingData? data;

  AppSettingResult({this.data});

  @override
  String toString() => 'Result(data: $data)';

  factory AppSettingResult.fromMap(Map<String, dynamic> data) =>
      AppSettingResult(
        data: data['data'] == null
            ? null
            : AppSettingData.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AppSettingResult].
  factory AppSettingResult.fromJson(String data) {
    return AppSettingResult.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AppSettingResult] to a JSON string.
  String toJson() => json.encode(toMap());

  AppSettingResult copyWith({
    AppSettingData? data,
  }) {
    return AppSettingResult(
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AppSettingResult) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => data.hashCode;
}

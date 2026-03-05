import 'dart:convert';

import 'package:collection/collection.dart';

class CountriesData {
  int? id;
  String? countryName;
  String? shortName;
  String? countryCode;

  CountriesData({this.id, this.countryName, this.shortName, this.countryCode});

  @override
  String toString() {
    return 'Datum(id: $id, countryName: $countryName, shortName: $shortName, countryCode: $countryCode)';
  }

  factory CountriesData.fromMap(Map<String, dynamic> data) => CountriesData(
        id: data['id'] as int?,
        countryName: data['country_name'] as String?,
        shortName: data['short_name'] as String?,
        countryCode: data['country_code'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'country_name': countryName,
        'short_name': shortName,
        'country_code': countryCode,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CountriesData].
  factory CountriesData.fromJson(String data) {
    return CountriesData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CountriesData] to a JSON string.
  String toJson() => json.encode(toMap());

  CountriesData copyWith({
    int? id,
    String? countryName,
    String? shortName,
    String? countryCode,
  }) {
    return CountriesData(
      id: id ?? this.id,
      countryName: countryName ?? this.countryName,
      shortName: shortName ?? this.shortName,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CountriesData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      countryName.hashCode ^
      shortName.hashCode ^
      countryCode.hashCode;
}

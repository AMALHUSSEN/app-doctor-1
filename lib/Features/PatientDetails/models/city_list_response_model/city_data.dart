import 'dart:convert';

import 'package:collection/collection.dart';

class CityData {
  int? id;
  String? title;
  String? titleAr;

  CityData({this.id, this.title, this.titleAr});

  @override
  String toString() => 'Datum(id: $id, title: $title, titleAr: $titleAr)';

  factory CityData.fromMap(Map<String, dynamic> data) => CityData(
        id: data['id'] as int?,
        title: data['title'] as String?,
        titleAr: data['title_ar'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'title_ar': titleAr,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CityData].
  factory CityData.fromJson(String data) {
    return CityData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CityData] to a JSON string.
  String toJson() => json.encode(toMap());

  CityData copyWith({
    int? id,
    String? title,
    String? titleAr,
  }) {
    return CityData(
      id: id ?? this.id,
      title: title ?? this.title,
      titleAr: titleAr ?? this.titleAr,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CityData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ titleAr.hashCode;
}

import 'dart:convert';

import 'package:collection/collection.dart';

class SpecialityData {
  int? id;
  String? title;

  SpecialityData({this.id, this.title});

  @override
  String toString() => 'Datum(id: $id, title: $title,)';

  factory SpecialityData.fromMap(Map<String, dynamic> data) => SpecialityData(
        id: data['id'] as int?,
        title: data['title'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CityData].
  factory SpecialityData.fromJson(String data) {
    return SpecialityData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CityData] to a JSON string.
  String toJson() => json.encode(toMap());

  SpecialityData copyWith({
    int? id,
    String? title,
  }) {
    return SpecialityData(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SpecialityData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}

import 'dart:convert';

import 'package:collection/collection.dart';

class Questionnaire {
  int? id;
  String? title;
  dynamic shortDescription;

  Questionnaire({this.id, this.title, this.shortDescription});

  @override
  String toString() {
    return 'Questionnaire(id: $id, title: $title, shortDescription: $shortDescription)';
  }

  factory Questionnaire.fromMap(Map<String, dynamic> data) => Questionnaire(
        id: data['id'] as int?,
        title: data['title'] as String?,
        shortDescription: data['short_description'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'short_description': shortDescription,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Questionnaire].
  factory Questionnaire.fromJson(String data) {
    return Questionnaire.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Questionnaire] to a JSON string.
  String toJson() => json.encode(toMap());

  Questionnaire copyWith({
    int? id,
    String? title,
    dynamic shortDescription,
  }) {
    return Questionnaire(
      id: id ?? this.id,
      title: title ?? this.title,
      shortDescription: shortDescription ?? this.shortDescription,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Questionnaire) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ shortDescription.hashCode;
}

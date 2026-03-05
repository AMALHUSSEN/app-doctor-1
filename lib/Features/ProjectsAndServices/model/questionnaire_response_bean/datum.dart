import 'dart:convert';

import 'package:collection/collection.dart';

import 'option.dart';

class QuestionnaireData {
  int? id;
  String? title;
  String? type;
  List<Option>? options;

  QuestionnaireData({this.id, this.title, this.type, this.options});

  @override
  String toString() {
    return 'Datum(id: $id, title: $title, type: $type, options: $options)';
  }

  factory QuestionnaireData.fromMap(Map<String, dynamic> data) =>
      QuestionnaireData(
        id: data['id'] as int?,
        title: data['title'] as String?,
        type: data['type'] as String?,
        options: (data['options'] as List<dynamic>?)
            ?.map((e) => Option.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'type': type,
        'options': options?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [QuestionnaireData].
  factory QuestionnaireData.fromJson(String data) {
    return QuestionnaireData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [QuestionnaireData] to a JSON string.
  String toJson() => json.encode(toMap());

  QuestionnaireData copyWith({
    int? id,
    String? title,
    String? type,
    List<Option>? options,
  }) {
    return QuestionnaireData(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      options: options ?? this.options,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! QuestionnaireData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ type.hashCode ^ options.hashCode;
}

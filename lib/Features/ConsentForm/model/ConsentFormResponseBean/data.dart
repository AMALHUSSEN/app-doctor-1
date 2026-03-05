import 'dart:convert';

import 'package:collection/collection.dart';

class ConsentFormData {
  int? id;
  String? title;
  String? content;

  ConsentFormData({this.id, this.title, this.content});

  @override
  String toString() => 'Data(id: $id, title: $title, content: $content)';

  factory ConsentFormData.fromMap(Map<String, dynamic> data) => ConsentFormData(
        id: data['id'] as int?,
        title: data['title'] as String?,
        content: data['content'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'content': content,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ConsentFormData].
  factory ConsentFormData.fromJson(String data) {
    return ConsentFormData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ConsentFormData] to a JSON string.
  String toJson() => json.encode(toMap());

  ConsentFormData copyWith({
    int? id,
    String? title,
    String? content,
  }) {
    return ConsentFormData(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ConsentFormData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ content.hashCode;
}

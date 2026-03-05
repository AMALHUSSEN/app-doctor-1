// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:collection/collection.dart';

class CMSData {
  int? id;
  String? title;
  String? titleAr;
  String? content;
  String? contentAr;

  CMSData({this.id, this.title, this.titleAr, this.content, this.contentAr});

  @override
  String toString() {
    return 'Data(id: $id, title: $title, titleAr: $titleAr, content: $content, contentAr: $contentAr)';
  }

  factory CMSData.fromMap(Map<String, dynamic> data) => CMSData(
        id: data['id'] as int?,
        title: data['title'] as String?,
        titleAr: data['title_ar'] as String?,
        content: data['content'] as String?,
        contentAr: data['content_ar'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'title_ar': titleAr,
        'content': content,
        'content_ar': contentAr,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CMSData].
  factory CMSData.fromJson(String data) {
    return CMSData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CMSData] to a JSON string.
  String toJson() => json.encode(toMap());

  CMSData copyWith({
    int? id,
    String? title,
    String? titleAr,
    String? content,
    String? contentAr,
  }) {
    return CMSData(
      id: id ?? this.id,
      title: title ?? this.title,
      titleAr: titleAr ?? this.titleAr,
      content: content ?? this.content,
      contentAr: contentAr ?? this.contentAr,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CMSData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      titleAr.hashCode ^
      content.hashCode ^
      contentAr.hashCode;
}

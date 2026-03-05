import 'dart:convert';

import 'package:collection/collection.dart';

class Link {
  dynamic url;
  String? label;
  bool? active;

  Link({this.url, this.label, this.active});

  @override
  String toString() => 'Link(url: $url, label: $label, active: $active)';

  factory Link.fromMap(Map<String, dynamic> data) => Link(
        url: data['url'] as dynamic,
        label: data['label'] as String?,
        active: data['active'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'url': url,
        'label': label,
        'active': active,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Link].
  factory Link.fromJson(String data) {
    return Link.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Link] to a JSON string.
  String toJson() => json.encode(toMap());

  Link copyWith({
    dynamic url,
    String? label,
    bool? active,
  }) {
    return Link(
      url: url ?? this.url,
      label: label ?? this.label,
      active: active ?? this.active,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Link) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => url.hashCode ^ label.hashCode ^ active.hashCode;
}

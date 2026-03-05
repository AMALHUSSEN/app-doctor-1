import 'dart:convert';

import 'package:collection/collection.dart';

class AppSettingData {
  String? welcomeTitle;
  String? tagline;
  String? logoUrl;

  AppSettingData({this.welcomeTitle, this.tagline, this.logoUrl});

  @override
  String toString() {
    return 'Data(welcomeTitle: $welcomeTitle, tagline: $tagline, logoUrl: $logoUrl)';
  }

  factory AppSettingData.fromMap(Map<String, dynamic> data) => AppSettingData(
        welcomeTitle: data['welcome_title'] as String?,
        tagline: data['tagline'] as String?,
        logoUrl: data['logo_url'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'welcome_title': welcomeTitle,
        'tagline': tagline,
        'logo_url': logoUrl,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AppSettingData].
  factory AppSettingData.fromJson(String data) {
    return AppSettingData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AppSettingData] to a JSON string.
  String toJson() => json.encode(toMap());

  AppSettingData copyWith({
    String? welcomeTitle,
    String? tagline,
    String? logoUrl,
  }) {
    return AppSettingData(
      welcomeTitle: welcomeTitle ?? this.welcomeTitle,
      tagline: tagline ?? this.tagline,
      logoUrl: logoUrl ?? this.logoUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AppSettingData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      welcomeTitle.hashCode ^ tagline.hashCode ^ logoUrl.hashCode;
}

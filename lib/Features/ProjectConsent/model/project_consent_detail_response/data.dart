import 'dart:convert';

import 'package:collection/collection.dart';

class ProjectConsentData {
  int? id;
  String? name;
  String? projectCode;
  String? imagePath;
  String? description;
  String? consent;
  String? consentForm;
  int? status;
  int? pivotId;

  ProjectConsentData({
    this.id,
    this.name,
    this.projectCode,
    this.imagePath,
    this.description,
    this.consent,
    this.consentForm,
    this.status,
    this.pivotId,
  });

  @override
  String toString() {
    return 'Data(id: $id, name: $name, projectCode: $projectCode, imagePath: $imagePath, description: $description, consent: $consent, consentForm: $consentForm, status: $status, pivotId: $pivotId)';
  }

  factory ProjectConsentData.fromMap(Map<String, dynamic> data) =>
      ProjectConsentData(
        id: data['id'] as int?,
        name: data['name'] as String?,
        projectCode: data['project_code'] as String?,
        imagePath: data['image_path'] as String?,
        description: data['description'] as String?,
        consent: data['consent'] as String?,
        consentForm: data['consent_form'] as String?,
        status: data['status'] as int?,
        pivotId: data['pivot_id'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'project_code': projectCode,
        'image_path': imagePath,
        'description': description,
        'consent': consent,
        'consent_form': consentForm,
        'status': status,
        'pivot_id': pivotId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProjectConsentData].
  factory ProjectConsentData.fromJson(String data) {
    return ProjectConsentData.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProjectConsentData] to a JSON string.
  String toJson() => json.encode(toMap());

  ProjectConsentData copyWith({
    int? id,
    String? name,
    String? projectCode,
    String? imagePath,
    String? description,
    String? consent,
    String? consentForm,
    int? status,
    int? pivotId,
  }) {
    return ProjectConsentData(
      id: id ?? this.id,
      name: name ?? this.name,
      projectCode: projectCode ?? this.projectCode,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      consent: consent ?? this.consent,
      consentForm: consentForm ?? this.consentForm,
      status: status ?? this.status,
      pivotId: pivotId ?? this.pivotId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ProjectConsentData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      projectCode.hashCode ^
      imagePath.hashCode ^
      description.hashCode ^
      consent.hashCode ^
      consentForm.hashCode ^
      status.hashCode ^
      pivotId.hashCode;
}

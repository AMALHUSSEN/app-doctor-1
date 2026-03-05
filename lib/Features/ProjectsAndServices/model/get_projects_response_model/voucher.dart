import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/questionnaire_response_bean/datum.dart';

import 'questionnaire.dart';

class Voucher {
  int? id;
  String? title;
  String? shortDescription;
  int? allowRegistration;
  String? certificationText;
  String? successMessage;
  String? createdAt;
  String? expired;
  int? skipQuestionnaire;
  int? skipPatientName;
  int? skipPatientId;
  int? skipPatientPhone;
  int? skipPatientCity;
  int? skipPatientCountry;
  int? skipPatientDateOfBirth;
  int? skipConsent;
  int? numberPageConsent;
  int? skipPatientDetails;
  int? skipShareVoucher;
  int? activeConfirmed;
  int? skipPatientLastName;
  List<QuestionnaireData>? questionnaires;

  Voucher(
      {this.id,
      this.title,
      this.shortDescription,
      this.allowRegistration,
      this.certificationText,
      this.successMessage,
      this.createdAt,
      this.expired,
      this.questionnaires,
      this.skipQuestionnaire,
      this.skipPatientName,
      this.skipPatientId,
      this.skipPatientPhone,
      this.skipPatientCity,
      this.skipPatientCountry,
      this.skipPatientDateOfBirth,
      this.skipConsent,
      this.numberPageConsent,
      this.skipPatientDetails,
      this.skipShareVoucher,
      this.activeConfirmed,
      this.skipPatientLastName
      });

  @override
  String toString() {
    return 'Voucher(id: $id, title: $title, shortDescription: $shortDescription, allowRegistration: $allowRegistration, certificationText: $certificationText, successMessage: $successMessage, createdAt: $createdAt, expired: $expired, questionnaires: $questionnaires)';
  }

  factory Voucher.fromMap(Map<String, dynamic> data) => Voucher(
        id: data['id'] as int?,
        title: data['title'] as String?,
        shortDescription: data['short_description'] as String?,
        allowRegistration: data['allow_registration'] as int?,
        certificationText: data['certification_text'] as String?,
        successMessage: data['success_message'] as String?,
        createdAt: data['created_at'] as String?,
        expired: data['expired'] as String?,
        skipQuestionnaire: data['skip_questionnaire'] as int?,
        skipConsent: data['skip_consent'] as int?,
        skipPatientDetails: data['skip_patient_details'] as int?,
        skipPatientName: data['skip_patient_name'] as int?,
        skipPatientId: data['skip_patient_id'] as int?,
        skipPatientCity: data['skip_patient_city'] as int?,
        skipPatientCountry: data['skip_patient_country'] as int?,
        skipShareVoucher: data['skip_share_voucher'] as int?,
        skipPatientPhone: data['skip_patient_phone'] as int?,
        activeConfirmed: data['active_confirmed'] as int?,
        numberPageConsent: data['number_page_consent'] as int?,
        skipPatientDateOfBirth: data['skip_patient_date_of_birth'] as int?,
        skipPatientLastName: data['skip_patient_last_name'] as int?,
        questionnaires: (data['questionnaires'] as List<dynamic>?)
            ?.map((e) => QuestionnaireData.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'short_description': shortDescription,
        'allow_registration': allowRegistration,
        'certification_text': certificationText,
        'success_message': successMessage,
        'created_at': createdAt,
        'expired': expired,
        'skip_questionnaire': skipQuestionnaire,
        'skip_consent': skipConsent,
        'skip_patient_details': skipPatientDetails,
        'skip_patient_name': skipPatientName,
        'skip_patient_id': skipPatientId,
        'skip_patient_city': skipPatientCity,
        'skip_patient_country': skipPatientCountry,
        'skip_share_voucher': skipShareVoucher,
        'skip_patient_phone': skipPatientPhone,
        'skip_patient_date_of_birth': skipPatientDateOfBirth,
        'active_confirmed': activeConfirmed,
        'number_page_consent': numberPageConsent,
        'skip_patient_last_name': skipPatientLastName,
        'questionnaires': questionnaires?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Voucher].
  factory Voucher.fromJson(String data) {
    return Voucher.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Voucher] to a JSON string.
  String toJson() => json.encode(toMap());

  Voucher copyWith({
    int? id,
    String? title,
    String? shortDescription,
    int? allowRegistration,
    String? certificationText,
    String? successMessage,
    String? createdAt,
    String? expired,
    int? skipQuestionnaire,
    int? skipConsent,
    int? skipPatientDetails,
    int? skipPatientName,
    int? skipPatientId,
    int? skipPatientCity,
    int? skipPatientCountry,
    int? disableRequestCall,
    int? disableRedeemVoucher,
    int? skipShareVoucher,
    int? skipPatientPhone,
    int? skipPatientDateOfBirth,
    int? activeConfirmed,
    int? numberPageConsent,
    int? skipPatientLastName,
    List<QuestionnaireData>? questionnaires,
  }) {
    return Voucher(
      id: id ?? this.id,
      title: title ?? this.title,
      shortDescription: shortDescription ?? this.shortDescription,
      allowRegistration: allowRegistration ?? this.allowRegistration,
      certificationText: certificationText ?? this.certificationText,
      successMessage: successMessage ?? this.successMessage,
      createdAt: createdAt ?? this.createdAt,
      expired: expired ?? this.expired,
      questionnaires: questionnaires ?? this.questionnaires,
      skipQuestionnaire: skipQuestionnaire ?? this.skipQuestionnaire,
      skipConsent: skipConsent ?? this.skipConsent,
      skipPatientDetails: skipPatientDetails ?? this.skipPatientDetails,
      skipPatientName: skipPatientName ?? this.skipPatientName,
      skipPatientId: skipPatientId ?? this.skipPatientId,
      skipPatientCity: skipPatientCity ?? this.skipPatientCity,
      skipPatientCountry: skipPatientCountry ?? this.skipPatientCountry,
      skipShareVoucher: skipShareVoucher ?? this.skipShareVoucher,
      skipPatientPhone: skipPatientPhone ?? this.skipPatientPhone,
      skipPatientDateOfBirth: skipPatientDateOfBirth ?? this.skipPatientDateOfBirth,
      activeConfirmed: activeConfirmed ?? this.activeConfirmed,
      numberPageConsent: numberPageConsent ?? this.numberPageConsent,
      skipPatientLastName: skipPatientLastName ?? this.skipPatientLastName
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Voucher) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      shortDescription.hashCode ^
      allowRegistration.hashCode ^
      certificationText.hashCode ^
      successMessage.hashCode ^
      createdAt.hashCode ^
      expired.hashCode ^
      skipQuestionnaire.hashCode ^
      skipConsent.hashCode ^
      skipPatientDetails.hashCode ^
      skipPatientName.hashCode ^
      skipPatientId.hashCode ^
      skipPatientCity.hashCode ^
      skipPatientCountry.hashCode ^
      skipShareVoucher.hashCode ^
      skipPatientPhone.hashCode ^
      skipPatientDateOfBirth.hashCode ^
      activeConfirmed.hashCode ^
      numberPageConsent.hashCode ^
      skipPatientLastName.hashCode ^
      questionnaires.hashCode;
}

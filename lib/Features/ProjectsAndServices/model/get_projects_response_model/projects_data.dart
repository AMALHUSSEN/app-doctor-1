import 'dart:convert';

import 'package:collection/collection.dart';

import 'voucher.dart';

class ProjectsData {
  int? id;
  String? title;
  String? description;
  String? logoUrl;
  int? skipQuestionnaire;
  int? skipConsent;
  int? skipPatientDetails;
  int? skipPatientName;
  int? skipPatientId;
  int? skipPatientCity;
  int? skipPatientCountry;
  int? disableRequestCall;
  int? disableRedeemVoucher;
  int? skipShareVoucher;
  int? skipPatientPhone;
  int? skipPatientDateOfBirth;
  List<Voucher>? vouchers;

  ProjectsData({
    this.id,
    this.title,
    this.description,
    this.logoUrl,
    this.skipQuestionnaire,
    this.skipConsent,
    this.skipPatientDetails,
    this.skipPatientName,
    this.skipPatientId,
    this.skipPatientCity,
    this.skipPatientCountry,
    this.disableRequestCall,
    this.disableRedeemVoucher,
    this.skipShareVoucher,
    this.skipPatientPhone,
    this.skipPatientDateOfBirth,
    this.vouchers,
  });

  @override
  String toString() {
    return 'Datum(id: $id, title: $title, description: $description, logoUrl: $logoUrl, skipQuestionnaire: $skipQuestionnaire, skipConsent: $skipConsent, skipPatientDetails: $skipPatientDetails, skipPatientName: $skipPatientName, skipPatientId: $skipPatientId, skipPatientCity: $skipPatientCity, skipPatientCountry: $skipPatientCountry, disableRequestCall: $disableRequestCall, disableRedeemVoucher: $disableRedeemVoucher, skipShareVoucher: $skipShareVoucher, vouchers: $vouchers, skip_patient_phone: $skipPatientPhone)';
  }

  factory ProjectsData.fromMap(Map<String, dynamic> data) => ProjectsData(
        id: data['id'] as int?,
        title: data['title'] as String?,
        description: data['description'] as String?,
        logoUrl: data['logo_url'] as String?,
        skipQuestionnaire: data['skip_questionnaire'] as int?,
        skipConsent: data['skip_consent'] as int?,
        skipPatientDetails: data['skip_patient_details'] as int?,
        skipPatientName: data['skip_patient_name'] as int?,
        skipPatientId: data['skip_patient_id'] as int?,
        skipPatientCity: data['skip_patient_city'] as int?,
        skipPatientCountry: data['skip_patient_country'] as int?,
        disableRequestCall: data['disable_request_call'] as int?,
        disableRedeemVoucher: data['disable_redeem_voucher'] as int?,
        skipShareVoucher: data['skip_share_voucher'] as int?,
        skipPatientPhone: data['skip_patient_phone'] as int?,
        skipPatientDateOfBirth: data['skip_patient_date_of_birth'] as int?,
        vouchers: (data['vouchers'] as List<dynamic>?)
            ?.map((e) => Voucher.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'logo_url': logoUrl,
        'skip_questionnaire': skipQuestionnaire,
        'skip_consent': skipConsent,
        'skip_patient_details': skipPatientDetails,
        'skip_patient_name': skipPatientName,
        'skip_patient_id': skipPatientId,
        'skip_patient_city': skipPatientCity,
        'skip_patient_country': skipPatientCountry,
        'disable_request_call': disableRequestCall,
        'disable_redeem_voucher': disableRedeemVoucher,
        'skip_share_voucher': skipShareVoucher,
        'skip_patient_phone': skipPatientPhone,
        'skip_patient_date_of_birth': skipPatientDateOfBirth,
        'vouchers': vouchers?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProjectsData].
  factory ProjectsData.fromJson(String data) {
    return ProjectsData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProjectsData] to a JSON string.
  String toJson() => json.encode(toMap());

  ProjectsData copyWith({
    int? id,
    String? title,
    String? description,
    String? logoUrl,
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
    List<Voucher>? vouchers,
  }) {
    return ProjectsData(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      logoUrl: logoUrl ?? this.logoUrl,
      skipQuestionnaire: skipQuestionnaire ?? this.skipQuestionnaire,
      skipConsent: skipConsent ?? this.skipConsent,
      skipPatientDetails: skipPatientDetails ?? this.skipPatientDetails,
      skipPatientName: skipPatientName ?? this.skipPatientName,
      skipPatientId: skipPatientId ?? this.skipPatientId,
      skipPatientCity: skipPatientCity ?? this.skipPatientCity,
      skipPatientCountry: skipPatientCountry ?? this.skipPatientCountry,
      disableRequestCall: disableRequestCall ?? this.disableRequestCall,
      disableRedeemVoucher: disableRedeemVoucher ?? this.disableRedeemVoucher,
      skipShareVoucher: skipShareVoucher ?? this.skipShareVoucher,
      skipPatientPhone: skipPatientPhone ?? this.skipPatientPhone,
      skipPatientDateOfBirth: skipPatientDateOfBirth ?? this.skipPatientDateOfBirth,
      vouchers: vouchers ?? this.vouchers,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ProjectsData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      logoUrl.hashCode ^
      skipQuestionnaire.hashCode ^
      skipConsent.hashCode ^
      skipPatientDetails.hashCode ^
      skipPatientName.hashCode ^
      skipPatientId.hashCode ^
      skipPatientCity.hashCode ^
      skipPatientCountry.hashCode ^
      disableRequestCall.hashCode ^
      disableRedeemVoucher.hashCode ^
      skipShareVoucher.hashCode ^
      skipPatientPhone.hashCode ^
      skipPatientDateOfBirth.hashCode ^
      vouchers.hashCode;
}

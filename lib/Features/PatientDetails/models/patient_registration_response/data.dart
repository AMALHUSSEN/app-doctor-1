import 'dart:convert';

import 'package:collection/collection.dart';

class PatientRegData {
  int? projectId;
  int? voucherId;
  int? resultId;
  String? projectTitle;
  String? voucherTitle;
  String? patientName;
  String? countryCode;
  String? patientPhone;
  String? patientIdNumber;
  String? patientCity;
  String? shortDescription;
  String? generationDate;
  String? expirationDate;
  String? successMessage;
  int? multipleUse;
  int? skipShareVoucher;
  int? statusCode;
  dynamic acceptedAt;
  DateTime? createdAt;
  int? id;
  String? slug;
  String? resultUrl;
  String? qrcode;

  PatientRegData({
    this.projectId,
    this.voucherId,
    this.resultId,
    this.projectTitle,
    this.voucherTitle,
    this.patientName,
    this.countryCode,
    this.patientPhone,
    this.patientIdNumber,
    this.patientCity,
    this.shortDescription,
    this.generationDate,
    this.expirationDate,
    this.successMessage,
    this.multipleUse,
    this.skipShareVoucher,
    this.statusCode,
    this.acceptedAt,
    this.createdAt,
    this.id,
    this.slug,
    this.resultUrl,
    this.qrcode,
  });

  factory PatientRegData.fromMap(Map<String, dynamic> data) => PatientRegData(
        projectId: data['project_id'] as int?,
        voucherId: data['voucher_id'] as int?,
        resultId: data['result_id'] as int?,
        projectTitle: data['project_title'] as String?,
        voucherTitle: data['voucher_title'] as String?,
        patientName: data['patient_name'] as String?,
        countryCode: data['country_code'] as String?,
        patientPhone: data['patient_phone'] as String?,
        patientIdNumber: data['patient_id_number'] as String?,
        patientCity: data['patient_city'] as String?,
        shortDescription: data['short_description'] as String?,
        generationDate: data['generation_date'] as String?,
        expirationDate: data['expiration_date'] as String?,
        successMessage: data['success_message'] as String?,
        multipleUse: data['multiple_use'] as int?,
        skipShareVoucher: data['skip_share_voucher'] as int?,
        statusCode: data['status_code'] as int?,
        acceptedAt: data['accepted_at'] as dynamic,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        id: data['id'] as int?,
        slug: data['slug'] as String?,
        resultUrl: data['result_url'] as String?,
        qrcode: data['qrcode'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'project_id': projectId,
        'voucher_id': voucherId,
        'result_id': resultId,
        'project_title': projectTitle,
        'voucher_title': voucherTitle,
        'patient_name': patientName,
        'country_code': countryCode,
        'patient_phone': patientPhone,
        'patient_id_number': patientIdNumber,
        'patient_city': patientCity,
        'short_description': shortDescription,
        'generation_date': generationDate,
        'expiration_date': expirationDate,
        'success_message': successMessage,
        'multiple_use': multipleUse,
        'skip_share_voucher': skipShareVoucher,
        'status_code': statusCode,
        'accepted_at': acceptedAt,
        'created_at': createdAt?.toIso8601String(),
        'id': id,
        'slug': slug,
        'result_url': resultUrl,
        'qrcode': qrcode,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PatientRegData].
  factory PatientRegData.fromJson(String data) {
    return PatientRegData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PatientRegData] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PatientRegData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      projectId.hashCode ^
      voucherId.hashCode ^
      resultId.hashCode ^
      projectTitle.hashCode ^
      voucherTitle.hashCode ^
      patientName.hashCode ^
      countryCode.hashCode ^
      patientPhone.hashCode ^
      patientIdNumber.hashCode ^
      patientCity.hashCode ^
      shortDescription.hashCode ^
      generationDate.hashCode ^
      expirationDate.hashCode ^
      successMessage.hashCode ^
      multipleUse.hashCode ^
      skipShareVoucher.hashCode ^
      statusCode.hashCode ^
      acceptedAt.hashCode ^
      createdAt.hashCode ^
      id.hashCode ^
      slug.hashCode ^
      resultUrl.hashCode ^
      qrcode.hashCode;
}

import 'dart:convert';

import 'package:collection/collection.dart';

class ListData {
  int? id;
  DateTime? createdAt;
  int? projectId;
  int? voucherId;
  String? projectTitle;
  String? voucherTitle;
  String? patientName;
  String? patientLastName;
  String? countryCode;
  String? patientPhone;
  String? patientIdNumber;
  String? patientCity;
  String? acceptedAt;
  dynamic country;
  int? inprogress;
  int? sampleCollection;
  int? sendOutProcess;
  int? resultsAvailable;
  int? resultsSentToDoctor;
  int? statusCode;
  dynamic scanVerifiedAt;
  int? multipleUse;
  int? resendConsent;
  int? skipPatientDetail;
  String? shortDescription;
  String? generationDate;
  String? expirationDate;
  String? successMessage;
  int? skipShareVoucher;
  String? slug;
  String? resultUrl;
  String? qrcode;
  String? voucherStatus;
  int? confirmed;
  int? activeConfirmed;
  bool? loading;
  String? notes;

  ListData({
    this.id,
    this.createdAt,
    this.projectId,
    this.voucherId,
    this.projectTitle,
    this.voucherTitle,
    this.patientName,
    this.patientLastName,
    this.countryCode,
    this.patientPhone,
    this.patientIdNumber,
    this.patientCity,
    this.acceptedAt,
    this.country,
    this.inprogress,
    this.sampleCollection,
    this.sendOutProcess,
    this.resultsAvailable,
    this.resultsSentToDoctor,
    this.statusCode,
    this.scanVerifiedAt,
    this.multipleUse,
    this.resendConsent,
    this.skipPatientDetail,
    this.shortDescription,
    this.generationDate,
    this.expirationDate,
    this.successMessage,
    this.skipShareVoucher,
    this.slug,
    this.resultUrl,
    this.qrcode,
    this.voucherStatus,
    this.confirmed,
    this.loading,
    this.activeConfirmed,
    this.notes,
  });

  @override
  String toString() {
    return 'Datum(id: $id, createdAt: $createdAt, projectId: $projectId, voucherId: $voucherId, projectTitle: $projectTitle, voucherTitle: $voucherTitle, patientName: $patientName, countryCode: $countryCode, patientPhone: $patientPhone, patientIdNumber: $patientIdNumber, patientCity: $patientCity, acceptedAt: $acceptedAt, country: $country, inprogress: $inprogress, sampleCollection: $sampleCollection, sendOutProcess: $sendOutProcess, resultsAvailable: $resultsAvailable, resultsSentToDoctor: $resultsSentToDoctor, statusCode: $statusCode, scanVerifiedAt: $scanVerifiedAt, multipleUse: $multipleUse, resendConsent: $resendConsent, skipPatientDetail: $skipPatientDetail, shortDescription: $shortDescription, generationDate: $generationDate, expirationDate: $expirationDate, successMessage: $successMessage, skipShareVoucher: $skipShareVoucher, slug: $slug, resultUrl: $resultUrl, qrcode: $qrcode, voucher_status: $voucherStatus)';
  }

  factory ListData.fromMap(Map<String, dynamic> data) => ListData(
        id: data['id'] as int?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        projectId: data['project_id'] as int?,
        voucherId: data['voucher_id'] as int?,
        projectTitle: data['project_title'] as String?,
        voucherTitle: data['voucher_title'] as String?,
        patientName: data['patient_name']  as String?,
        patientLastName: data['patient_last_name']  as String?,
        countryCode: data['country_code'] as String?,
        patientPhone: data['patient_phone'] as String?,
        patientIdNumber: data['patient_id_number'] as String?,
        patientCity: data['patient_city'] as String?,
        acceptedAt: data['accepted_at'] as String?,
        country: data['country'] as dynamic,
        inprogress: data['inprogress'] as int?,
        sampleCollection: data['sample_collection'] as int?,
        sendOutProcess: data['send_out_process'] as int?,
        resultsAvailable: data['results_available'] as int?,
        resultsSentToDoctor: data['results_sent_to_doctor'] as int?,
        statusCode: data['status_code'] as int?,
        scanVerifiedAt: data['scan_verified_at'] as dynamic,
        multipleUse: data['multiple_use'] as int?,
        resendConsent: data['resend_consent'] as int?,
        skipPatientDetail: data['skip_patient_detail'] as int?,
        shortDescription: data['short_description'] as String?,
        generationDate: data['generation_date'] as String?,
        expirationDate: data['expiration_date'] as String?,
        successMessage: data['success_message'] as String?,
        skipShareVoucher: data['skip_share_voucher'] as int?,
        slug: data['slug'] as String?,
        resultUrl: data['result_url'] as String?,
        qrcode: data['qrcode'] as String?,
        voucherStatus: data['voucher_status'] as String?,
        confirmed: data['confirmed'] as int?,
        activeConfirmed: data['active_confirmed'] as int?,
        notes: data['notes'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'project_id': projectId,
        'voucher_id': voucherId,
        'project_title': projectTitle,
        'voucher_title': voucherTitle,
        'patient_name': patientName,
        'patient_last_name': patientLastName,
        'country_code': countryCode,
        'patient_phone': patientPhone,
        'patient_id_number': patientIdNumber,
        'patient_city': patientCity,
        'accepted_at': acceptedAt,
        'country': country,
        'inprogress': inprogress,
        'sample_collection': sampleCollection,
        'send_out_process': sendOutProcess,
        'results_available': resultsAvailable,
        'results_sent_to_doctor': resultsSentToDoctor,
        'status_code': statusCode,
        'scan_verified_at': scanVerifiedAt,
        'multiple_use': multipleUse,
        'resend_consent': resendConsent,
        'skip_patient_detail': skipPatientDetail,
        'short_description': shortDescription,
        'generation_date': generationDate,
        'expiration_date': expirationDate,
        'success_message': successMessage,
        'skip_share_voucher': skipShareVoucher,
        'slug': slug,
        'result_url': resultUrl,
        'qrcode': qrcode,
        'voucher_status': voucherStatus,
        'confirmed': confirmed,
        'active_confirmed': activeConfirmed,
        'loading': loading,
        'notes': notes,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ListData].
  factory ListData.fromJson(String data) {
    return ListData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ListData] to a JSON string.
  String toJson() => json.encode(toMap());

  ListData copyWith({
    int? id,
    DateTime? createdAt,
    int? projectId,
    int? voucherId,
    String? projectTitle,
    String? voucherTitle,
    String? patientName,
    String? patientLastName,
    String? countryCode,
    String? patientPhone,
    String? patientIdNumber,
    String? patientCity,
    String? acceptedAt,
    dynamic country,
    int? inprogress,
    int? sampleCollection,
    int? sendOutProcess,
    int? resultsAvailable,
    int? resultsSentToDoctor,
    int? statusCode,
    dynamic scanVerifiedAt,
    int? multipleUse,
    int? resendConsent,
    int? skipPatientDetail,
    String? shortDescription,
    String? generationDate,
    String? expirationDate,
    String? successMessage,
    int? skipShareVoucher,
    String? slug,
    String? resultUrl,
    String? qrcode,
    String? voucherStatus,
    int? confirmed,
    int? activeConfirmed,
    bool? loading,
    String? notes,
  }) {
    return ListData(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      projectId: projectId ?? this.projectId,
      voucherId: voucherId ?? this.voucherId,
      projectTitle: projectTitle ?? this.projectTitle,
      voucherTitle: voucherTitle ?? this.voucherTitle,
      patientName: patientName ?? this.patientName,
      patientLastName: patientLastName ?? this.patientLastName,
      countryCode: countryCode ?? this.countryCode,
      patientPhone: patientPhone ?? this.patientPhone,
      patientIdNumber: patientIdNumber ?? this.patientIdNumber,
      patientCity: patientCity ?? this.patientCity,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      country: country ?? this.country,
      inprogress: inprogress ?? this.inprogress,
      sampleCollection: sampleCollection ?? this.sampleCollection,
      sendOutProcess: sendOutProcess ?? this.sendOutProcess,
      resultsAvailable: resultsAvailable ?? this.resultsAvailable,
      resultsSentToDoctor: resultsSentToDoctor ?? this.resultsSentToDoctor,
      statusCode: statusCode ?? this.statusCode,
      scanVerifiedAt: scanVerifiedAt ?? this.scanVerifiedAt,
      multipleUse: multipleUse ?? this.multipleUse,
      resendConsent: resendConsent ?? this.resendConsent,
      skipPatientDetail: skipPatientDetail ?? this.skipPatientDetail,
      shortDescription: shortDescription ?? this.shortDescription,
      generationDate: generationDate ?? this.generationDate,
      expirationDate: expirationDate ?? this.expirationDate,
      successMessage: successMessage ?? this.successMessage,
      skipShareVoucher: skipShareVoucher ?? this.skipShareVoucher,
      slug: slug ?? this.slug,
      resultUrl: resultUrl ?? this.resultUrl,
      qrcode: qrcode ?? this.qrcode,
      voucherStatus: voucherStatus ?? this.voucherStatus,
      confirmed: confirmed ?? this.confirmed,
      activeConfirmed: activeConfirmed ?? this.activeConfirmed,
      loading: loading ?? this.loading,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ListData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      projectId.hashCode ^
      voucherId.hashCode ^
      projectTitle.hashCode ^
      voucherTitle.hashCode ^
      patientName.hashCode ^
      patientLastName.hashCode ^
      countryCode.hashCode ^
      patientPhone.hashCode ^
      patientIdNumber.hashCode ^
      patientCity.hashCode ^
      acceptedAt.hashCode ^
      country.hashCode ^
      inprogress.hashCode ^
      sampleCollection.hashCode ^
      sendOutProcess.hashCode ^
      resultsAvailable.hashCode ^
      resultsSentToDoctor.hashCode ^
      statusCode.hashCode ^
      scanVerifiedAt.hashCode ^
      multipleUse.hashCode ^
      resendConsent.hashCode ^
      skipPatientDetail.hashCode ^
      shortDescription.hashCode ^
      generationDate.hashCode ^
      expirationDate.hashCode ^
      successMessage.hashCode ^
      skipShareVoucher.hashCode ^
      activeConfirmed.hashCode ^
      slug.hashCode ^
      resultUrl.hashCode ^
      qrcode.hashCode ^
      confirmed.hashCode ^
      notes.hashCode ^
      voucherStatus.hashCode;
}

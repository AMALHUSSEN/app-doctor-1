import 'dart:convert';

import 'package:collection/collection.dart';

class LicenseData {
  int? projectId;
  String? projectName;
  String? licenseKey;
  String? planName;
  String? status;
  String? startsAt;
  String? endsAt;
  int? daysRemaining;
  bool? isActive;
  bool? autoRenew;
  int? maxPatients;
  int? maxDoctors;
  int? maxVoucherServices;
  int? currentPatients;
  int? currentDoctors;
  int? currentVouchers;

  LicenseData({
    this.projectId,
    this.projectName,
    this.licenseKey,
    this.planName,
    this.status,
    this.startsAt,
    this.endsAt,
    this.daysRemaining,
    this.isActive,
    this.autoRenew,
    this.maxPatients,
    this.maxDoctors,
    this.maxVoucherServices,
    this.currentPatients,
    this.currentDoctors,
    this.currentVouchers,
  });

  @override
  String toString() {
    return 'LicenseData(projectId: $projectId, projectName: $projectName, licenseKey: $licenseKey, planName: $planName, status: $status, startsAt: $startsAt, endsAt: $endsAt, daysRemaining: $daysRemaining, isActive: $isActive, autoRenew: $autoRenew, maxPatients: $maxPatients, maxDoctors: $maxDoctors, maxVoucherServices: $maxVoucherServices, currentPatients: $currentPatients, currentDoctors: $currentDoctors, currentVouchers: $currentVouchers)';
  }

  factory LicenseData.fromMap(Map<String, dynamic> data) => LicenseData(
        projectId: data['project_id'] as int?,
        projectName: data['project_name'] as String?,
        licenseKey: data['license_key'] as String?,
        planName: data['plan_name'] as String?,
        status: data['status'] as String?,
        startsAt: data['starts_at'] as String?,
        endsAt: data['ends_at'] as String?,
        daysRemaining: data['days_remaining'] as int?,
        isActive: data['is_active'] as bool?,
        autoRenew: data['auto_renew'] as bool?,
        maxPatients: data['max_patients'] as int?,
        maxDoctors: data['max_doctors'] as int?,
        maxVoucherServices: data['max_voucher_services'] as int?,
        currentPatients: data['current_patients'] as int?,
        currentDoctors: data['current_doctors'] as int?,
        currentVouchers: data['current_vouchers'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'project_id': projectId,
        'project_name': projectName,
        'license_key': licenseKey,
        'plan_name': planName,
        'status': status,
        'starts_at': startsAt,
        'ends_at': endsAt,
        'days_remaining': daysRemaining,
        'is_active': isActive,
        'auto_renew': autoRenew,
        'max_patients': maxPatients,
        'max_doctors': maxDoctors,
        'max_voucher_services': maxVoucherServices,
        'current_patients': currentPatients,
        'current_doctors': currentDoctors,
        'current_vouchers': currentVouchers,
      };

  factory LicenseData.fromJson(String data) {
    return LicenseData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  LicenseData copyWith({
    int? projectId,
    String? projectName,
    String? licenseKey,
    String? planName,
    String? status,
    String? startsAt,
    String? endsAt,
    int? daysRemaining,
    bool? isActive,
    bool? autoRenew,
    int? maxPatients,
    int? maxDoctors,
    int? maxVoucherServices,
    int? currentPatients,
    int? currentDoctors,
    int? currentVouchers,
  }) {
    return LicenseData(
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      licenseKey: licenseKey ?? this.licenseKey,
      planName: planName ?? this.planName,
      status: status ?? this.status,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      daysRemaining: daysRemaining ?? this.daysRemaining,
      isActive: isActive ?? this.isActive,
      autoRenew: autoRenew ?? this.autoRenew,
      maxPatients: maxPatients ?? this.maxPatients,
      maxDoctors: maxDoctors ?? this.maxDoctors,
      maxVoucherServices: maxVoucherServices ?? this.maxVoucherServices,
      currentPatients: currentPatients ?? this.currentPatients,
      currentDoctors: currentDoctors ?? this.currentDoctors,
      currentVouchers: currentVouchers ?? this.currentVouchers,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LicenseData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      projectId.hashCode ^
      projectName.hashCode ^
      licenseKey.hashCode ^
      planName.hashCode ^
      status.hashCode ^
      startsAt.hashCode ^
      endsAt.hashCode ^
      daysRemaining.hashCode ^
      isActive.hashCode ^
      autoRenew.hashCode ^
      maxPatients.hashCode ^
      maxDoctors.hashCode ^
      maxVoucherServices.hashCode ^
      currentPatients.hashCode ^
      currentDoctors.hashCode ^
      currentVouchers.hashCode;
}

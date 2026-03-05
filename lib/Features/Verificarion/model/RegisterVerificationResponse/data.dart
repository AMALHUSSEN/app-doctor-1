import 'dart:convert';

import 'package:collection/collection.dart';

class RegisterVerificationData {
  int? id;
  String? name;
  String? lastName;
  String? email;
  String? phone;
  String? hospital;
  String? speciality;
  dynamic country;
  String? city;
  dynamic verificationCode;
  String? profilePhoto;
  String? countryCode;
  String? projectCode;
  int? pivotId;

  RegisterVerificationData({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.phone,
    this.hospital,
    this.speciality,
    this.country,
    this.city,
    this.verificationCode,
    this.profilePhoto,
    this.countryCode,
    this.projectCode,
    this.pivotId,
  });

  @override
  String toString() {
    return 'Data(id: $id, name: $name, lastName: $lastName, email: $email, phone: $phone, hospital: $hospital, speciality: $speciality, country: $country, city: $city, verificationCode: $verificationCode, profilePhoto: $profilePhoto, countryCode: $countryCode, projectCode: $projectCode, pivotId: $pivotId)';
  }

  factory RegisterVerificationData.fromMap(Map<String, dynamic> data) =>
      RegisterVerificationData(
        id: data['id'] as int?,
        name: data['name'] as String?,
        lastName: data['last_name'] as String?,
        email: data['email'] as String?,
        phone: data['phone'] as String?,
        hospital: data['hospital'] as String?,
        speciality: data['speciality'] as String?,
        country: data['country'] as dynamic,
        city: data['city'] as String?,
        verificationCode: data['verification_code'] as dynamic,
        profilePhoto: data['profile_photo'] as String?,
        countryCode: data['country_code'] as String?,
        projectCode: data['project_code'] as String?,
        pivotId: data['pivot_id'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'hospital': hospital,
        'speciality': speciality,
        'country': country,
        'city': city,
        'verification_code': verificationCode,
        'profile_photo': profilePhoto,
        'country_code': countryCode,
        'project_code': projectCode,
        'pivot_id': pivotId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RegisterVerificationData].
  factory RegisterVerificationData.fromJson(String data) {
    return RegisterVerificationData.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RegisterVerificationData] to a JSON string.
  String toJson() => json.encode(toMap());

  RegisterVerificationData copyWith({
    int? id,
    String? name,
    String? lastName,
    String? email,
    String? phone,
    String? hospital,
    String? speciality,
    dynamic country,
    String? city,
    dynamic verificationCode,
    String? profilePhoto,
    String? countryCode,
    String? projectCode,
    int? pivotId,
  }) {
    return RegisterVerificationData(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      hospital: hospital ?? this.hospital,
      speciality: speciality ?? this.speciality,
      country: country ?? this.country,
      city: city ?? this.city,
      verificationCode: verificationCode ?? this.verificationCode,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      countryCode: countryCode ?? this.countryCode,
      projectCode: projectCode ?? this.projectCode,
      pivotId: pivotId ?? this.pivotId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RegisterVerificationData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      hospital.hashCode ^
      speciality.hashCode ^
      country.hashCode ^
      city.hashCode ^
      verificationCode.hashCode ^
      profilePhoto.hashCode ^
      countryCode.hashCode ^
      projectCode.hashCode ^
      pivotId.hashCode;
}

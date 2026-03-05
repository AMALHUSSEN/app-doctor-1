import 'dart:convert';

import 'package:collection/collection.dart';

class RegisterData {
  int? id;
  String? name;
  String? lastName;
  String? email;
  String? phone;
  String? hospital;
  String? speciality;
  String? projectCode;
  dynamic country;
  String? city;
  int? verificationCode;
  String? profilePhoto;
  String? countryCode;

  RegisterData({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.phone,
    this.hospital,
    this.speciality,
    this.projectCode,
    this.country,
    this.city,
    this.verificationCode,
    this.profilePhoto,
    this.countryCode,
  });

  @override
  String toString() {
    return 'Data(id: $id, name: $name, lastName: $lastName, email: $email, phone: $phone, hospital: $hospital, speciality: $speciality, projectCode: $projectCode, country: $country, city: $city, verificationCode: $verificationCode, profilePhoto: $profilePhoto, countryCode: $countryCode)';
  }

  factory RegisterData.fromMap(Map<String, dynamic> data) => RegisterData(
        id: data['id'] as int?,
        name: data['name'] as String?,
        lastName: data['last_name'] as String?,
        email: data['email'] as String?,
        phone: data['phone'] as String?,
        hospital: data['hospital'] as String?,
        speciality: data['speciality'] as String?,
        projectCode: data['project_code'] as String?,
        country: data['country'] as dynamic,
        city: data['city'] as String?,
        verificationCode: data['verification_code'] as int?,
        profilePhoto: data['profile_photo'] as String?,
        countryCode: data['country_code'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'hospital': hospital,
        'speciality': speciality,
        'project_code': projectCode,
        'country': country,
        'city': city,
        'verification_code': verificationCode,
        'profile_photo': profilePhoto,
        'country_code': countryCode,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RegisterData].
  factory RegisterData.fromJson(String data) {
    return RegisterData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RegisterData] to a JSON string.
  String toJson() => json.encode(toMap());

  RegisterData copyWith({
    int? id,
    String? name,
    String? lastName,
    String? email,
    String? phone,
    String? hospital,
    String? speciality,
    String? projectCode,
    dynamic country,
    String? city,
    int? verificationCode,
    String? profilePhoto,
    String? countryCode,
  }) {
    return RegisterData(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      hospital: hospital ?? this.hospital,
      speciality: speciality ?? this.speciality,
      projectCode: projectCode ?? this.projectCode,
      country: country ?? this.country,
      city: city ?? this.city,
      verificationCode: verificationCode ?? this.verificationCode,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RegisterData) return false;
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
      projectCode.hashCode ^
      country.hashCode ^
      city.hashCode ^
      verificationCode.hashCode ^
      profilePhoto.hashCode ^
      countryCode.hashCode;
}

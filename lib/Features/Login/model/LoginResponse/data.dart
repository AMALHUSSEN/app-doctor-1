import 'dart:convert';

import 'package:collection/collection.dart';

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? profilePhoto;
  String? lastName;
  String? hospitalName;
  String? speciality;
  String? country;
  String? city;
  String? countryCode;
  String? verificationCode;
  int? status;

  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profilePhoto,
    this.lastName,
    this.hospitalName,
    this.speciality,
    this.country,
    this.city,
    this.countryCode,
    this.verificationCode,
    this.status,
  });

  @override
  String toString() {
    return 'Data(id: $id, name: $name, email: $email, phone: $phone, profilePhoto: $profilePhoto, last_name: $lastName, hospital: $hospitalName, speciality: $speciality, country: $country, city: $city, country_code: $countryCode, verification_code: $verificationCode)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
      id: data['id'] as int?,
      name: data['name'] as String?,
      email: data['email'] as String?,
      phone: data['phone'] as String?,
      profilePhoto: data['profile_photo'] as String?,
      lastName: data['last_name'] as String?,
      hospitalName: data['hospital'] as String?,
      speciality: data['speciality'] as String?,
      country: data['country'] as String?,
      city: data['city'] as String?,
      countryCode: data['country_code'] as String?,
      status: data['status'] as int?,
      verificationCode: data['verification_code'] as String?);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'profile_photo': profilePhoto,
        'last_name': lastName,
        'hospital': hospitalName,
        'speciality': speciality,
        'country': country,
        'city': city,
        'country_code': countryCode,
        'verification_code': verificationCode,
        'status': status,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? profilePhoto,
    String? lastName,
    String? hospitalName,
    String? speciality,
    String? country,
    String? city,
    String? countryCode,
    String? verificationCode,
    int? status,
  }) {
    return Data(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      speciality: speciality ?? this.speciality,
      lastName: lastName ?? this.lastName,
      hospitalName: hospitalName ?? this.hospitalName,
      country: country ?? this.country,
      city: city ?? this.city,
      countryCode: countryCode ?? this.countryCode,
      verificationCode: verificationCode ?? this.verificationCode,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      profilePhoto.hashCode ^
      speciality.hashCode ^
      lastName.hashCode ^
      hospitalName.hashCode ^
      country.hashCode ^
      city.hashCode ^
      countryCode.hashCode ^
      verificationCode.hashCode ^
      status.hashCode;
}

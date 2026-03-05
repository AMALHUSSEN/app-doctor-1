class NewConsentResponse {
  int? success;
  Result? result;
  String? message;

  NewConsentResponse({this.success, this.result, this.message});

  NewConsentResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Result {
  Data? data;

  Result({this.data});

  Result.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? projectId;
  int? confirmed;
  int? voucherId;
  Null? resultId;
  String? projectTitle;
  String? voucherTitle;
  String? patientName;
  String? countryCode;
  String? patientPhone;
  String? patientIdNumber;
  String? patientDateOfBirth;
  String? patientCity;
  String? shortDescription;
  String? generationDate;
  String? expirationDate;
  String? successMessage;
  int? multipleUse;
  int? skipShareVoucher;
  int? statusCode;
  Null? acceptedAt;
  String? createdAt;
  String? slug;
  String? resultUrl;
  String? qrcode;

  Data(
      {this.id,
        this.projectId,
        this.confirmed,
        this.voucherId,
        this.resultId,
        this.projectTitle,
        this.voucherTitle,
        this.patientName,
        this.countryCode,
        this.patientPhone,
        this.patientIdNumber,
        this.patientDateOfBirth,
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
        this.slug,
        this.resultUrl,
        this.qrcode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    confirmed = json['confirmed'];
    voucherId = json['voucher_id'];
    resultId = json['result_id'];
    projectTitle = json['project_title'];
    voucherTitle = json['voucher_title'];
    patientName = json['patient_name'];
    countryCode = json['country_code'];
    patientPhone = json['patient_phone'];
    patientIdNumber = json['patient_id_number'];
    patientDateOfBirth = json['patient_date_of_birth'];
    patientCity = json['patient_city'];
    shortDescription = json['short_description'];
    generationDate = json['generation_date'];
    expirationDate = json['expiration_date'];
    successMessage = json['success_message'];
    multipleUse = json['multiple_use'];
    skipShareVoucher = json['skip_share_voucher'];
    statusCode = json['status_code'];
    acceptedAt = json['accepted_at'];
    createdAt = json['created_at'];
    slug = json['slug'];
    resultUrl = json['result_url'];
    qrcode = json['qrcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_id'] = this.projectId;
    data['confirmed'] = this.confirmed;
    data['voucher_id'] = this.voucherId;
    data['result_id'] = this.resultId;
    data['project_title'] = this.projectTitle;
    data['voucher_title'] = this.voucherTitle;
    data['patient_name'] = this.patientName;
    data['country_code'] = this.countryCode;
    data['patient_phone'] = this.patientPhone;
    data['patient_id_number'] = this.patientIdNumber;
    data['patient_date_of_birth'] = this.patientDateOfBirth;
    data['patient_city'] = this.patientCity;
    data['short_description'] = this.shortDescription;
    data['generation_date'] = this.generationDate;
    data['expiration_date'] = this.expirationDate;
    data['success_message'] = this.successMessage;
    data['multiple_use'] = this.multipleUse;
    data['skip_share_voucher'] = this.skipShareVoucher;
    data['status_code'] = this.statusCode;
    data['accepted_at'] = this.acceptedAt;
    data['created_at'] = this.createdAt;
    data['slug'] = this.slug;
    data['result_url'] = this.resultUrl;
    data['qrcode'] = this.qrcode;
    return data;
  }
}
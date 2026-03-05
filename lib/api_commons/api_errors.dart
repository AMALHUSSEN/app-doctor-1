import 'dart:convert';

UserError userErrorFromJson(String str) => UserError.fromJson(json.decode(str));

String userErrorToJson(UserError data) => json.encode(data.toJson());

class UserError {
  UserError({
    this.success,
    this.message,
  });

  int? success;
  String? message;

  factory UserError.fromJson(Map<String, dynamic> json) => UserError(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}

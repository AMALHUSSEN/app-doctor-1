import 'dart:convert';

import 'package:collection/collection.dart';

class CheckVoucherResponse {
  int? success;
  String? message;

  CheckVoucherResponse({this.success, this.message});

  @override
  String toString() {
    return 'CheckVoucherResponse(success: $success, message: $message)';
  }

  factory CheckVoucherResponse.fromMap(Map<String, dynamic> data) {
    return CheckVoucherResponse(
      success: data['success'] as int?,
      message: data['message'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'success': success,
        'message': message,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CheckVoucherResponse].
  factory CheckVoucherResponse.fromJson(String data) {
    return CheckVoucherResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CheckVoucherResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  CheckVoucherResponse copyWith({
    int? success,
    String? message,
  }) {
    return CheckVoucherResponse(
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CheckVoucherResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode;
}

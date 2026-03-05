import 'dart:convert';

import 'package:collection/collection.dart';

class Data {
  bool? disableRedeemVoucher;
  bool? disableRequestCall;

  Data({this.disableRedeemVoucher, this.disableRequestCall});

  @override
  String toString() {
    return 'Data(disableRedeemVoucher: $disableRedeemVoucher, disableRequestCall: $disableRequestCall)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        disableRedeemVoucher: data['disable_redeem_voucher'] as bool?,
        disableRequestCall: data['disable_request_call'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'disable_redeem_voucher': disableRedeemVoucher,
        'disable_request_call': disableRequestCall,
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
    bool? disableRedeemVoucher,
    bool? disableRequestCall,
  }) {
    return Data(
      disableRedeemVoucher: disableRedeemVoucher ?? this.disableRedeemVoucher,
      disableRequestCall: disableRequestCall ?? this.disableRequestCall,
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
      disableRedeemVoucher.hashCode ^ disableRequestCall.hashCode;
}

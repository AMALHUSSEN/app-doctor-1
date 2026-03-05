import 'dart:convert';

import 'package:collection/collection.dart';

class Data {
  int? resultId;

  Data({this.resultId});

  @override
  String toString() => 'Data(resultId: $resultId)';

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        resultId: data['result_id'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'result_id': resultId,
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
    int? resultId,
  }) {
    return Data(
      resultId: resultId ?? this.resultId,
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
  int get hashCode => resultId.hashCode;
}

import 'dart:convert';

import 'package:collection/collection.dart';

class Option {
  int? id;
  String? option;
  bool? answer;

  Option({
    this.id,
    this.option,
    this.answer,
  });

  @override
  String toString() => 'Option(id: $id, option: $option)';

  factory Option.fromMap(Map<String, dynamic> data) => Option(
        id: data['id'] as int?,
        option: data['option'] as String?,
        answer: data['answer'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'option': option,
        'answer': answer,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Option].
  factory Option.fromJson(String data) {
    return Option.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Option] to a JSON string.
  String toJson() => json.encode(toMap());

  Option copyWith({
    int? id,
    String? option,
    bool? answer,
  }) {
    return Option(
        id: id ?? this.id,
        option: option ?? this.option,
        answer: answer ?? this.answer);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Option) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => id.hashCode ^ option.hashCode ^ answer.hashCode;
}

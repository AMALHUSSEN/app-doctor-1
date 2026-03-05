class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('Data.fromJson($json) is not implemented');
  }

  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  static fromMap(Map<String, dynamic> data) {}

  toMap() {}
}

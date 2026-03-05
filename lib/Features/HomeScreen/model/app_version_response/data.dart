class AppVersionData {
  int? id;
  String? version;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  AppVersionData({this.id, this.version, this.createdAt, this.updatedAt, this.deletedAt});

  AppVersionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['version'] = this.version;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
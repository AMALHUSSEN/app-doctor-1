class BlockProjectData {
  int? id;
  String? title;
  String? description;
  String? linkWebSite;
  String? nameWebSite;
  String? logoUrl;

  BlockProjectData(
      {this.id,
        this.title,
        this.description,
        this.linkWebSite,
        this.nameWebSite,
        this.logoUrl});

  BlockProjectData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    linkWebSite = json['link_web_site'];
    nameWebSite = json['name_web_site'];
    logoUrl = json['logo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['link_web_site'] = this.linkWebSite;
    data['name_web_site'] = this.nameWebSite;
    data['logo_url'] = this.logoUrl;
    return data;
  }
}
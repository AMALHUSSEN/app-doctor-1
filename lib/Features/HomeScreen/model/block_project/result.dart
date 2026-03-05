import 'package:smarthealth_hcp/Features/HomeScreen/model/block_project/data.dart';

class BlockProjectResult {
  List<BlockProjectData>? data;

  BlockProjectResult({this.data});

  BlockProjectResult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BlockProjectData>[];
      json['data'].forEach((v) {
        data!.add(BlockProjectData.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
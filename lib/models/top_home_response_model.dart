class TopHomeResponseModel {
  int? status;
  dynamic error;
  List<TopHomeData> data = [];

  TopHomeResponseModel({this.status, this.error, required this.data});

  TopHomeResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 404;
    error = json['error'] ?? "";
    if (json['data'] != null) {
      data = <TopHomeData>[];
      json['data'].forEach((v) {
        data!.add(TopHomeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopHomeData {
  String? source;
  String? heading;
  List<Res>? res;

  TopHomeData({this.source, this.heading, this.res});

  TopHomeData.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    heading = json['heading'];
    if (json['res'] != null) {
      res = <Res>[];
      json['res'].forEach((v) {
        res!.add(new Res.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    data['heading'] = this.heading;
    if (this.res != null) {
      data['res'] = this.res!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Res {
  String? id;
  String? name;
  String? slug;
  String? icon;
  String? link;

  Res({this.id, this.name, this.slug, this.icon, this.link});

  Res.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['icon'] = this.icon;
    data['link'] = this.link;
    return data;
  }
}

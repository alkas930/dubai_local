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
  String? title;
  String? slug;
  String? icon;
  String? image;
  String? full_banner;
  String? average_rating;
  String? link;
  String? url;

  Res(
      {this.id,
      this.name,
      this.title,
      this.slug,
      this.icon,
      this.image,
      this.full_banner,
      this.average_rating,
      this.link,
      this.url});

  Res.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    slug = json['slug'];
    icon = json['icon'];
    image = json['image'];
    full_banner = json['full_banner'];
    average_rating = json['average_rating'];
    link = json['link'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['icon'] = this.icon;
    data['image'] = this.image;
    data['full_banner'] = this.full_banner;
    data['average_rating'] = this.average_rating;
    data['link'] = this.link;
    data['url'] = this.url;
    return data;
  }
}

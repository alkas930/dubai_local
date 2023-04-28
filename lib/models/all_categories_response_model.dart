class AllCategoriesResponseModel {
  int? status;
  dynamic error;
  List<AllCategoriesData> data = [];

  AllCategoriesResponseModel({this.status, this.error, required this.data});

  AllCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 404;
    error = json['error'] ?? "";
    if (json['data'] != null) {
      data = <AllCategoriesData>[];
      json['data'].forEach((v) {
        data!.add(AllCategoriesData.fromJson(v));
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

class AllCategoriesData {
  String id = "";
  String name = "";
  String slug = "";
  String banner = "";
  String fullBanner = "";
  String icon = "";
  String fullIcon = "";
  String priority = "";
  String status = "";
  String createdAt = "";
  String modifiedAt = "";

  AllCategoriesData(
      {required this.id,
      required this.name,
      required this.slug,
      required this.banner,
      required this.fullBanner,
      required this.icon,
      required this.fullIcon,
      required this.priority,
      required this.status,
      required this.createdAt,
      required this.modifiedAt});

  AllCategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id']??"" ;
    name = json['name']??"";
    slug = json['slug']??"";
    banner = json['banner']??"";
    fullBanner = json['full_banner']??"";
    icon = json['icon']??"";
    fullIcon = json['full_icon']??"";
    priority = json['priority']??"";
    status = json['status']??"";
    createdAt = json['created_at']??"";
    modifiedAt = json['modified_at']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['banner'] = banner;
    data['full_banner'] = fullBanner;
    data['icon'] = icon;
    data['full_icon'] = fullIcon;
    data['priority'] = priority;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    return data;
  }
}

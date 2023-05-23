class SearchModel {
  int? status;
  dynamic? error;
  List<SearchModelData>? data;

  SearchModel({this.status, this.error, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    if (json['data'] != null) {
      data = <SearchModelData>[];
      json['data'].forEach((v) {
        data!.add(new SearchModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchModelData {
  String? id;
  String? name;
  String? keyword;
  String? slug;
  String? isClaimed;
  String? isVerified;
  String? avgRating;
  String? address;
  String? phone;
  String? banner;
  String? aeverageRating;
  String? countRating;
  String? districtName;
  String? catId;
  String? subcat_slug;
  String? keyword_source;

  SearchModelData(
      {this.id,
      this.name,
      this.keyword,
      this.slug,
      this.isClaimed,
      this.isVerified,
      this.avgRating,
      this.address,
      this.phone,
      this.banner,
      this.aeverageRating,
      this.countRating,
      this.districtName,
      this.catId,
      this.subcat_slug,
      this.keyword_source});

  SearchModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    keyword = json['keyword'];
    slug = json['slug'];
    isClaimed = json['is_claimed'];
    isVerified = json['is_verified'];
    avgRating = json['avg_rating'];
    address = json['address'];
    phone = json['phone'];
    banner = json['banner'];
    aeverageRating = json['aeverage_rating'];
    countRating = json['count_rating'];
    districtName = json['district_name'];
    catId = json['cat_id'];
    subcat_slug = json['subcat_slug'];
    keyword_source = json['keyword_source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['keyword'] = this.keyword;
    data['slug'] = this.slug;
    data['is_claimed'] = this.isClaimed;
    data['is_verified'] = this.isVerified;
    data['avg_rating'] = this.avgRating;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['banner'] = this.banner;
    data['aeverage_rating'] = this.aeverageRating;
    data['count_rating'] = this.countRating;
    data['district_name'] = this.districtName;
    data['cat_id'] = this.catId;
    data['subcat_slug'] = this.subcat_slug;
    data['keyword_source'] = this.keyword_source;
    return data;
  }
}

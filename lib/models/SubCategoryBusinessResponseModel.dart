class SubCategoryBusinessResponseModel {
  List<SubcatBusinessData>? subcatBusinessData;
  List<CatName>? catName;
  String? metaTitle;
  String? title;
  String? metaDesc;
  AppData? appData;

  SubCategoryBusinessResponseModel(
      {this.subcatBusinessData,
        this.catName,
        this.metaTitle,
        this.title,
        this.metaDesc,
        this.appData});

  SubCategoryBusinessResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['subcat_business_data'] != null) {
      subcatBusinessData = <SubcatBusinessData>[];
      json['subcat_business_data'].forEach((v) {
        subcatBusinessData!.add(SubcatBusinessData.fromJson(v));
      });
    }
    if (json['cat_name'] != null) {
      catName = <CatName>[];
      json['cat_name'].forEach((v) {
        catName!.add(CatName.fromJson(v));
      });
    }
    metaTitle = json['meta_title'];
    title = json['title'];
    metaDesc = json['meta_desc'];
    appData = json['app_data'] != null
        ? AppData.fromJson(json['app_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subcatBusinessData != null) {
      data['subcat_business_data'] =
          subcatBusinessData!.map((v) => v.toJson()).toList();
    }
    if (catName != null) {
      data['cat_name'] = catName!.map((v) => v.toJson()).toList();
    }
    data['meta_title'] = metaTitle;
    data['title'] = title;
    data['meta_desc'] = metaDesc;
    if (appData != null) {
      data['app_data'] = appData!.toJson();
    }
    return data;
  }
}

class SubcatBusinessData {
  String? id;
  String? name;
  String? address;
  String? slug;
  String? email;
  String? phone;
  String? banner;
  Null? aeverageRating;
  String? avgRating;
  String? categoryId;
  String? countRating;

  SubcatBusinessData(
      {this.id,
        this.name,
        this.address,
        this.slug,
        this.email,
        this.phone,
        this.banner,
        this.aeverageRating,
        this.avgRating,
        this.categoryId,
        this.countRating});

  SubcatBusinessData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    slug = json['slug'];
    email = json['email'];
    phone = json['phone'];
    banner = json['banner'];
    aeverageRating = json['aeverage_rating'];
    avgRating = json['avg_rating'];
    categoryId = json['category_id'];
    countRating = json['count_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['slug'] = slug;
    data['email'] = email;
    data['phone'] = phone;
    data['banner'] = banner;
    data['aeverage_rating'] = aeverageRating;
    data['avg_rating'] = avgRating;
    data['category_id'] = categoryId;
    data['count_rating'] = countRating;
    return data;
  }
}

class CatName {
  String? subcatName;
  String? name;
  String? catSlug;

  CatName({this.subcatName, this.name, this.catSlug});

  CatName.fromJson(Map<String, dynamic> json) {
    subcatName = json['subcat_name'];
    name = json['name'];
    catSlug = json['cat_slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subcat_name'] = subcatName;
    data['name'] = name;
    data['cat_slug'] = catSlug;
    return data;
  }
}

class AppData {
  String? id;
  String? email;
  String? phoneNo;
  String? facebookUrl;
  String? youtubeUrl;
  String? linkedinUrl;
  String? twitterUrl;
  String? instagramUrl;
  String? address;
  String? captchaKey;
  String? logoPath;
  String? modifiedAt;

  AppData(
      {this.id,
        this.email,
        this.phoneNo,
        this.facebookUrl,
        this.youtubeUrl,
        this.linkedinUrl,
        this.twitterUrl,
        this.instagramUrl,
        this.address,
        this.captchaKey,
        this.logoPath,
        this.modifiedAt});

  AppData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phoneNo = json['phone_no'];
    facebookUrl = json['facebook_url'];
    youtubeUrl = json['youtube_url'];
    linkedinUrl = json['linkedin_url'];
    twitterUrl = json['twitter_url'];
    instagramUrl = json['instagram_url'];
    address = json['address'];
    captchaKey = json['captcha_key'];
    logoPath = json['logo_path'];
    modifiedAt = json['modified_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['phone_no'] = phoneNo;
    data['facebook_url'] = facebookUrl;
    data['youtube_url'] = youtubeUrl;
    data['linkedin_url'] = linkedinUrl;
    data['twitter_url'] = twitterUrl;
    data['instagram_url'] = instagramUrl;
    data['address'] = address;
    data['captcha_key'] = captchaKey;
    data['logo_path'] = logoPath;
    data['modified_at'] = modifiedAt;
    return data;
  }
}

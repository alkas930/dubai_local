class SubCategoryResponseModel {
  List<Category>? category;
  List<SubcatData> subCatData=[];
  String? metaTitle;
  String? title;
  String? metaDesc;
  AppData? appData;

  SubCategoryResponseModel(
      {this.category,
        required this.subCatData,
        this.metaTitle,
        this.title,
        this.metaDesc,
        this.appData});

  SubCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
    if (json['subcat_data'] != null) {
      subCatData = <SubcatData>[];
      json['subcat_data'].forEach((v) {
        subCatData!.add(SubcatData.fromJson(v));
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
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    if (subCatData != null) {
      data['subcat_data'] = subCatData!.map((v) => v.toJson()).toList();
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

class Category {
  String? id;
  String? name;
  String? slug;

  Category({this.id, this.name, this.slug});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    return data;
  }
}

class SubcatData {
  String? subCatId;
  String? slug;
  String? catId;
  String? banner;
  String? fullBanner;
  String? icon;
  String? fullIcon;
  String? subCatName;
  String? listCount;

  SubcatData(
      {this.subCatId,
        this.slug,
        this.catId,
        this.banner,
        this.fullBanner,
        this.icon,
        this.fullIcon,
        this.subCatName,
        this.listCount});

  SubcatData.fromJson(Map<String, dynamic> json) {
    subCatId = json['sub_cat_id'];
    slug = json['slug'];
    catId = json['cat_id'];
    banner = json['banner'];
    fullBanner = json['full_banner'];
    icon = json['icon'];
    fullIcon = json['full_icon'];
    subCatName = json['sub_cat_name'];
    listCount = json['list_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_cat_id'] = subCatId;
    data['slug'] = slug;
    data['cat_id'] = catId;
    data['banner'] = banner;
    data['full_banner'] = fullBanner;
    data['icon'] = icon;
    data['full_icon'] = fullIcon;
    data['sub_cat_name'] = subCatName;
    data['list_count'] = listCount;
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

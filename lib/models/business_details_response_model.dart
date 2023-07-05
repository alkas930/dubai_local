class BusinessDetailResponseModel {
  BusinessData? businessData;
  String? metaTitle;
  String? title;
  String? metaDesc;
  AppData? appData;
  dynamic claim;

  BusinessDetailResponseModel(
      {this.businessData,
      this.metaTitle,
      this.title,
      this.metaDesc,
      this.appData,
      this.claim});

  BusinessDetailResponseModel.fromJson(Map<String, dynamic> json) {
    businessData = json['business_data'] != null
        ? BusinessData.fromJson(json['business_data'])
        : null;
    metaTitle = json['meta_title'];
    title = json['title'];
    metaDesc = json['meta_desc'];
    appData =
        json['app_data'] != null ? AppData.fromJson(json['app_data']) : null;
    claim = json['claim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (businessData != null) {
      data['business_data'] = businessData!.toJson();
    }
    data['meta_title'] = metaTitle;
    data['title'] = title;
    data['meta_desc'] = metaDesc;
    if (appData != null) {
      data['app_data'] = appData!.toJson();
    }
    data['claim'] = claim;
    return data;
  }
}

class BusinessData {
  String? id;
  String? name;
  String? address;
  String? description;
  String? url;
  String? districtId;
  String? nearbyLocId;
  String? slug;
  String? userId;
  String? featureType;
  String? status;
  String? isClaimed;
  String? isVerified;
  String? email;
  String? phone;
  String? banner;
  String? fullBanner;
  String? moreImages;
  String? lat;
  String? lng;
  String? timings;
  String? numRating;
  String? averageRating;
  String? avgRating;
  String? average_rating;
  String? countRating;
  String? subCatName;
  String? catName;
  String? districtName;
  String? location_url;

  BusinessData(
      {this.id,
      this.name,
      this.address,
      this.description,
      this.url,
      this.districtId,
      this.nearbyLocId,
      this.slug,
      this.userId,
      this.featureType,
      this.status,
      this.isClaimed,
      this.isVerified,
      this.email,
      this.phone,
      this.banner,
      this.fullBanner,
      this.moreImages,
      this.lat,
      this.lng,
      this.timings,
      this.numRating,
      this.averageRating,
      this.average_rating,
      this.avgRating,
      this.countRating,
      this.subCatName,
      this.catName,
      this.districtName,
      this.location_url});

  BusinessData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    description = json['description'];
    url = json['url'];
    districtId = json['district_id'];
    nearbyLocId = json['nearby_loc_id'];
    slug = json['slug'];
    userId = json['user_id'];
    featureType = json['feature_type'];
    status = json['status'];
    isClaimed = json['is_claimed'];
    isVerified = json['is_verified'];
    email = json['email'];
    phone = json['phone'];
    banner = json['banner'];
    fullBanner = json['full_banner'];
    moreImages = json['more_images'];
    lat = json['lat'];
    lng = json['lng'];
    timings = json['timings'];
    numRating = json['num_rating'];
    averageRating = json['aeverage_rating'];
    average_rating = json['average_rating'];
    avgRating = json['avg_rating'];
    countRating = json['count_rating'];
    subCatName = json['sub_cat_name'];
    catName = json['cat_name'];
    districtName = json['district_name'];
    location_url = json['location_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['description'] = description;
    data['url'] = url;
    data['district_id'] = districtId;
    data['nearby_loc_id'] = nearbyLocId;
    data['slug'] = slug;
    data['user_id'] = userId;
    data['feature_type'] = featureType;
    data['status'] = status;
    data['is_claimed'] = isClaimed;
    data['is_verified'] = isVerified;
    data['email'] = email;
    data['phone'] = phone;
    data['banner'] = banner;
    data['full_banner'] = fullBanner;
    data['more_images'] = moreImages;
    data['lat'] = lat;
    data['lng'] = lng;
    data['timings'] = timings;
    data['num_rating'] = numRating;
    data['aeverage_rating'] = averageRating;
    data['average_rating'] = average_rating;
    data['avg_rating'] = avgRating;
    data['count_rating'] = countRating;
    data['sub_cat_name'] = subCatName;
    data['cat_name'] = catName;
    data['district_name'] = districtName;
    data['location_url'] = location_url;
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

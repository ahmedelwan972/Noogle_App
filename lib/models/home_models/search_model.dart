class SearchModel {
  bool? status;
  bool? accountStatus;
  String? message;
  List<String>? errors;
  SearchData? data;



  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accountStatus = json['account_status'];
    message = json['message'];
    errors = json['errors'].cast<String>();
    data = json['data'] != null ?  SearchData.fromJson(json['data']) : null;
  }


}

class SearchData {
  int? totalItems;
  bool? hasMore;
  List<SearchAnnouncements>? announcements;


  SearchData.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    hasMore = json['has_more'];
    if (json['announcements'] != null) {
      announcements = <SearchAnnouncements>[];
      json['announcements'].forEach((v) {
        announcements!.add( SearchAnnouncements.fromJson(v));
      });
    }
  }


}

class SearchAnnouncements {
  int? id;
  String? name;
  String? description;
  String? price;
  String? createdAt;
  String? mainImage;
  int? cityId;
  String? cityName;
  int? typeId;
  String? typeName;
  bool? isSpecial;
  bool? isFavourite;


  SearchAnnouncements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    createdAt = json['created_at'];
    mainImage = json['main_image'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    typeId = json['type_id'];
    typeName = json['type_name'];
    isSpecial = json['is_special'];
    isFavourite = json['is_favourite'];
  }


}

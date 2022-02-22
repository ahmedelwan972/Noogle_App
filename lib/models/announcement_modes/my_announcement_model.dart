class MyAnnouncementModel {
  bool? status;
  bool? accountStatus;
  String? message;
  List<String>? errors;
  Data? data;



  MyAnnouncementModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accountStatus = json['account_status'];
    message = json['message'];
    errors = json['errors'].cast<String>();
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }


}

class Data {
  int? totalItems;
  bool? hasMore;
  List<MyAnnouncements>? announcements;

  Data({this.totalItems, this.hasMore, this.announcements});

  Data.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    hasMore = json['has_more'];
    if (json['announcements'] != null) {
      announcements = <MyAnnouncements>[];
      json['announcements'].forEach((v) {
        announcements!.add( MyAnnouncements.fromJson(v));
      });
    }
  }


}

class MyAnnouncements {
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



  MyAnnouncements.fromJson(Map<String, dynamic> json) {
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

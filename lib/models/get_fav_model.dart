class GetFavoritesModel {
  bool? status;
  bool? accountStatus;
  String? message;
  List<String>? errors;
  List<GetFavoritesData>? data;


  GetFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accountStatus = json['account_status'];
    message = json['message'];
    errors = json['errors'].cast<String>();
    if (json['data'] != null) {
      data = <GetFavoritesData>[];
      json['data'].forEach((v) {
        data!.add( GetFavoritesData.fromJson(v));
      });
    }
  }


}

class GetFavoritesData {
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


  GetFavoritesData.fromJson(Map<String, dynamic> json) {
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

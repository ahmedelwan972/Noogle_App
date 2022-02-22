class CityModel {
  bool? status;
  bool? accountStatus;
  String? message;
  List<Data>? data;



  CityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accountStatus = json['account_status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }


}

class Data {
  int? id;
  String? name;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }


}

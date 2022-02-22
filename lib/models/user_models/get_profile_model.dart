class GetProfileModel {
  bool? status;
  bool? accountStatus;
  String? message;
  List<String>? errors;
  GetProfileData? data;


  GetProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accountStatus = json['account_status'];
    message = json['message'];
    errors = json['errors'].cast<String>();
    data = json['data'] != null ? new GetProfileData.fromJson(json['data']) : null;
  }


}

class GetProfileData {
  int? id;
  String? username;
  String? email;
  String? account;
  String? phone;


  GetProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    account = json['account'];
    phone = json['phone'];
  }


}


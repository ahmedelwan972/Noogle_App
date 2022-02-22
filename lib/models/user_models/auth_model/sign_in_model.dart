class SignInModel{
  bool? status;
  SignInData? data;
  List<String>? errors;
  SignInModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    errors = json['errors'].cast<String>();
    data = json['data'] != null ?  SignInData.fromJson(json['data']) : null;

  }
}


class SignInData{
  String? token;
  bool? activated;
  SignInData.fromJson(Map<String,dynamic>json){
    token = json['token'];
    activated = json['activated'];
  }
}
class UpdateProfileModel{
  bool? status;
  List<String>? errors;
  UpdateProfileModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    errors = json['errors'].cast<String>();
  }

}
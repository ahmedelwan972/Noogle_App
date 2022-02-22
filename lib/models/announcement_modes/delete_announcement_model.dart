class DeleteAnnouncementModel {
  bool? status;
  bool? accountStatus;
  String? message;
  List<String>? errors;


  DeleteAnnouncementModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accountStatus = json['account_status'];
    message = json['message'];
    errors = json['errors'].cast<String>();
  }
}

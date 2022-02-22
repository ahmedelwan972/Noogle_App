class ShowAnnouncementModel {
  bool? status;
  bool? accountStatus;
  String? message;
  List<String>? errors;
  ShowAnnouncementData? data;


  ShowAnnouncementModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accountStatus = json['account_status'];
    message = json['message'];
    errors = json['errors'].cast<String>();
    data = json['data'] != null ?  ShowAnnouncementData.fromJson(json['data']) : null;
  }


}

class ShowAnnouncementData {
  int? id;
  List<Sliders>? sliders;
  String? address;
  String? description;
  String? price;
  bool? isFavourite;
  int? cityId;
  String? cityName;
  int? typeId;
  String? typeName;
  String? createdAt;
  int? userId;
  String? userName;
  String? userPhone;
  Null? twitterShareLink;
  Null? whatsShareLink;
  int? commentsNumber;
  List<Comments>? comments;


  ShowAnnouncementData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(Sliders.fromJson(v));
      });
    }
    address = json['address'];
    description = json['description'];
    price = json['price'];
    isFavourite = json['is_favourite'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    typeId = json['type_id'];
    typeName = json['type_name'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    twitterShareLink = json['twitter_share_link'];
    whatsShareLink = json['whats_share_link'];
    commentsNumber = json['comments_number'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add( Comments.fromJson(v));
      });
    }
  }


}

class Sliders {
  int? id;
  String? image;


  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }


}

class Comments {
  int? commentId;
  int? commentUserId;
  String? commentUserName;
  String? comment;
  String? commentCreatedAt;
  List<Replies>? replies;



  Comments.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    commentUserId = json['comment_user_id'];
    commentUserName = json['comment_user_name'];
    comment = json['comment'];
    commentCreatedAt = json['comment_created_at'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add( Replies.fromJson(v));
      });
    }
  }


}

class Replies {
  int? replyId;
  int? replyUserId;
  String? replyUserName;
  String? reply;
  String? replyCreatedAt;



  Replies.fromJson(Map<String, dynamic> json) {
    replyId = json['reply_id'];
    replyUserId = json['reply_user_id'];
    replyUserName = json['reply_user_name'];
    reply = json['reply'];
    replyCreatedAt = json['reply_created_at'];
  }


}

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:noogle/layout/cubit/states.dart';
import 'package:noogle/models/announcement_modes/add_announcement_mode.dart';
import 'package:noogle/models/announcement_modes/delete_announcement_model.dart';
import 'package:noogle/models/announcement_modes/my_announcement_model.dart';
import 'package:noogle/models/announcement_modes/show_announcement_model.dart';
import 'package:noogle/models/get_fav_model.dart';
import 'package:noogle/models/home_models/city_model.dart';
import 'package:noogle/models/home_models/get_departments_model.dart';
import 'package:noogle/models/home_models/home_model.dart';
import 'package:noogle/models/home_models/search_model.dart';
import 'package:noogle/models/user_models/auth_model/sign_in_model.dart';
import 'package:noogle/models/user_models/update_profile_model.dart';
import 'package:noogle/modules/add_anno/add_anno_screen.dart';
import 'package:noogle/modules/home/home_screen.dart';
import 'package:noogle/models/home_models/type_model.dart';
import 'package:noogle/modules/mneu/menu_screen.dart';
import 'package:noogle/modules/user/user_screen.dart';
import 'package:noogle/shared/components/constants.dart';
import 'package:noogle/shared/network/end_point.dart';
import 'package:noogle/shared/network/remote/dio.dart';

import '../../models/home_models/fast_search_model.dart';
import '../../models/user_models/get_profile_model.dart';

class NoogleCubit extends Cubit<NoogleStates>{

  NoogleCubit() : super(InitState());

  static NoogleCubit get (context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isSearch = false;

  changeIndex(int index)
  {
    currentIndex = index;
    emit(ChangeIndexState());
  }

  List<Widget> screen = [
    HomeScreen(),
    UserScreen(),
    AddAnnoScreen(),
   // MenuScreen(),
  ];

  List<String> titles = [
    'الرئيسية',
    'الصفحة الشخصية',
    'اضافة اعلان',
    'القائمة',
  ];



  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }else{}
    print("Image List Length:" + imageFileList.length.toString());
    emit(SelectMultiImagePickedState());
  }

  List<XFile> imageFileListForUpdate = [];

  void selectImagesForUpdate() async {
    final List<XFile>? selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileListForUpdate.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileListForUpdate.length.toString());
    emit(SelectMultiImagePickedState());
  }

  void justEmitState(){
    emit(JustEmitState());
  }

  isSearchCompanyEmit() {
    isSearch = !isSearch;
    emit(ChangeCheckState());
  }

  checkInterNet()async{
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      result = state;
      print(result);
      emit(CheckNetState());
    });
  }

/////////////////////////////////////////////////////AUTH////////////////////////////////////////////////////////

  bool isPasswordIn = true;
  void changeVisiIn (){
    isPasswordIn = !isPasswordIn;
    emit(ChangeVisiInState());
  }

  bool isPasswordUp = true;
  void changeVisiUp (){
    isPasswordUp = !isPasswordUp;
    emit(ChangeVisiUpState());
  }

  bool isPasswordUp2 = true;
  void changeVisiUp2 (){
    isPasswordUp2 = !isPasswordUp2;
    emit(ChangeVisiUp2State());
  }

  bool isAgreeUp = false;

  void agreeUp(){
    isAgreeUp = !isAgreeUp;
    emit(AgreeUpState());
  }

  SignInModel? signInModel;

  void signIn({
  required String userName,
  required String password,
}){
    emit(SignInLoadingState());
    DioHelper.postData(
      url: signInUrl,
      data: {
        'key' : userName,
        'password' : password,
      },
    ).then((value) {
      signInModel = SignInModel.fromJson(value.data);
      emit(SignInSuccessState());
    }).catchError((e){
      print(e.toString());
      emit(SignInErrorState());
    });
  }

  void signUp({
    required String userName,
    required String email,
    required String account,
    required String phone,
    required String password,
    required String cPassword,
  }){
    signInModel;
    emit(SignUpLoadingState());
    DioHelper.postData(
      url: signUpUrl,
      data: {
        'username' : userName,
        'email' : email,
        'account' : account,
        'phone' : phone,
        'password' : password,
        'confirm_password' : cPassword,
      },
    ).then((value) {
      signInModel = SignInModel.fromJson(value.data);
      emit(SignUpSuccessState());
    }).catchError((e){
      print(e.toString());
      emit(SignUpErrorState());
    });
  }

////////////////////////////////////////profile////////////////////////////////////////////////////////////////////////

  bool isPasswordEd = true;
  void changeVisiEd (){
    isPasswordEd = !isPasswordEd;
    emit(ChangeVisiEdState());
  }
  bool isPasswordEd2 = true;
  void changeVisiEd2 (){
    isPasswordEd2 = !isPasswordEd2;
    emit(ChangeVisiEd2State());
  }
  bool isPasswordEd3 = true;
  void changeVisiEd3 () {
    isPasswordEd3 = !isPasswordEd3;
    emit(ChangeVisiEd3State());
  }
  GetProfileModel? getProfileModel;
  void getProf()async{
    emit(GetProfileLoadingState());
   await DioHelper.getData(
        url: getProfile,
        token: token,
    ).then((value) {
      print(value.data);
      getProfileModel = GetProfileModel.fromJson(value.data);
      emit(GetProfileSuccessState());
    }).catchError((e){
      emit(GetProfileErrorState());
    });
  }

  UpdateProfileModel? updateProfileModel;
  void updateProf({
  required String username,
  required String email,
  required String account,
  required String phone,
}){
    emit(UpdateProfileLoadingState());
    DioHelper.postData(
      url: updateProfile,
      token: token,
      data: {
        'username' : username,
        'email' : email,
        'account' : account,
        'phone' : phone,
      }
    ).then((value) {
      updateProfileModel = UpdateProfileModel.fromJson(value.data);
      emit(UpdateProfileSuccessState());
    }).catchError((e){
      emit(UpdateProfileErrorState());
    });
  }

  void updatePassword({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }){
    updateProfileModel = null;
    emit(UpdatePasswordLoadingState());
    DioHelper.postData(
        url: updatePass,
        token: token,
        data: {
          'old_password' : oldPassword,
          'password' : password,
          'confirm_password' : confirmPassword,
        }
    ).then((value) {
      updateProfileModel = UpdateProfileModel.fromJson(value.data);
      emit(UpdatePasswordSuccessState());
    }).catchError((e){
      emit(UpdatePasswordErrorState());
    });
  }

///////////////////////////////////////////////////////////////Home/////////////////////////////////////////////////////////////



  HomeModel? homeModel;

  Map<int, bool> favorites = {};


  void homeUser(){
    emit(HomeLoadingState());
    DioHelper.getData(
      url: 'https://klm.cdy.mybluehost.me/moogle/public/api/user/home',
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.announcements!.forEach((element) {
        if(favorites[element.id] == null){
        favorites.addAll({
          element.id!: element.isFavourite!,
        });
        }
      });
      emit(HomeSuccessState());
    }).catchError((e){
      print(e.toString());
      emit(HomeErrorState());
    });
  }

  void getMoreHomeUser({int? page})async{
    emit(GetMoreHomeLoadingState());
   await DioHelper.getData(
      url: 'https://klm.cdy.mybluehost.me/moogle/public/api/user/home?page=$page',
      token: token,
    ).then((value) {
      homeModel!.data!.hasMore = value.data['data']['has_more'];
      value.data['data']['announcements'].forEach((v) {
        homeModel!.data!.announcements!.add( HomeAnnouncements.fromJson(v));
      });
      homeModel!.data!.announcements!.forEach((element) {
        if(favorites[element.id] == null) {
          favorites.addAll({
            element.id!: element.isFavourite!,
          });
        }
      });
      emit(GetMoreHomeSuccessState());
    }).catchError((e){
      print(e.toString());
      emit(GetMoreHomeErrorState());
    });
  }



  void addFavorites({
  required int annoId,
}){
    favorites[annoId] = !favorites[annoId]!;
    emit(AddAndDeleteFavLoadingState());
    DioHelper.postData(
      url: addAndDeleteFav,
      token: token,
      data: {
        'announcement_id' : annoId,
      }
    ).then((value) {
      emit(AddAndDeleteFavSuccessState());
    }).catchError((e){
      favorites[annoId] = !favorites[annoId]!;
      emit(AddAndDeleteFavErrorState());
    });
  }



  CityModel? cityModel;

  getCity(){
    emit(GetCityLoadingState());
    DioHelper.getData(
      url: getCities,).then((value) {
      cityModel = CityModel.fromJson(value.data);
      emit(GetCityState());
    });
  }
  DepartmentModel? departmentModel;
  getDep(){
    emit(GetDepartmentsLoadingState());
    DioHelper.getData(
      url: getDepartments,
    ).then((value) {
      departmentModel = DepartmentModel.fromJson(value.data);
      emit(GetDepartmentsState());
    });
  }

  TypeModel? typeModel;

  getType(){
    emit(GetTypeLoadingState());
    DioHelper.getData(
      url: getTypes,).then((value) {
      typeModel = TypeModel.fromJson(value.data);
      emit(GetTypeState());
    });
  }
  SearchModel? searchModel;
  Future<void>search({
    required String cityId,
    required String typeId,
    required String bathroomsNum,
    required String roomsNum,
    required String maxDistance,
    required String minDistance,
    required String maxPrice,
    required String minPrice,
    required String search,

})async{
    emit(SearchLoadingState());
   await DioHelper.postData(
     token: token,
     url: 'user/search?city_id=$cityId&type_id=$typeId&bathrooms_num=$bathroomsNum&rooms_num=$roomsNum&max_distance=$maxDistance&min_distance=$minDistance&max_price=$maxPrice&min_price=$minPrice&search=$search',
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((e){
      emit(SearchErrorState());
    });
  }
  FastSearchModel? fastSearchModel;
  void fastSearch(String text)async{
    emit(FastSearchLoadingState());
   await DioHelper.getData(
      url: 'user/search/fast?search=$text',
    ).then((value) {
      fastSearchModel = FastSearchModel.fromJson(value.data);
      fastSearchModel!.data!.announcements!.forEach((element) {
        if(favorites[element.id] == null) {
          favorites.addAll({
            element.id!: element.isFavourite!,
          });
        }
      });
      emit(FastSearchSuccessState());
    }).catchError((e){
      emit(FastSearchErrorState());
    });
  }

  bool isAgreeEdAnno = false;

  void agreeEdAnno(){
    isAgreeEdAnno = !isAgreeEdAnno;
    emit(AgreeEdAnnoState());
  }
  bool isAgreeAddAnno = false;

  void agreeAddAnno(){
    isAgreeAddAnno = !isAgreeAddAnno;
    emit(AgreeAddAnnoState());
  }

//////////////////////////////////////////////////////////announcement/////////////////////////////////////////////////////////////



  AddAnnouncementsModel? addAnnouncementsModel;
  Future<void> addAn({
  required String status,
  required String typeId,
  required String bathroomsNum,
  required String roomsNum,
  required String deptId,
  required String cityId,
  required String distance,
  required String price,
  required String address,
  required String description,
})async{

     FormData formData =  FormData.fromMap({
      'status' : status,
      'type_id' : typeId,
      'bathrooms_num' : bathroomsNum,
      'rooms_num' : roomsNum,
      'dept_id' : deptId,
      'city_id' : cityId,
      'distance' : distance,
      'price' : price,
      'address' : address,
      'description' : description,
      'images[]': imageFileList.map((item)=> MultipartFile.fromFileSync(item.path,
          filename: item.path.split('/').last)).toList()
    });
    emit(AddAnnouncementsLoadingState());
    await DioHelper.postData2(
        url: addAnnoun,
        token: token,
        formData: formData,
    ).then((value) {
      addAnnouncementsModel = AddAnnouncementsModel.fromJson(value.data);
      emit(AddAnnouncementsSuccessState());
      print(value);
    }).catchError((e){
      print(e.toString());
      emit(AddAnnouncementsErrorState());
    });

  }



  MyAnnouncementModel? myAnnouncementModel;
  myAnnouncements()async{
    emit(MyAnnouncementsLoadingState());
   await DioHelper.getData(
        url:'user/myadds',
        token:token,
    ).then((value) {
      myAnnouncementModel = MyAnnouncementModel.fromJson(value.data);
      myAnnouncementModel!.data!.announcements!.forEach((element) {
        if(favorites[element.id] == null){
          favorites.addAll({
            element.id!: element.isFavourite!,
          });
        }
      });
      emit(MyAnnouncementsSuccessState());
    }).catchError((e){
      emit(MyAnnouncementsErrorState());
    });
  }

  getMoreMyAnnouncements({int? page})async{
    emit(GetMoreMyAnnouncementsLoadingState());
    await DioHelper.getData(
      url:'user/myadds?page=${page??1}',
      token:token,
    ).then((value) {
      myAnnouncementModel!.data!.hasMore = value.data['data']['has_more'];
      value.data['data']['announcements'].forEach((v) {
        myAnnouncementModel!.data!.announcements!.add( MyAnnouncements.fromJson(v));
      });
      myAnnouncementModel!.data!.announcements!.forEach((element) {
        if(favorites[element.id] == null) {
          favorites.addAll({
            element.id!: element.isFavourite!,
          });
        }
      });
      emit(MyAnnouncementsSuccessState());
    }).catchError((e){
      emit(MyAnnouncementsErrorState());
    });
  }


  bool isSoldIn = false;
  void isSoldInCheck(){
    isSoldIn = !isSoldIn;
    selected = 'تم الاختيار تم البيع';
    isSoldOut = false;
    notSold = false;

    emit(SoldInState());
  }

  bool isSoldOut = false;
  void isSoldOutCheck(){
    isSoldOut = !isSoldOut;
    selected = 'تم الاختيار تم بيع بالخارج';
    isSoldIn = false;
    notSold = false;

    emit(SoldOutState());
  }

  bool notSold = false;
  void notSoldOCheck(){
    notSold = !notSold;
    selected = 'تم الاختيار لم يتم البيع';
    isSoldIn = false;
    isSoldOut = false;
    emit(NotSoldState());
  }

  Future<void> chooseSelect() async {
    if(isSoldIn) {
      soldType = 0;
      emit(JustEmitState());
    } else if(isSoldOut){
      soldType = 1;
      emit(JustEmitState());
    }else {
      soldType = 2;
      emit(JustEmitState());
    }
  }

  String? selected;

  DeleteAnnouncementModel? deleteAnnouncementModel;
  int? soldType;
  Future<void>deleteAnnouncements({
    required int announcementId,
    required String ordersPrice,
    required String reason,
})async{
   await DioHelper.postData(
      url: deleteAnnoun,
      token: token,
      data: {
        'announcement_id': announcementId,
        'sold_type' : soldType.toString(),
        'orders_price' : ordersPrice,
        'reason' : reason,
      }
    ).then((value) {
      deleteAnnouncementModel = DeleteAnnouncementModel.fromJson(value.data);
      print(value.data);
      emit(DeleteAnnouncementsSuccessState());
    }).catchError((e){
      print(e.toString());
      emit(DeleteAnnouncementsErrorState());
    });
  }


  Future<void> updateAn({
    required String status,
    required String typeId,
    required String bathroomsNum,
    required String roomsNum,
    required String deptId,
    required String cityId,
    required String distance,
    required String price,
    required String address,
    required String description,
    required int announcementId,
  })async{
     addAnnouncementsModel;
     FormData formData =  FormData.fromMap({
      'status' : status,
      'type_id' : typeId,
      'bathrooms_num' : bathroomsNum,
      'rooms_num' : roomsNum,
      'dept_id' : deptId,
      'city_id' : cityId,
      'distance' : distance,
      'price' : price,
      'address' : address,
      'description' : description,
       'announcement_id' : announcementId,
      'images[]': imageFileListForUpdate.map((item)=> MultipartFile.fromFileSync(item.path,
          filename: item.path.split('/').last)).toList()
    });
    emit(UpdateAnnouncementsLoadingState());
    await DioHelper.postData2(
      url: updateAnnoun,
      token: token,
      formData: formData,
    ).then((value) {
      addAnnouncementsModel = AddAnnouncementsModel.fromJson(value.data);
      emit(UpdateAnnouncementsSuccessState());
      print(value);
    }).catchError((e){
      print(e.toString());
      emit(UpdateAnnouncementsErrorState());
    });

  }

  ShowAnnouncementModel? showAnnouncementModel;
  void showAnnouncements({
  required int id,
})async {
   await DioHelper.getData(
        url: 'user/details/announcement?announcement_id=$id',
    ).then((value) {
      showAnnouncementModel = ShowAnnouncementModel.fromJson(value.data);
      showAnnouncementModel!.data!.comments!.forEach((element) {
        chooseComment.addAll({
          element.commentId!: false,
        });
        element.replies!.forEach((element) {
          replayComment.addAll({
            element.replyId! : false,
          });
        });
      });

      emit(ShowAnnouncementsSuccessState());
    }).catchError((e){
      emit(ShowAnnouncementsErrorState());
    });
  }

  Future<void> addComment({
    required String comment,
})async{
    emit(CommentLoadingState());
   await DioHelper.postData(
      url: addComments,
      token: token,
      data: {
        'announcement_id' : showAnnouncementModel!.data!.id!.toString() ,
        'comment':comment,
      }
    ).then((value) {
      print(value.data);
      emit(CommentSuccessState());
    }).catchError((e){
      emit(CommentErrorState());
    });
  }

  Future<void> addReplay({
    required int commentId,
    required String reply,
  })async{
    emit(ReplayLoadingState());
    await DioHelper.postData(
        url: addReplays,
        token: token,
        data: {
          'comment_id' :commentId ,
          'reply':reply,
        }
    ).then((value) {
      print(value.data);
      emit(ReplaySuccessState());
    }).catchError((e){
      emit(ReplayErrorState());
    });
  }

  Map<int ,bool> chooseComment = {};
  Map<int ,bool> replayComment = {};

  void choseComment({
  required int id,
}){
    chooseComment[id] = !chooseComment[id]!;
    emit(ChooseCommentState());
  }

  void chooseReplay({
    required int id,
  }){
    replayComment[id] = !replayComment[id]!;
    emit(ReplayState());
  }


  GetFavoritesModel? getFavoritesModel;
  void getFavorites()async{
    emit(GetFavoritesLoadingState());
    await DioHelper.getData(
      url: getFav,
      token: token,
    ).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      emit(GetFavoritesSuccessState());
    }).catchError((e){
      emit(GetFavoritesErrorState());
    });
  }
  ScrollController scrollController = ScrollController();
  int currentPage = 1;

  void getMoreForHome(){
    scrollController.addListener(() {
      if(scrollController.offset == scrollController.position.maxScrollExtent&& homeModel!.data!.hasMore!){
        currentPage++;
        getMoreHomeUser(page: currentPage);
        emit(GetMoreData());
      }
    });
  }

  ScrollController scrollControllerForAnnouncements = ScrollController();
  int currentPageForAnnouncements = 1;

  void getMoreForAnnouncement(){
    scrollControllerForAnnouncements.addListener(() {
      if(scrollControllerForAnnouncements.offset == scrollControllerForAnnouncements.position.maxScrollExtent&& myAnnouncementModel!.data!.hasMore!){
        currentPageForAnnouncements++;
        getMoreMyAnnouncements(page: currentPageForAnnouncements);
        emit(GetMoreData());
      }
    });
  }


  // ScrollController scrollControllerForFastSearch = ScrollController();
  // int currentPageForFastSearch = 1;
  //
  // void getMoreForFastSearch(){
  //   scrollControllerForFastSearch.addListener(() {
  //     if(scrollControllerForFastSearch.offset == scrollControllerForFastSearch.position.maxScrollExtent&& fastSearchModel!.data!.hasMore!){
  //       currentPageForFastSearch++;
  //       GetFastSearchMore(page: currentPageForFastSearch);
  //       emit(GetMoreData());
  //     }
  //   });
  // }


}
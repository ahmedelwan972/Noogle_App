import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noogle/layout/cubit/cubit.dart';
import 'package:noogle/layout/cubit/states.dart';
import 'package:noogle/layout/noogle_layout.dart';
import 'package:noogle/models/announcement_modes/my_announcement_model.dart';
import 'package:noogle/modules/show_announcemnet_screen.dart';
import 'package:noogle/modules/user/user_anno/edit_anno_screen.dart';
import 'package:noogle/shared/components/components.dart';
import 'package:noogle/shared/components/constants.dart';
import 'package:noogle/shared/styles/colors.dart';

class UserAnnoScreen extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var textController = TextEditingController();
  var priceController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoogleCubit,NoogleStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = NoogleCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: appBar(
            text: 'قائمة اعلاناتي',
            leading: IconButton(
              onPressed: (){
                cubit.homeUser();
                Navigator.pop(context);
              },
              icon: Icon(
                  Icons.arrow_back
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition:cubit.myAnnouncementModel != null && state is! MyAnnouncementsLoadingState ,
            builder: (context) => cubit.myAnnouncementModel!.data!.totalItems! >0 ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: ()=>refresh2(context),
                    child: ListView.separated(
                      controller: cubit.scrollControllerForAnnouncements,
                      shrinkWrap: true,
                      itemBuilder: (context,index) => buildUserAnnoItems(cubit.myAnnouncementModel!.data!.announcements![index],context),
                      separatorBuilder: (context,index) => SizedBox(
                        height: 10,),
                      itemCount: cubit.myAnnouncementModel!.data!.announcements!.length,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                if(cubit.scrollControllerForAnnouncements.positions.isNotEmpty)
                  if(cubit.scrollControllerForAnnouncements.offset == cubit.scrollControllerForAnnouncements.position.maxScrollExtent&&cubit.myAnnouncementModel!.data!.hasMore!)Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),

              ],
            ) : Center(child: Text('لا تملك اعلان')),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  buildUserAnnoItems(MyAnnouncements model,context ){
    var cubit = NoogleCubit.get(context);
    return InkWell(
      onTap: (){
        NoogleCubit.get(context).showAnnouncements(id: model.id!);
        navigateTo(context, ShowAnnouncement());
      },
      child: Card(
        elevation: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                Image(
                  image: NetworkImage(
                    model.mainImage!,
                  ),
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder:(context , error , stackTrace) => Center(child: CircularProgressIndicator()),
                ),
                elevetion(size: 150),
                Container(
                  height: 150,
                  width: double.infinity,
                  alignment: AlignmentDirectional.bottomEnd,
                  padding: EdgeInsetsDirectional.all(15),
                  child: Text(
                    model.name!,
                    style: TextStyle(
                        color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                model.description!,
                maxLines: 3,
                overflow:TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed : (){
                      cubit.addFavorites(annoId: model.id!);
                    },
                    icon: Icon(
                      Icons.favorite ,
                      color: token != null ? cubit.favorites[model.id]! ? Colors.red : Colors.grey[600] : Colors.grey,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'ريال',
                    style: TextStyle(
                        color: defaultColor
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    model.price!,
                    style: TextStyle(
                        color: defaultColor
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin:  EdgeInsets.symmetric(horizontal: 8.0),
              height: 70,
              child: Card(
                child: Row(
                  children: [
                    SizedBox(width: 5,),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            model.createdAt!,
                          ),
                          SizedBox(width: 5,),
                          Icon(
                            Icons.watch_later_outlined,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            model.typeName!,
                          ),
                          SizedBox(width: 5,),
                          Icon(
                            Icons.local_offer,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          model.cityName!,
                        ),
                        SizedBox(width: 5,),
                        Icon(
                          Icons.location_on,
                          size: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content:  Container(
                            height: 500,
                            width: 330,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10
                                    ),
                                    width: double.infinity,
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      maxLines: 6,
                                      decoration: InputDecoration(
                                        hintText: 'سبب حذف الاعلان',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      controller: textController,
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    width: double.infinity,
                                    color: Colors.grey[300],
                                    child: Text(
                                      'هل تم بيع المنتج او الخدمة ؟',
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      cubit.isSoldInCheck();
                                      showToast(msg: cubit.selected!);
                                    },
                                    child: Row(
                                      children: [
                                        Text('اختر من هنا',style: Theme.of(context).textTheme.caption),
                                        Spacer(),
                                        Text(
                                          'نعم تم البيع داخل الموقع',
                                          textAlign: TextAlign.end,

                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 40,
                                    width: double.infinity,
                                    child: defaultFormField(
                                        controller: priceController,
                                        label: 'سعر بيع المنتج او الخدمة*',
                                      ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      cubit.isSoldOutCheck();
                                      showToast(msg: cubit.selected!);
                                    },
                                    child: Row(
                                      children: [
                                        Text('اختر من هنا',style: Theme.of(context).textTheme.caption),
                                        Spacer(),
                                        Text(
                                          'تم البيع خارج الموقع',
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      cubit.notSoldOCheck();
                                      showToast(msg: cubit.selected!);
                                    },
                                    child: Row(
                                      children: [
                                        Text('اختر من هنا',style: Theme.of(context).textTheme.caption),
                                        Spacer(),
                                        Text(
                                          'لم يتم البيع ابدا',
                                          textAlign: TextAlign.end,

                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 50.0,
                                    child: MaterialButton(
                                      child: Text(
                                        'حذف الاعلان',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        if (textController.text.isNotEmpty) {
                                          if (cubit.isSoldIn || cubit.isSoldOut || cubit.notSold) {
                                            openDialog(context, model.id);
                                          } else {
                                            showToast(
                                                msg: 'يجب ان تحدد اين تم البيع',
                                                toastState: true);
                                          }
                                        } else {
                                          showToast(
                                              msg: 'يجب ان تحدد سبب حذف الاعلان',
                                              toastState: true);
                                        }
                                      },
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ).asStream();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(5),),
                      ),
                      height: 50,
                      width: 50,
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  Spacer(),
                  defaultButton(
                    function: (){
                      navigateTo(context, EditAnnoScreen(id: model.id,));
                    },
                    text: 'تعديل الاعلان',
                    width: 140
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future openDialog(context , id) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.7),
        content: Container(
          height: 180,
          width: 120,
          child: Column(
            children: [
              Text(
                'حذف الاعلان',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                'في حالة حذف الاعلان سوف يتم الحذف نهائيا ولا يمكن الرجوع عن هذه الخطوة فيما بعد',
                textAlign: TextAlign.center,
              ),
              Container(
                color: Colors.black,
                width: double.infinity,
                height: 1,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child:Text(
                          'الغاء',
                          style: TextStyle(
                            color: Colors.black38
                          ),
                        ),
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    width: 1,
                    height: 47,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: (){
                          NoogleCubit.get(context).chooseSelect().then((value) {
                            NoogleCubit.get(context).deleteAnnouncements(
                              announcementId: id,
                              ordersPrice: priceController.text,
                              reason: textController.text,
                            ).then((value) {
                              if(NoogleCubit.get(context).deleteAnnouncementModel!.status!){
                                NoogleCubit.get(context).myAnnouncements();
                                navigateAndFinish(context, NoogleLayout());
                                showToast(msg: 'تم الالغاء بنجاح');
                              }else {
                                showToast(msg: NoogleCubit.get(context).deleteAnnouncementModel!.errors.toString());
                              }
                            });
                          });
                        },
                        child:Text(
                          'حذف',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );}


}

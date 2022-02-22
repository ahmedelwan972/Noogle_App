import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noogle/layout/cubit/cubit.dart';
import 'package:noogle/layout/cubit/states.dart';
import 'package:noogle/modules/home/search_screen.dart';
import 'package:noogle/modules/user/auth/sgin_in_screen.dart';
import 'package:noogle/modules/user/auth/sgin_up_screen.dart';
import 'package:noogle/modules/user/edit_user_data_screen.dart';
import 'package:noogle/modules/user/fav_screen.dart';
import 'package:noogle/modules/user/user_anno/user_anno_screen.dart';
import 'package:noogle/shared/components/components.dart';
import 'package:noogle/shared/components/constants.dart';
import 'package:noogle/shared/network/local/cache_helper.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoogleCubit,NoogleStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = NoogleCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextButton(
                  onPressed: (){
                    cubit.currentIndex = 0;
                    cubit.currentPage = 1;
                    cubit.homeUser();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          'الصفحة الرئيسية',
                          ),
                      SizedBox(
                        width: 7,
                      ),
                      Icon(
                        Icons.home,
                        color: Colors.grey,
                      ),
                    ],
                  ),),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'البحث المتقدم',
                        ),
                      SizedBox(
                        width: 7,
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ],
                  ),),
                SizedBox(
                  height: 10,
                ),
                if(token != null)
                  Column(
                  children: [
                    TextButton(
                      onPressed: (){
                        cubit.currentIndex = 2;
                        cubit.justEmitState();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('اضافة اعلان',),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                              Icons.add_circle,
                            color: Colors.grey,

                          ),
                        ],
                      ),),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: (){
                        cubit.myAnnouncements();
                        navigateTo(context, UserAnnoScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('قائمة اعلاناتي',),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                              Icons.check_circle,
                            color: Colors.grey,

                          ),
                        ],
                      ),),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: (){
                        cubit.getFavorites();
                        navigateTo(context, FavScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('الاعلانات المفضلة',),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                              Icons.favorite,
                            color: Colors.grey,

                          ),
                        ],
                      ),),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: (){
                        navigateTo(context, EditUserDataScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('تعديل بيانات الحساب',),
                          SizedBox(
                            width: 7,
                          ),
                          Icon(
                              Icons.edit,
                            color: Colors.grey,
                          ),
                        ],
                      ),),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: (){
                        CacheHelper.removeData('myId');
                        token = null;
                        NoogleCubit.get(context).justEmitState();
                        },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('تسجيل الخروج'),
                          SizedBox(
                            width: 7,
                          ),
                          Icon(
                            Icons.logout,
                            color: Colors.grey,
                          ),
                        ],
                      ),),
                  ],
                ),
                if(token == null)
                  Column(
                    children: [
                      TextButton(
                        onPressed: (){
                          navigateTo(context, SignInScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('تسجيل الدخول',),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.login,
                              color: Colors.grey,

                            ),
                          ],
                        ),),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: (){
                          navigateTo(context, SginUpScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('انشاء حساب جديد',),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.create_new_folder,
                              color: Colors.grey,

                            ),
                          ],
                        ),),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

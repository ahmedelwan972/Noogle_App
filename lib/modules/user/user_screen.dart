import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noogle/layout/cubit/cubit.dart';
import 'package:noogle/layout/cubit/states.dart';
import 'package:noogle/modules/user/auth/sgin_in_screen.dart';
import 'package:noogle/modules/user/auth/sgin_up_screen.dart';
import 'package:noogle/modules/user/edit_user_data_screen.dart';
import 'package:noogle/modules/user/fav_screen.dart';
import 'package:noogle/modules/user/user_anno/user_anno_screen.dart';
import 'package:noogle/shared/components/components.dart';
import 'package:noogle/shared/components/constants.dart';
import 'package:noogle/shared/network/local/cache_helper.dart';
import 'package:noogle/shared/styles/colors.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoogleCubit, NoogleStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: token != null
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/profile_bg@2x.png'),
                    ),
                    InkWell(
                      onTap: () {
                        NoogleCubit.get(context).currentPageForAnnouncements = 1;
                        NoogleCubit.get(context).myAnnouncements();
                        navigateTo(context, UserAnnoScreen());
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                          ),
                          Spacer(),
                          Text(
                            'قائمة اعلاناتي',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.check_circle,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        NoogleCubit.get(context).getFavorites();
                        navigateTo(context, FavScreen());
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                          ),
                          Spacer(),
                          Text(
                            'الاعلانات المفضلة ',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.favorite,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        NoogleCubit.get(context).getProf();
                        navigateTo(context, EditUserDataScreen());
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                          ),
                          Spacer(),
                          Text(
                            'تعديل بيانات الحساب',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.settings,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      child: MaterialButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'تسجيل الخروج',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        onPressed: () {
                          CacheHelper.removeData('myId');
                          token = null;
                          NoogleCubit.get(context).justEmitState();
                        },
                      ),
                      decoration: BoxDecoration(
                        color: defaultColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Image(
                        image: AssetImage('assets/images/profile_bg@2x.png'),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'لم تقم بتسجيل الدخول الي التطبيق حتى الان ، برجاء تسجيل الدخول حتى تتمكن من متابعه صفحتك الشخصية',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      defaultButton(
                        function: () {
                          navigateTo(context, SignInScreen());
                        },
                        text: 'تسجيل الدخول',
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: OutlinedButton(
                          onPressed: () {
                            navigateTo(context, SginUpScreen());
                          },
                          child: Text('انشاء حساب جديد'),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

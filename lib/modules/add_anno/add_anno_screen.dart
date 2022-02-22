import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noogle/layout/cubit/cubit.dart';
import 'package:noogle/layout/cubit/states.dart';
import 'package:noogle/modules/user/auth/sgin_in_screen.dart';
import 'package:noogle/modules/user/auth/sgin_up_screen.dart';
import 'package:noogle/modules/user/user_anno/user_anno_screen.dart';
import 'package:noogle/shared/components/components.dart';
import 'package:noogle/shared/components/constants.dart';
import 'package:noogle/shared/styles/colors.dart';

class AddAnnoScreen extends StatelessWidget {
  var theStateController = TextEditingController();
  var bathroomsController = TextEditingController();
  var roomsController = TextEditingController();
  var sizeController = TextEditingController();
  var priceController = TextEditingController();
  var addressController = TextEditingController();
  var desController = TextEditingController();
  String? type;
  int? typeId;
  String? subsection;
  int? subsectionId;
  String? city;
  int? cityId;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoogleCubit, NoogleStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoogleCubit.get(context);
        return Scaffold(
          body: token != null
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          defaultFormField(
                              controller: theStateController,
                              suffix: Icons.stars,
                              label: 'الحالة',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'الحالة مطلوبة';
                                }
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            hint: Text('النوع'),
                            onChanged: (value) => type = value as String?,
                            items: cubit.typeModel!.data!
                                .map<DropdownMenuItem<String>>((e) {
                              typeId = e.id!;
                              return DropdownMenuItem(
                                child: Text(e.name!),
                                value: e.name!,
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              controller: bathroomsController,
                              label: 'عدد الحمامات',
                              suffix: Icons.bathtub,
                              type: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'هذه الخانة فارغة';
                                }
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              controller: roomsController,
                              label: 'عدد الغرف',
                              suffix: Icons.meeting_room_outlined,
                              type: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'هذه الخانة فارغة';
                                }
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            hint: Text('قسم فرعي'),
                            onChanged: (value) => subsection = value as String?,
                            items: cubit.departmentModel!.data!
                                .map<DropdownMenuItem<String>>((e) {
                              subsectionId = e.id!;
                              return DropdownMenuItem(
                                child: Text(e.name!),
                                value: e.name,
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            hint: Text('اختر المدينة'),
                            onChanged: (value) => city = value as String?,
                            items: cubit.cityModel!.data!
                                .map<DropdownMenuItem<String>>((e) {
                              cityId = e.id;
                              return DropdownMenuItem(
                                child: Text(e.name!),
                                value: e.name,
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              controller: sizeController,
                              label: 'المساحة',
                              suffix: Icons.space_bar,
                              type: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'هذه الخانة فارغة';
                                }
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              controller: priceController,
                              label: 'سعر بيع المنتج او الخدمة',
                              suffix: Icons.price_change,
                              type: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'هذه الخانة فارغة';
                                }
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              controller: addressController,
                              label: 'عنوان الاعلان',
                              suffix: Icons.title,
                              type: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'هذه الخانة فارغة';
                                }
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'لا يجب ان تكون هذه الخانه فارغة';
                                }
                              },
                              keyboardType: TextInputType.text,
                              maxLines: 6,
                              decoration: InputDecoration(
                                hintText: 'ادخل وصف شامل للاعلان الخاص بك',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              controller: desController,
                            ),
                          ),
                          defaultButton(
                            function: () {
                              cubit.selectImages();
                            },
                            text: 'ارفاق الصور',
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          if (cubit.imageFileList.isNotEmpty)
                            Container(
                              height: 220,
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: GridView.builder(
                                itemCount: cubit.imageFileList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4),
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        Image.file(
                                          File(cubit.imageFileList[index].path),
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              cubit.imageFileList.remove(
                                                  cubit.imageFileList[index]);
                                              cubit.justEmitState();
                                            },
                                            icon: Icon(Icons.highlight_remove_rounded,color: Colors.red,)),
                                      ]);
                                },
                              ),
                            ),
                          TextButton(
                            onPressed: () {
                              cubit.agreeAddAnno();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  cubit.isAgreeAddAnno
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank_sharp,
                                  color: cubit.isAgreeAddAnno
                                      ? defaultColor
                                      : Colors.black,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  'اوافق علي الاحكام الوشروط',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          state is! AddAnnouncementsLoadingState
                              ? defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      if (cubit.isAgreeAddAnno) {
                                        cubit.addAn(
                                          status: theStateController.text,
                                          typeId: typeId.toString(),
                                          bathroomsNum:
                                              bathroomsController.text,
                                          roomsNum: roomsController.text,
                                          deptId: subsectionId.toString(),
                                          cityId: cityId.toString(),
                                          distance: sizeController.text,
                                          price: priceController.text,
                                          address: addressController.text,
                                          description: desController.text,
                                        )
                                            .then((value) {
                                          if (cubit.addAnnouncementsModel!.status!) {
                                            showToast(msg: 'تم الاضافه بنجاح');
                                             theStateController.text = '';
                                            bathroomsController.text = '';
                                                roomsController.text = '';
                                                 sizeController.text = '';
                                                priceController.text = '';
                                              addressController.text = '';
                                                  desController.text = '';
                                                  cubit.isAgreeAddAnno = false;
                                            cubit.imageFileList.clear();
                                            type = null ;
                                            typeId = null;
                                            subsection = null;
                                            subsectionId = null;
                                            city = null;
                                            cityId = null;
                                            cubit.myAnnouncements();
                                            cubit.homeUser();
                                            navigateTo(context, UserAnnoScreen());
                                          } else {
                                            showToast(msg: cubit.addAnnouncementsModel!.errors.toString(), toastState: false);
                                          }
                                        });
                                      } else {
                                        showToast(
                                            msg: 'وافق علي الشروط و الاحكام اولا',
                                            toastState: true);
                                      }
                                    }
                                  },
                                  text: 'ارسال الاعلان',
                                )
                              : Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
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
                        'لم تقم بتسجيل الدخول الي التطبيق حتى الان ، برجاء تسجيل الدخول حتى تتمكن من اضافة اعلانك',
                        textAlign: TextAlign.end,
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
                        decoration: BoxDecoration(borderRadius:
                                BorderRadius.all(Radius.circular(15))),
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

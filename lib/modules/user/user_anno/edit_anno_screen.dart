import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noogle/layout/cubit/cubit.dart';
import 'package:noogle/layout/cubit/states.dart';
import 'package:noogle/shared/components/components.dart';

class EditAnnoScreen extends StatelessWidget {
  EditAnnoScreen({required this.id});
  int? id;
  var  theStateController = TextEditingController();
  var bathroomsController = TextEditingController();
  var     roomsController    = TextEditingController();
  var      sizeController    = TextEditingController();
  var     priceController = TextEditingController();
  var   addressController = TextEditingController();
  var       desController = TextEditingController();
  String? type;
  int? typeId;
  String? subsection;
  int? subsectionId;
  String? city;
  int? cityId;
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoogleCubit,NoogleStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = NoogleCubit.get(context);
        return Scaffold(
          appBar: appBar(text: 'تعديل الاعلان',
            leading: IconButton(
              onPressed: (){
                cubit.imageFileListForUpdate.clear();
                cubit.isAgreeEdAnno = false;
                type = null;
                typeId=null;
                subsection=null;
                subsectionId=null;
                city=null;
                cityId=null;
                 theStateController.text = '';
                bathroomsController.text = '';
                    roomsController.text = '';
                     sizeController.text = '';
                    priceController.text = '';
                  addressController.text = '';
                      desController.text = '';
                Navigator.pop(context);
              },
              icon: Icon(
                  Icons.arrow_back
              ),
            ),
          ),
          body: SingleChildScrollView(
            child:  Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultFormField(
                        controller: theStateController,
                        suffix: Icons.stars,
                        label: 'الحالة',
                        validator: (value){
                          if(value.isEmpty){
                            return 'الحالة مطلوبة';
                          }
                        }
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      hint: Text('النوع'),
                      onChanged: (value)=> type = value as String?,
                      items: cubit.typeModel!.data!.map<DropdownMenuItem<String>>((e) {
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
                        suffix: Icons.bathtub,
                        label: 'عدد الحمامات',
                        type: TextInputType.number,
                        validator: (value){
                          if(value.isEmpty){
                            return 'هذه الخانة فارغة';
                          }
                        }
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: roomsController,
                        suffix: Icons.meeting_room,
                        label: 'عدد الغرف',
                        type: TextInputType.number,
                        validator: (value){
                          if(value.isEmpty){
                            return 'هذه الخانة فارغة';
                          }
                        }
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      hint: Text('قسم فرعي'),
                      onChanged: (value)=> subsection = value as String?,
                      items: cubit.departmentModel!.data!.map<DropdownMenuItem<String>>((e) {
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
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      hint: Text('اختر المدينة'),
                      onChanged: (value)=> city = value as String?,
                      items: cubit.cityModel!.data!.map<DropdownMenuItem<String>>((e) {
                        cityId = e.id;
                        return DropdownMenuItem(
                          child: Text(    e.name!     +'   '),
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
                        validator: (value){
                          if(value.isEmpty){
                            return 'هذه الخانة فارغة';
                          }
                        }
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: priceController,
                        suffix: Icons.price_change,
                        label: 'سعر بيع المنتج او الخدمة',
                        type: TextInputType.number,
                        validator: (value){
                          if(value.isEmpty){
                            return 'هذه الخانة فارغة';
                          }
                        }
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: addressController,
                        suffix: Icons.title,
                        label: 'عنوان الاعلان',
                        type: TextInputType.text,
                        validator: (value){
                          if(value.isEmpty){
                            return 'هذه الخانة فارغة';
                          }
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10
                      ),
                      width: double.infinity,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return  'لا يجب ان تكون هذه الخانه فارغة';
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
                        cubit.selectImagesForUpdate();
                      },
                      text: 'ارفاق الصور',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (cubit.imageFileListForUpdate.isNotEmpty)
                      Container(
                        height: 220,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: GridView.builder(
                          itemCount: cubit.imageFileListForUpdate.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 4),
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children :[
                                  Image.file(
                                    File(cubit.imageFileListForUpdate[index].path),
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  IconButton(
                                      onPressed: (){
                                        cubit.imageFileListForUpdate.remove(cubit.imageFileListForUpdate[index]);
                                        cubit.justEmitState();
                                      }, icon: Icon(Icons.highlight_remove_rounded,color: Colors.red,)),
                                ]
                            );
                          },
                        ),
                      ),
                    TextButton(
                      onPressed: (){
                        cubit.agreeEdAnno();
                      },
                      child: Row(
                        children: [
                          Icon(
                            cubit.isAgreeEdAnno ? Icons.check_box :Icons.check_box_outline_blank_sharp,
                            color: cubit.isAgreeEdAnno ? Colors.red[900] : Colors.black,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'اوافق علي الاحكام الوشروط',
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    state is! UpdateAnnouncementsLoadingState ?
                    defaultButton(
                      function: (){
                        if(formKey.currentState!.validate()){
                          if(cubit.isAgreeEdAnno) {
                            cubit.updateAn(
                              announcementId: id!,
                              status: theStateController.text,
                              typeId: typeId.toString(),
                              bathroomsNum: bathroomsController.text,
                              roomsNum: roomsController.text,
                              deptId: subsectionId.toString(),
                              cityId: cityId.toString(),
                              distance: sizeController.text,
                              price: priceController.text,
                              address: addressController.text,
                              description: desController.text,
                            ).then((value) {
                              if(cubit.addAnnouncementsModel!.status!){
                                showToast(msg: 'تم التعديل بنجاح');
                                cubit.imageFileListForUpdate.clear();
                                cubit.myAnnouncements();
                                Navigator.pop(context);
                              }else {
                                showToast(msg:cubit.addAnnouncementsModel!.errors.toString(), toastState: false);
                              }
                            });
                          } else{
                            showToast(msg: 'وافق علي الشروط اولا' , toastState: true);
                          }
                        }
                      },
                      text: 'تعديل الاعلان',
                    ) : Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),

          ),
        );
      },
    );
  }

}

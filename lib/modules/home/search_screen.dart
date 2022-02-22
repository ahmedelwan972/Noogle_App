import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noogle/layout/cubit/cubit.dart';
import 'package:noogle/layout/cubit/states.dart';
import 'package:noogle/modules/home/search_result_screen.dart';
import 'package:noogle/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var bathroomsController = TextEditingController();
  var bedroomsController = TextEditingController();
  var lessSpaceController = TextEditingController();
  var moreSpaceController = TextEditingController();
  var lessPriceController = TextEditingController();
  var morePriceController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String? type;
  int? typeId;
  String? city;
  int? cityId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoogleCubit,NoogleStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = NoogleCubit.get(context);
        return Scaffold(
          appBar: appBar(text: 'البحث المتقدم'),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      'يمكنك الان البحث عن عقارك بافضل واسهل الاختيارات',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      controller: searchController,
                      label: 'اكتب ما تبحث عنه',
                      suffix: Icons.search,
                      type: TextInputType.text,
                      validator: (value){
                        if(value.isEmpty){
                          return 'لا يجب ان يكون خانت البحث فارغة';
                        }
                      }
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
                      hint: Text('  جميع المدن    '),
                      onChanged: (value)=> city = value as String?,
                      items: cubit.cityModel!.data!.map<DropdownMenuItem<String>>((e) {
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
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      hint: Text('النوع'),
                      onChanged: (value)=> type = value as String?,
                      items: cubit.typeModel!.data!.map<DropdownMenuItem<String>>((e) {
                        cityId = e.id!;
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
                      label: 'حمامات',
                      type: TextInputType.number,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      controller: bedroomsController,
                      label: 'غرف نوم',
                      type: TextInputType.number,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      controller: lessSpaceController,
                      label: 'اقل مساحة',
                      type: TextInputType.number,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      controller: moreSpaceController,
                      label: 'اكثر مساحة',
                      type: TextInputType.number,
                    ),
                    SizedBox(
                      height: 15 ,
                    ),
                    defaultFormField(
                      controller: lessPriceController,
                      label: 'اقل سعر',
                      type: TextInputType.number,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      controller: morePriceController,
                      label: 'اكثر سعر',
                      type: TextInputType.number,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    state is! SearchLoadingState ?
                    defaultButton(function: (){
                      if(formKey.currentState!.validate()){
                        cubit.search(
                          cityId: cityId.toString(),
                          typeId: typeId.toString(),
                          bathroomsNum: bathroomsController.text,
                          roomsNum: bedroomsController.text,
                          maxDistance: moreSpaceController.text,
                          minDistance: lessSpaceController.text,
                          maxPrice: morePriceController.text,
                          minPrice: lessPriceController.text,
                          search: searchController.text,
                        ).then((value) {
                          if(cubit.searchModel!.status!){
                            navigateTo(context, SearchResult());
                          } else {
                            showToast(msg: cubit.searchModel!.errors.toString(),toastState: true);
                          }
                        });
                      }
                    }, text: 'بحث'): Center(child: CircularProgressIndicator()),
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

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noogle/layout/cubit/cubit.dart';
import 'package:noogle/layout/cubit/states.dart';
import 'package:noogle/shared/components/components.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoogleCubit,NoogleStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = NoogleCubit.get(context);
        return Scaffold(
          appBar: appBar(
            text: 'الاعلانات المفضلة',
            leading: IconButton(
              onPressed: (){
                cubit.getFavoritesModel = null;
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
              ),),
          ),
          body: ConditionalBuilder(
            condition: cubit.getFavoritesModel != null ,
            builder: (context) => cubit.getFavoritesModel!.data!.isNotEmpty?ListView.separated(
              itemBuilder: (context,index) => buildListItems( cubit.getFavoritesModel!.data![index], context ,state,isFa: true),
              separatorBuilder: (context,index) => SizedBox(
                height: 10,),
              itemCount: cubit.getFavoritesModel!.data!.length,
            ):Center(child: Text('لا يوجد اعلانات مفضلة')),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}

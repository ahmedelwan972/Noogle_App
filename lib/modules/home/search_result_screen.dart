import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noogle/layout/cubit/cubit.dart';
import 'package:noogle/layout/cubit/states.dart';
import 'package:noogle/models/home_models/search_model.dart';
import 'package:noogle/modules/user/auth/sgin_in_screen.dart';
import 'package:noogle/shared/components/components.dart';
import 'package:noogle/shared/components/constants.dart';
import 'package:noogle/shared/styles/colors.dart';

import '../show_announcemnet_screen.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoogleCubit,NoogleStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = NoogleCubit.get(context);
          return Scaffold(
            appBar: appBar(text: cubit.searchModel!.data!.announcements!.length.toString()+' نتائج البحث'    ),
            body: ConditionalBuilder(
              condition: state is! SearchLoadingState &&cubit.searchModel!.data != null ,
              builder: (context) => ListView.separated(
                itemBuilder: (context,index) => buildListItems(cubit.searchModel!.data!.announcements![index],context,state),
                separatorBuilder: (context,index) => SizedBox(height: 15,),
                itemCount: cubit.searchModel!.data!.announcements!.length,
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
    );
  }


}

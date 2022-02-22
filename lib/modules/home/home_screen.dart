import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noogle/layout/cubit/cubit.dart';
import 'package:noogle/layout/cubit/states.dart';
import 'package:noogle/modules/home/search_screen.dart';
import 'package:noogle/shared/components/components.dart';
import 'package:noogle/shared/components/constants.dart';
import 'package:noogle/shared/styles/colors.dart';

class HomeScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoogleCubit,NoogleStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = NoogleCubit.get(context);
        return RefreshIndicator(
          onRefresh: () =>refresh(context),
          child: SingleChildScrollView(
            controller: cubit.scrollController,
            child: result != null ? result! ? ConditionalBuilder(
              builder:(context) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Image(
                        image: AssetImage(
                          'assets/images/home_bg@2x.png'
                        ),
                        height:140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.infinity,
                        height: 140,
                        color: Colors.black12.withOpacity(0.3),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.all(Radius.circular(7))
                          ),
                          width: double.infinity,
                          height: 80,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7),),
                            color: Colors.white,
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: double.infinity,
                          height: 40,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: (){
                                  navigateTo(context, SearchScreen());
                                },
                                child: Container (
                                  alignment: AlignmentDirectional.center,
                                  width: 120,
                                  height: 40,
                                  color: defaultColor,
                                  child: Text(
                                    'البحث المتقدم',
                                    style: TextStyle(
                                        color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: searchController,
                                  textAlign: TextAlign.end,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  onChanged: (value){
                                    if(value.isNotEmpty)
                                    cubit.fastSearch(value);
                                    if(value.isEmpty)
                                      searchController.text = '';
                                    cubit.justEmitState();
                                  },
                                  decoration: InputDecoration(
                                    hintText: '       بحث',
                                    border: InputBorder.none,
                                    suffixIcon: Icon(
                                      Icons.search,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  searchController.text.isEmpty ?
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index) => buildListItems(cubit.homeModel!.data!.announcements![index],context,state),
                    separatorBuilder: (context,index) => SizedBox(
                      height: 10,),
                    itemCount: cubit.homeModel!.data!.announcements!.length,
                  ):ConditionalBuilder(
                    builder:(context) => ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index) => buildListItems(cubit.fastSearchModel!.data!.announcements![index],context,state),
                      separatorBuilder: (context,index) => SizedBox(
                        height: 10,),
                      itemCount: cubit.fastSearchModel!.data!.announcements!.length,
                    ),
                    condition: cubit.fastSearchModel != null && state is! FastSearchLoadingState&&cubit.fastSearchModel!.data!.announcements!.length > 0,
                    fallback: (context) => Center(child: Text('لا يوجد نتايج بحث')),
                  ),
                  if(cubit.homeModel!.data!.hasMore!&& state is! FastSearchSuccessState)Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                ],
              ),
              condition: state is! HomeLoadingState && state is! GetCityLoadingState && state is! GetTypeLoadingState&& cubit.homeModel != null,
              fallback: (context) =>Padding(
                padding: const EdgeInsets.only(top: 250),
                child: Center(child: CircularProgressIndicator()),
              ),
            )
                : Center(
              child: Text(
                'لا يوجد اتصال بالانتر نت',
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            )
                : Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }


}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noogle/layout/cubit/cubit.dart';
import 'package:noogle/layout/cubit/states.dart';
import 'package:noogle/shared/components/components.dart';

class NoogleLayout extends StatelessWidget {
  const NoogleLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoogleCubit,NoogleStates>(
      listener: (context,state){
        checkNet(context);
      },
      builder: (context,state){
        var cubit = NoogleCubit.get(context);
        return Scaffold(
          appBar: appBar(text: cubit.titles[cubit.currentIndex]),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            onTap: (index){
              cubit.changeIndex(index);
              if(cubit.currentIndex == 0) {
                cubit.currentPage = 1;
                cubit.homeUser();
              }
              },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.home,
                  ),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.person,
                  ),
                label: 'الشخصية',

              ),
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.add_circle,
                  ),
                label: 'اضافة اعلان',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.menu,
                  ),
                label: 'القائمة',
              ),
            ],
          ),
        );
      },
    );
  }

}

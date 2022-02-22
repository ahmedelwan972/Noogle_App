import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noogle/shared/bloc_observer.dart';
import 'package:noogle/shared/components/constants.dart';
import 'package:noogle/shared/network/local/cache_helper.dart';
import 'package:noogle/shared/styles/colors.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'layout/noogle_layout.dart';
import 'shared/network/remote/dio.dart';

void main() async{
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init1();
  token = CacheHelper.getData(key: 'myId');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NoogleCubit()..checkInterNet()..homeUser()..getCity()..getType()..getDep()..getMoreForHome()..getMoreForAnnouncement(),
      child: BlocConsumer<NoogleCubit,NoogleStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.teal,
              fontFamily: 'Cairo',
            ),
            home: NoogleLayout(),
          );
        },
      ),
    );
  }
}


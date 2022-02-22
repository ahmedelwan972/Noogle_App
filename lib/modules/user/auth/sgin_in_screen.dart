import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noogle/layout/cubit/cubit.dart';
import 'package:noogle/layout/cubit/states.dart';
import 'package:noogle/modules/user/auth/sgin_up_screen.dart';
import 'package:noogle/shared/components/components.dart';
import 'package:noogle/shared/components/constants.dart';
import 'package:noogle/shared/network/local/cache_helper.dart';
import 'package:noogle/shared/styles/colors.dart';

class SignInScreen extends StatelessWidget {
  var userController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoogleCubit,NoogleStates>(
      listener: (context,state){
        var cubit = NoogleCubit.get(context);
        if(state is SignInSuccessState){
          if(cubit.signInModel!.status!){
            CacheHelper.saveData(key: 'myId', value: cubit.signInModel!.data!.token).then((value)
            {
              token = cubit.signInModel!.data!.token!;
              cubit.homeUser();
              showToast(msg: 'تم التسجيل بنجاح');
              Navigator.pop(context);
              cubit.justEmitState();
            }).catchError((e){
              print(e.toString());
            });
          }else{
            showToast(msg: cubit.signInModel!.errors.toString(),toastState: true);
          }
        }
      },
      builder: (context,state){
        var cubit = NoogleCubit.get(context);
        return Scaffold(
          appBar: appBar(
            text: 'تسجيل الدخول',
            leading: IconButton(
              onPressed: (){Navigator.pop(context);
              userController.text =      '';
              passwordController.text =  '';
              },
              icon: Icon(
                  Icons.arrow_back
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Image(
                      image:AssetImage(
                          'assets/images/signin_bg@2x.png'
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    defaultFormField(
                      controller: userController,
                      type: TextInputType.emailAddress,
                      suffix: Icons.person,
                      label:'الاسم او الريد الالكتروني' ,
                      validator: (value){
                        if(value.isEmpty){
                          return 'الاسم او البريد الالكتروني غير مدخل' ;
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      label:'كلمة المرور' ,
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      isPassword: cubit.isPasswordIn,
                      suffix: cubit.isPasswordIn?Icons.visibility_outlined: Icons.visibility_off  ,
                      suffixPressed: ()
                      {
                        cubit.changeVisiIn();
                      },
                      validator: (value){
                        if(value.isEmpty){
                          return 'كلمة المرور غير مدخلة' ;
                        }
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    state is! SignInLoadingState
                    ? defaultButton(
                      function: (){
                        if(formKey.currentState!.validate()){
                          cubit.signIn(userName: userController.text, password: passwordController.text);
                        }
                      },
                      text: 'تسجيل الدخول',
                    ):Center(child: CircularProgressIndicator()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: (){
                            navigateTo(context, SginUpScreen());
                            userController.text = '';
                            passwordController.text = '';
                          },
                          child: Text(
                              'انشاء حساب جديد',
                          ),
                        ),
                        Text(
                            'ليس لديك حساب؟'
                        ),
                      ],
                    ),
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

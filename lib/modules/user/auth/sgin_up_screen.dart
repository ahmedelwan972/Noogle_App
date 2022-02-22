import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noogle/layout/cubit/cubit.dart';
import 'package:noogle/layout/cubit/states.dart';
import 'package:noogle/modules/user/auth/sgin_in_screen.dart';
import 'package:noogle/shared/components/components.dart';
import 'package:noogle/shared/components/constants.dart';
import 'package:noogle/shared/network/local/cache_helper.dart';
import 'package:noogle/shared/styles/colors.dart';

class SginUpScreen extends StatelessWidget {
  var userController = TextEditingController();
  var emailController = TextEditingController();
  var nController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var password2Controller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoogleCubit,NoogleStates>(
      listener: (context,state){
        var cubit = NoogleCubit.get(context);
        if(state is SignUpSuccessState){
          if(cubit.signInModel!.status!){
            CacheHelper.saveData(key: 'myId', value: cubit.signInModel!.data!.token).then((value)
            {
              token = cubit.signInModel!.data!.token!;
              showToast(msg: 'تم الانشاء بنجاح');
              Navigator.pop(context);
              cubit.justEmitState();
            }).catchError((e){
              print(e.toString());
            });
          }else{
            showToast(msg: cubit.signInModel!.errors.toString(),toastState: false);
          }
        }
      },
      builder: (context,state){
        var cubit = NoogleCubit.get(context);
        return Scaffold(
          appBar: appBar(
            text: 'انشاء حساب جديد',
            leading: IconButton(
                onPressed: (){Navigator.pop(context);
                userController.text =      '';
                emailController.text =     '';
                nController.text =         '';
                phoneController.text =     '';
                passwordController.text =  '';
                password2Controller.text = '';
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
                    Image(
                      image:AssetImage(
                          'assets/images/signup_bg@2x.png'
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      suffix: Icons.person,
                      controller: userController,
                      type: TextInputType.text,
                      label:'الاسم ' ,
                      validator: (value){
                        if(value.isEmpty){
                          return 'الاسم غير مدخل' ;
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      controller: emailController,
                      suffix: Icons.email,
                      type: TextInputType.emailAddress,
                      label:'البريد الالكتروني' ,
                      validator: (value){
                        if(value.isEmpty){
                          return 'البريد الالكتروني غير مدخل' ;
                        }else if(!value.contains('@')&& !value.contains('.')){
                          return 'البريد الالكتروني مدخل بشكل غير صحيح' ;

                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      controller: nController,
                      suffix: Icons.stars,
                      type: TextInputType.text,
                      label:'نوع الحساب' ,
                      validator: (value){
                        if(value.isEmpty){
                          return 'نوع الحساب غير مدخل' ;
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      suffix: Icons.phone,
                      type: TextInputType.phone,
                      label:'رقم الهاتف 10 ارقام و يبدأ  056 ' ,
                      validator: (value){
                        if(value.isEmpty){
                          return 'الهاتف غير مدخل' ;
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
                      isPassword: cubit.isPasswordUp,
                      suffix: cubit.isPasswordUp? Icons.visibility : Icons.visibility_off,
                      suffixPressed: ()
                      {
                        cubit.changeVisiUp();
                      },
                      validator: (value){
                        if(value.isEmpty){
                          return 'كلمة المرور غير مدخلة' ;
                        }else if (value.length <8){
                          return 'كلمة السر ضعيفة' ;
                        }else if(value != password2Controller.text){
                          return 'كلمة السر غير متطابقة' ;
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      label:'كلمة المرور' ,
                      controller: password2Controller,
                      type: TextInputType.visiblePassword,
                      isPassword: cubit.isPasswordUp2,
                      suffix: cubit.isPasswordUp2? Icons.visibility : Icons.visibility_off,
                      suffixPressed: ()
                      {
                        cubit.changeVisiUp2();
                      },
                      validator: (value){
                        if(value.isEmpty){
                          return 'كلمة المرور غير مدخلة' ;
                        }else if (value.length <8){
                          return 'كلمة السر ضعيفة' ;
                        }else if(value != passwordController.text){
                          return 'كلمة السر غير متطابقة' ;
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        onPressed: (){
                          cubit.agreeUp();
                        },
                        child: Row(
                          children: [
                            Icon(
                              cubit.isAgreeUp ? Icons.check_box :Icons.check_box_outline_blank_sharp,
                              color: cubit.isAgreeUp ? defaultColor : Colors.black,
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
                      height: 15,
                    ),
                    state is! SignUpLoadingState ?
                    defaultButton(
                      function: (){

                        if(formKey.currentState!.validate()){
                          if(cubit.isAgreeUp){
                          cubit.signUp(
                            userName: userController.text,
                            email: emailController.text,
                            account: nController.text,
                            phone: phoneController.text,
                            password: passwordController.text,
                            cPassword: password2Controller.text,
                          );
                          }else{
                            showToast(msg: 'يجب ان توافق علي الشروط والاحكام اولا');
                          }
                        }

                      },
                      text: 'تسجيل الدخول',
                    ) : Center(child: CircularProgressIndicator()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: (){
                            navigateTo(context, SignInScreen());
                            userController.text =      '';
                            emailController.text =     '';
                            nController.text =         '';
                            phoneController.text =     '';
                            passwordController.text =  '';
                            password2Controller.text = '';
                          },
                          child: Text(
                            'سجل دخول الان',
                          ),
                        ),
                        Text(
                            'لديك حساب بالفعل؟؟'
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

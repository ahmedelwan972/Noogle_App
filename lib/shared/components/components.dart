import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noogle/layout/cubit/cubit.dart';
import 'package:noogle/modules/show_announcemnet_screen.dart';
import 'package:noogle/modules/user/auth/sgin_in_screen.dart';
import 'package:noogle/shared/styles/colors.dart';

import 'constants.dart';

Widget defaultButton({
  double width = double.infinity,
  bool isUpperCase = true,
  double radius = 5.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          function();
        },
      ),
      decoration: BoxDecoration(
        color: defaultColor,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

Widget defaultFormField({
  String? text,
  required TextEditingController controller,
  bool isPassword = false,
  FormFieldValidator? validator,
  TextInputType? type,
  String? label,
  bool enabled = true,
  Function? suffixPressed,
  IconData? suffix,
  IconData? prefix,
}) =>
    TextFormField(
      obscureText: isPassword,
      enabled: enabled,
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        isDense: true,
        hintText: text,
        labelText: label,
        prefix: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  {
                    if (suffixPressed != null) suffixPressed();
                  }
                },
                icon: Icon(suffix),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      validator: validator,
    );

Future<bool?> showToast({required String msg, bool? toastState}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: toastState != null
            ? toastState
                ? Colors.yellow[900]
                : Colors.red
            : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);

Future<void> refresh(context) {
  return Future.delayed(
    Duration(seconds: 1),
  ).then((value) {
    NoogleCubit.get(context).currentPage = 1;
    NoogleCubit.get(context).homeUser();
  }); //
}

Future<void> refresh2(context) {
  return Future.delayed(
    Duration(seconds: 1),
  ).then((value) {
    NoogleCubit.get(context).currentPageForAnnouncements = 1;
    NoogleCubit.get(context).myAnnouncements();
  }); //
}

checkNet(context) {
  if (!result!) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('No internet connection'),
        content: Container(
          height: 60,
          width: 80,
          color: defaultColor,
          child: TextButton(
            onPressed: () {
              NoogleCubit.get(context).justEmitState();
              Navigator.pop(context);
            },
            child: Text(
              'Click to retry',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

appBar({
  required String text,
  IconButton? leading,
}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: defaultColor,
    leading: leading,
    elevation: 0,
    title: Text(
      text,
      style: TextStyle(color: Colors.white),
    ),
  );
}

Widget elevetion({double? size}) => Container(
      height: size!,
      width: double.infinity,
      alignment: AlignmentDirectional.bottomEnd,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 3,
            color: defaultColorTwo.withOpacity(0.05),
          ),
          Container(
            width: double.infinity,
            height: 3,
            color: defaultColorTwo.withOpacity(0.1),
          ),
          Container(
            width: double.infinity,
            height: 3,
            color: defaultColorTwo.withOpacity(0.15),
          ),
          Container(
            width: double.infinity,
            height: 3,
            color: defaultColorTwo.withOpacity(0.2),
          ),
          Container(
            width: double.infinity,
            height: 3,
            color: defaultColorTwo.withOpacity(0.25),
          ),
          Container(
            width: double.infinity,
            height: 3,
            color: defaultColorTwo.withOpacity(0.3),
          ),
          Container(
            width: double.infinity,
            height: 3,
            color: defaultColorTwo.withOpacity(0.35),
          ),
          Container(
            width: double.infinity,
            height: 3,
            color: defaultColorTwo.withOpacity(0.4),
          ),
          Container(
            width: double.infinity,
            height: 3,
            color: defaultColorTwo.withOpacity(0.45),
          ),
          Container(
            width: double.infinity,
            height: 3,
            color: defaultColorTwo.withOpacity(0.5),
          ),
          Container(
            width: double.infinity,
            height: 3,
            color: defaultColorTwo.withOpacity(0.55),
          ),
          Container(
            width: double.infinity,
            height: 5,
            color: defaultColorTwo.withOpacity(0.6),
          ),
          Container(
            width: double.infinity,
            height: 5,
            color: defaultColorTwo.withOpacity(0.7),
          ),
          Container(
            width: double.infinity,
            height: 5,
            color: defaultColorTwo.withOpacity(0.8),
          ),
          Container(
            width: double.infinity,
            height: 5,
            color: defaultColorTwo.withOpacity(0.9),
          ),
          Container(
            width: double.infinity,
            height: 5,
            color: defaultColorTwo,
          ),
        ],
      ),
    );

buildListItems(model, context, state , {bool isFa = false}) {
  var cubit = NoogleCubit.get(context);
  return InkWell(
    onTap: () {
      cubit.showAnnouncements(id: model.id!);
      navigateTo(context, ShowAnnouncement());
    },
    child: Card(
      elevation: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              Image(
                image: NetworkImage(
                  '${model.mainImage}',
                ),
                height: 170,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) =>
                    Center(child: CircularProgressIndicator()),
              ),
              if (model.isSpecial!)
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    width: 120,
                    height: 40,
                    color: defaultColor,
                    child: Text(
                      'عرض مميز',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              elevetion(size: 170),
              Container(
                height: 170,
                width: double.infinity,
                alignment: AlignmentDirectional.bottomEnd,
                padding: EdgeInsetsDirectional.all(15),
                child: Text(
                  model.name!,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              model.description!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                !isFa ? IconButton(
                        onPressed: () {
                          if (token != null) {
                            cubit.addFavorites(annoId: model.id!);
                          } else {
                            navigateTo(context, SignInScreen());
                          }
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: token != null
                              ? cubit.favorites[model.id]!
                                  ? Colors.red
                                  : Colors.grey[600]
                              : Colors.grey,
                        ),
                      )
                    : TextButton(
                  onPressed : (){
                    cubit.addFavorites(annoId: model.id!);
                    cubit.getFavorites();
                    showToast(msg: 'تم الالغاء من المفضلة');
                  },
                  child:  Row(
                    children: [
                      Text(
                        'الغاء من القائمة المفضلة',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Icon(
                        Icons.favorite,
                        color: cubit.favorites[model.id]! ? Colors.red : Colors.grey,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  'ريال',
                  style: TextStyle(color: defaultColor),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  model.price!,
                  style: TextStyle(color: defaultColor),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            height: 70,
            child: Card(
              child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          model.createdAt!,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.watch_later_outlined,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          model.typeName!,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.local_offer,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(model.cityName!),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.location_on,
                        size: 30,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}




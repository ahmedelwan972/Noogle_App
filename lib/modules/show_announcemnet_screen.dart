import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noogle/layout/cubit/cubit.dart';
import 'package:noogle/layout/cubit/states.dart';
import 'package:noogle/models/announcement_modes/show_announcement_model.dart';
import 'package:noogle/modules/user/auth/sgin_in_screen.dart';
import 'package:noogle/modules/user/user_screen.dart';
import 'package:noogle/shared/components/components.dart';
import 'package:noogle/shared/components/constants.dart';
import 'package:noogle/shared/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowAnnouncement extends StatelessWidget {
  var desController = TextEditingController();
  var commentController = TextEditingController();
  var replayController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoogleCubit, NoogleStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoogleCubit.get(context);
        return Scaffold(
          appBar: appBar(
            text: 'اعلان',
            leading: IconButton(
              onPressed: () {
                cubit.showAnnouncementModel = null;
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: ConditionalBuilder(
            condition: cubit.showAnnouncementModel != null && state is! MyAnnouncementsLoadingState,
            builder: (context) => buildShowAnnouncement(
                context, cubit.showAnnouncementModel!.data!, state),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  buildShowAnnouncement(context, ShowAnnouncementData model, state) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            model.sliders!.length == 1
                ? Image(
                    image: NetworkImage(
                      model.sliders![0].image!,
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
                  )
                : CarouselSlider(
                    items: model.sliders!
                        .map(
                          (e) => Image(
                            image: NetworkImage(
                              e.image!,
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
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      height: 300,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(seconds: 3),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                      viewportFraction: 1,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${model.address}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    model.description!,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (token != null) {
                            NoogleCubit.get(context)
                                .addFavorites(annoId: model.id!);
                          } else {
                            navigateTo(context, SignInScreen());
                          }
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: token != null
                              ? NoogleCubit.get(context).favorites[model.id]!
                                  ? Colors.red
                                  : Colors.grey[600]
                              : Colors.grey,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'ريال',
                        style: TextStyle(
                            color: defaultColor
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        model.price!,
                        style: TextStyle(
                            color: defaultColor
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
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
                              Text(
                                model.cityName!,
                              ),
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
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: Container(
                                    alignment: AlignmentDirectional.center,
                                    height: 60,
                                    width: 80,
                                    child: Text(model.userName!),
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('اسم صاحب الاعلان',style: TextStyle(color: Colors.black),),
                                SizedBox(
                                  width: 12,
                                ),
                                Icon(
                                  Icons.person_pin,
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 7,
                        ),
                        TextButton(
                            onPressed: () {
                              openDialog(context, model);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('رقم الهاتف',style: TextStyle(color: Colors.black),),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.phone,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: model.comments!.isNotEmpty
                        ? Column(mainAxisSize: MainAxisSize.min, children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(' من التعليقات علي الاعلان',),
                                SizedBox(
                                  width: 25,
                                ),
                                Text(model.comments!.length.toString(),),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => buildCommentItem(
                                  model.comments![index], state, context),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                              itemCount: model.comments!.length,
                            ),
                          ])
                        : Center(
                          child: Text(
                              'لا يوجد تعليقات',
                    ),
                        ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'لا يجب ان تكون هذه الخانه فارغة';
                        }
                      },
                      keyboardType: TextInputType.text,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: 'اكتب تعليق',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      controller: desController,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  state is! CommentLoadingState ?
                  defaultButton(
                    function: () {
                      if (token != null) {
                        if (formKey.currentState!.validate()) {
                          NoogleCubit.get(context)
                              .addComment(
                            comment: desController.text,
                          )
                              .then((value) {
                            desController.text = '';
                            NoogleCubit.get(context)
                                .showAnnouncements(id: model.id!);
                          });
                        }
                      } else {
                        showToast(
                            msg: 'يجب ان تسجل دخول اولا', toastState: true);
                        navigateTo(context, SignInScreen());
                      }
                    },
                    text: 'ارسال التعليق',
                  ) : Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildCommentItem(Comments comments, state, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            comments.commentUserName!,
            style: TextStyle(fontSize: 18 , color: defaultColor),
          ),
          SizedBox(
            height: 10,
          ),
          Text(comments.comment!),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  NoogleCubit.get(context).choseComment(id: comments.commentId!);
                },
                child: Row(
                  children: [
                    Text('رد علي التعليق       '),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.chat_bubble,color: Colors.black,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text('  '  +comments.commentCreatedAt!),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.watch_later_outlined,
              ),
            ],
          ),
          if (NoogleCubit.get(context).chooseComment[comments.commentId!]!)
            Column(
              children: [
                defaultFormField(
                    controller: commentController, label: 'رد علي التعليق'),
                SizedBox(
                  height: 5,
                ),
                state is! CommentLoadingState
                    ? defaultButton(
                        function: () {
                          if (token != null) {
                            NoogleCubit.get(context)
                                .addReplay(
                                    reply: commentController.text,
                                    commentId: comments.commentId!)
                                .then((value) {
                              commentController.text = '';
                              NoogleCubit.get(context).showAnnouncements(
                                  id: NoogleCubit.get(context)
                                      .showAnnouncementModel!
                                      .data!
                                      .id!);
                            });
                          } else {
                            showToast(
                                msg: 'يجب ان تسجل دخول اولا', toastState: true);
                            navigateTo(context, SignInScreen());
                          }
                        },
                        text: 'رد')
                    : Center(child: CircularProgressIndicator()),
              ],
            ),
          SizedBox(
            height: 10,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildReplayItem(
                comments.replies![index], state, context, comments),
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            itemCount: comments.replies!.length,
          )
        ],
      ),
    );
  }

  buildReplayItem(Replies replies, state, context, Comments comments) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                replies.replyUserName!,
                style: TextStyle(fontSize: 18,color: defaultColor),
              ),
              SizedBox(
                height: 10,
              ),
              Text(replies.reply!),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      NoogleCubit.get(context).chooseReplay(id: replies.replyId!);
                    },
                    child: Row(
                      children: [
                        Text('رد علي التعليق     '),
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.chat_bubble,color:Colors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('   ' +replies.replyCreatedAt!),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.watch_later_outlined,
                  ),
                ],
              ),
              if (NoogleCubit.get(context).replayComment[replies.replyId]!)
                Column(
                  children: [
                    defaultFormField(
                        controller: replayController, label: 'رد علي التعليق'),
                    SizedBox(
                      height: 5,
                    ),
                    state is! ReplayLoadingState
                        ? defaultButton(
                            function: () {
                              if (token != null) {
                                NoogleCubit.get(context)
                                    .addReplay(
                                  commentId: comments.commentId!,
                                  reply: replayController.text,
                                )
                                    .then((value) {
                                  replayController.text = '';
                                  NoogleCubit.get(context).showAnnouncements(
                                      id: NoogleCubit.get(context)
                                          .showAnnouncementModel!
                                          .data!
                                          .id!);
                                });
                              } else {
                                showToast(
                                    msg: 'يجب ان تسجل دخول اولا',
                                    toastState: true);
                                navigateTo(context, SignInScreen());
                              }
                            },
                            text: 'رد')
                        : Center(child: CircularProgressIndicator()),
                  ],
                ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future openDialog(context, ShowAnnouncementData mobiles) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('اتصال'),
          content: Container(
            height: 60,
            width: 100,
            child: TextButton(
              onPressed: ()async{
                String phoneNumber = 'tel:${int.parse(mobiles.userPhone!)}';
                final Uri launchUri = Uri(
                    scheme: 'tel',
                    path:mobiles.userPhone.toString(),
                );
                if(await canLaunch(launchUri.toString())){
                  await launch(launchUri.toString());
                }else{
                  print('we have error' + launchUri.toString());
                }
              },
              child: Text(
                mobiles.userPhone!,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      );
}

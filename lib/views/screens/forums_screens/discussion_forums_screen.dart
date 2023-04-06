import 'dart:math';

import 'package:flutter/material.dart';
import 'package:la_vie/provider/all_forums_provider.dart';
import 'package:la_vie/provider/forums.dart';
import 'package:la_vie/provider/my_forums_provider.dart';
import 'package:la_vie/utils/color.dart';
import 'package:la_vie/utils/constants.dart';
import 'package:la_vie/utils/my_icons_icons.dart';
import 'package:la_vie/utils/screen.dart';
import 'package:la_vie/views/components/forums.dart';
import 'package:la_vie/views/screens/forums_screens/craete_post_screen.dart';
import 'package:la_vie/views/screens/forums_screens/forum_image.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text.dart';

List commentUserName = [
  'Ahmed Mohamed',
  'Emad Khaled',
  'Amr Mohamed',
  'Nadia Ali',
  'Salma Khaled',
  'Karim Mohamed',
  'Mostafa Gamal',
  'Somaia Mohamed',
  'Mahmoud Sobhy',
  'Sara Adham',
  'Ahmed Abdelghany',
  'Omar Mahmoud',
  'Marwan Hesham',
  'Samia Ali',
  'Fatma Ahmed',
  'Rami Hassan',
  'Sayed Sameh',
  'Amira Mahmoud',
  'Yasmeen Ali',
  'Mostafa Rady',
  'Abdelrahman Sami'
];

class DiscussionForumsScreen extends StatelessWidget {
  const DiscussionForumsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Screen(context);
    final providerAll = Provider.of<AllForumsProvider>(context).allForums;
    final providerMy = Provider.of<MyForumsProvider>(context).myForums;
    dynamic provider = Provider.of<AllForumsProvider>(context).allForums;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: Screen.screenWidth / (428 / 24),
              right: Screen.screenWidth / (428 / 24),
              top: Screen.screenHeight / (926 / 50)),
          child: Column(
            children: [
              customText(
                text: "Discussion Forums",
                fontWeight: FontWeight.w700,
                fontSize: 21,
              ),
              Padding(
                padding: EdgeInsets.only(top: Screen.screenHeight / (926 / 30)),
                child: Material(
                  elevation: 0.5,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: const Align(
                      alignment: Alignment.center,
                      child: TextField(
                        decoration: InputDecoration(
                            icon:
                                Icon(Icons.search, color: AppColors.customGrey),
                            hintText: 'Search',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: Screen.screenHeight / (926 / 15),
                      bottom: Screen.screenHeight / (926 / 10)),
                  child: forumsType(type: "all", context: context)),
              Expanded(
                child: (Provider.of<ForumsType>(context, listen: false)
                                    .pageSelected ==
                                "all" &&
                            providerAll.isEmpty) ||
                        (Provider.of<ForumsType>(context, listen: false)
                                    .pageSelected !=
                                "all" &&
                            providerMy.isEmpty)
                    ? Center(
                        child: customText(
                            text: "No Posts Founded",
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            textAlign: TextAlign.center))
                    : ListView.builder(
                        itemCount:
                            Provider.of<ForumsType>(context).pageSelected ==
                                    "all"
                                ? providerAll.length
                                : providerMy.length,
                        itemBuilder: (context, index) {
                          Provider.of<ForumsType>(context).pageSelected == "all"
                              ? provider = providerAll
                              : provider = providerMy;
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: Screen.screenHeight / (926 / 20)),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.4, color: AppColors.primary)),
                              child: SizedBox(
                                width: Screen.screenWidth / (428 / 380),
                                height: Screen.screenHeight / (926 / 420),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height:
                                            Screen.screenHeight / (926 / 300),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.2,
                                                color: AppColors.customGrey)),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: Screen.screenHeight /
                                                        (926 / 15),
                                                    left: Screen.screenWidth /
                                                        (428 / 14)),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                        radius: 25,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                provider[index]
                                                                    .user!
                                                                    .imageUrl!)),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: Screen
                                                                  .screenWidth /
                                                              (428 / 12)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          customText(
                                                              text:
                                                                  "${provider[index].user!.firstName!} ${provider[index].user!.lastName!}",
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                          SizedBox(
                                                              height: Screen
                                                                      .screenHeight /
                                                                  (926 / 8)),
                                                          customText(
                                                              text:
                                                                  "a month ago",
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: AppColors
                                                                  .customGrey)
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: Screen.screenHeight /
                                                        (926 / 10),
                                                    left: Screen.screenWidth /
                                                        (428 / 8)),
                                                child: SizedBox(
                                                  height: Screen.screenHeight /
                                                      (926 / 70),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      customText(
                                                          text: provider[index]
                                                              .title!,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: AppColors
                                                              .primary),
                                                      SizedBox(
                                                          height: Screen
                                                                  .screenHeight /
                                                              (926 / 3)),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: customText(
                                                            text: provider[
                                                                    index]
                                                                .description!,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .customGrey),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  child: provider[index]
                                                              .imageUrl !=
                                                          null
                                                      ? InkWell(
                                                          child: Image.network(
                                                            url +
                                                                provider[index]
                                                                    .imageUrl,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        ForumImage(
                                                                            image:
                                                                                url + provider[index].imageUrl)));
                                                          },
                                                        )
                                                      : Image.asset(
                                                          "assets/images/post.png",
                                                          fit: BoxFit.cover,
                                                        ))
                                            ]),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              Screen.screenHeight / (926 / 12)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Screen.screenWidth /
                                                (428 / 15)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              LikeButton(
                                                circleColor: CircleColor(
                                                  start: Colors.blue[900]!,
                                                  end: Colors.blue[900]!,
                                                ),
                                                bubblesColor: BubblesColor(
                                                  dotPrimaryColor:
                                                      Colors.blue[900]!,
                                                  dotSecondaryColor:
                                                      Colors.blue[900]!,
                                                ),
                                                likeBuilder: (bool isLiked) {
                                                  return Icon(
                                                    MyIcons.like,
                                                    color: isLiked
                                                        ? Colors.blue[900]
                                                        : Colors.grey,
                                                  );
                                                },
                                                likeCount: provider[index]
                                                    .forumLikes!
                                                    .length,
                                                countBuilder: (int? count,
                                                    bool isLiked, String text) {
                                                  var color = isLiked
                                                      ? Colors.blue[900]
                                                      : Colors.grey;
                                                  Widget result;
                                                  if (count == 0) {
                                                    result = Text(
                                                      "0",
                                                      style: TextStyle(
                                                          color: color),
                                                    );
                                                  } else {
                                                    result = Text(
                                                      text,
                                                      style: TextStyle(
                                                          color: color),
                                                    );
                                                  }
                                                  return result;
                                                },
                                              ),
                                              SizedBox(
                                                  width: Screen.screenWidth /
                                                      (428 / 3)),
                                              customText(
                                                  text: "Likes",
                                                  color: AppColors.customGrey),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: Screen.screenWidth /
                                                        (428 / 40)),
                                                child: InkWell(
                                                  child: customText(
                                                      text:
                                                          "${provider[index].forumComments!.length} Replies",
                                                      color:
                                                          AppColors.customGrey,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                        context: context,
                                                        isScrollControlled:
                                                            true,
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.vertical(
                                                                    top: Radius
                                                                        .circular(
                                                                            20))),
                                                        builder: (context) {
                                                          return SizedBox(
                                                            height: Screen
                                                                    .screenHeight /
                                                                1 /
                                                                1.5,
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 10),
                                                                  child: Center(
                                                                      child: customText(
                                                                          text:
                                                                              "Replies",
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ),
                                                                const Divider(
                                                                    thickness:
                                                                        1),
                                                                Expanded(
                                                                  child: ListView
                                                                      .builder(
                                                                          itemCount: provider[index]
                                                                              .forumComments
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, index2) {
                                                                            return Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                children: [
                                                                                  CircleAvatar(radius: 25, backgroundImage: NetworkImage(provider[index].user!.imageUrl!)),
                                                                                  Expanded(
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.symmetric(horizontal: Screen.screenWidth / (428 / 8)),
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(color: const Color.fromARGB(255, 240, 239, 239), borderRadius: BorderRadius.circular(12)),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsets.symmetric(horizontal: Screen.screenWidth / (428 / 12), vertical: 5),
                                                                                          child: Column(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              customText(text: "${commentUserName[Random().nextInt(commentUserName.length)]}", fontSize: 13, fontWeight: FontWeight.w700),
                                                                                              SizedBox(height: Screen.screenHeight / (926 / 8)),
                                                                                              customText(text: provider[index].forumComments[index2].comment, fontSize: 11, fontWeight: FontWeight.w500)
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    const Expanded(
                                                                      flex: 6,
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                5),
                                                                        child:
                                                                            TextField(
                                                                          decoration: InputDecoration(
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(width: 0.5, color: AppColors.primary),
                                                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                                              ),
                                                                              hintText: 'Comment...',
                                                                              border: InputBorder.none),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(right: 8.0),
                                                                        child:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () {},
                                                                          icon: const Icon(
                                                                              Icons.send_rounded,
                                                                              color: AppColors.primary,
                                                                              size: 30),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    width: 2),
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreatePostScreen()));
        },
        child: const Icon(Icons.add),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}

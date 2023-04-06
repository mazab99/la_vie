import 'package:flutter/material.dart';
import 'package:la_vie/provider/blog_provider.dart';
import 'package:la_vie/utils/color.dart';
import 'package:la_vie/utils/constants.dart';
import 'package:la_vie/utils/screen.dart';
import 'package:la_vie/views/components/custom_text.dart';
import 'package:la_vie/views/screens/blogs_screens/single_blog_screen.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Blog>(context).allBlogs;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              top: Screen.screenHeight / (926 / 44),
              right: Screen.screenWidth / (428 / 24),
              left: Screen.screenWidth / (428 / 24)),
          child: Column(
            children: [
              customText(
                text: "Blogs",
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
              SizedBox(height: Screen.screenHeight / (926 / 10)),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Card(
                          margin: EdgeInsets.only(
                              bottom: Screen.screenHeight / (926 / 21)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: SizedBox(
                            width: Screen.screenWidth / (428 / 373),
                            height: Screen.screenHeight / (926 / 161),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: Screen.screenHeight / (926 / 14),
                                          bottom:
                                              Screen.screenHeight / (926 / 14),
                                          left:
                                              Screen.screenWidth / (428 / 11)),
                                      child: Provider.of<Blog>(context,
                                                      listen: false)
                                                  .allBlogs[index]
                                                  .imageUrl ==
                                              ""
                                          ? Image.asset(
                                              "assets/images/plant3.png")
                                          : Image.network(
                                              url + provider[index].imageUrl!,
                                              width: double.infinity,
                                              height: Screen.screenHeight /
                                                  (926 / 170),
                                              fit: BoxFit.cover,
                                            ),
                                    )),
                                Expanded(
                                    flex: 8,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              Screen.screenWidth / (428 / 23)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          customText(
                                              text: "2 days ago",
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primary),
                                          customText(
                                              text: "${provider[index].name}",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                          customText(
                                              text:
                                                  "${provider[index].description}",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.customGrey),
                                          customText(
                                              text:
                                                  "${provider[index].description}",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.customGrey,
                                              overflow: TextOverflow.ellipsis),
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SingleBlogScreen(
                                  Provider.of<Blog>(context, listen: false)
                                      .allBlogs[index])));
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

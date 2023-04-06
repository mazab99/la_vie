import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:la_vie/models/my_forums_model/my_forums.dart';
import 'package:la_vie/provider/my_forums_provider.dart';
import 'package:la_vie/utils/color.dart';
import 'package:la_vie/utils/screen.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../../components/custom_text.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  File? image;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? img64;
  var formState = GlobalKey<FormState>();
  bool createPost = false;
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
      body: createPost
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: formState,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Screen.screenWidth / (428 / 24),
                        vertical: Screen.screenHeight / (926 / 50)),
                    child: Column(
                      children: [
                        Row(children: [
                          Expanded(
                            child: Stack(
                              children: [
                                InkWell(
                                    child: const Icon(Icons.arrow_back),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    }),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: customText(
                                    text: "Create New Post",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 21,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Screen.screenHeight / (926 / 61)),
                          child: GestureDetector(
                            child: Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  border: Border.all(
                                      width: 1, color: AppColors.primary)),
                              child: image == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image.asset(
                                        "assets/images/add_photo.png",
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image.file(
                                        image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            onTap: () async {
                              try {
                                final image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (image == null) return;
                                final imageTemporary = File(image.path);
                                setState(() {
                                  this.image = imageTemporary;
                                });

                                final bytes =
                                    await File(image.path).readAsBytes();
                                img64 = base64Encode(bytes);
                                final imgExtention = image.name
                                    .substring(image.name.lastIndexOf('.') + 1);
                                img64 =
                                    "data:image/$imgExtention;base64,$img64";
                              } on PlatformException catch (e) {
                                "Faild to pick image $e";
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Screen.screenHeight / (926 / 35)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Title',
                                  style: TextStyle(
                                      color: AppColors.textFieldLabel)),
                              const SizedBox(height: 2),
                              TextFormField(
                                controller: _titleController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(),
                                ),
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return "Title is empty";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Screen.screenHeight / (926 / 35)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Description',
                                style:
                                    TextStyle(color: AppColors.textFieldLabel)),
                            const SizedBox(height: 2),
                            TextFormField(
                              minLines: 7,
                              maxLines: 7,
                              controller: _descriptionController,
                              textAlignVertical: TextAlignVertical.top,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                border: OutlineInputBorder(),
                              ),
                              validator: (input) {
                                if (input!.isEmpty) {
                                  return "Description is empty";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              child: const Text("Post"),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.primary)),
                              onPressed: () {
                                if (formState.currentState!.validate()) {
                                  if (image == null) {
                                    Toast.show("Select image first",
                                        duration: 3);
                                  } else {
                                    setState(() {
                                      createPost = true;
                                    });
                                    MyForums post = MyForums();
                                    post.title = _titleController.text;
                                    post.description =
                                        _descriptionController.text;
                                    post.imageUrl = img64;
                                    Provider.of<MyForumsProvider>(context,
                                            listen: false)
                                        .createPost(post: post)
                                        .then((value) {
                                      Toast.show("Post created succefully",
                                          duration: 2);
                                      Navigator.of(context).pop();
                                    }, onError: (e) {
                                      Toast.show(e, duration: 3);
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

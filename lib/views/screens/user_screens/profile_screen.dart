import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/provider/user_profile_provider.dart';
import 'package:la_vie/services/cashe_helper.dart';
import 'package:la_vie/utils/color.dart';
import 'package:la_vie/utils/constants.dart';
import 'package:la_vie/utils/screen.dart';
import 'package:la_vie/views/components/custom_text.dart';
import 'package:la_vie/views/screens/authentication_screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    var provider = Provider.of<UserProvider>(context).userData!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                height: Screen.screenHeight / (926 / 345),
                child: Stack(children: [
                  Image.asset(
                    "assets/images/img.jpeg",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill,
                  ).blurred(blur: 7),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: Screen.screenHeight / (926 / 25),
                            right: Screen.screenWidth / (428 / 25),
                            left: Screen.screenWidth / (428 / 25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                child: const Icon(Icons.logout,
                                    size: 35, color: Colors.white),
                                onTap: () {
                                  CacheHelper.removeKey(key: "userId");

                                  CacheHelper.removeKey(key: "token");
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                }),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage("assets/images/img.jpeg")),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: customText(
                            text: "${provider.firstName} ${provider.lastName}",
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )
                    ],
                  )
                ]),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: Screen.screenHeight / (926 / 325)),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: Colors.white),
                  child: SizedBox(
                    height: Screen.screenHeight / (926 / (926 - 360)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: Screen.screenHeight / (926 / 25)),
                          child: Container(
                            width: Screen.screenWidth / (428 / 378),
                            height: Screen.screenHeight / (926 / 90),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xffF3FEF1)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screen.screenWidth / (428 / 15)),
                              child: Row(
                                children: [
                                  Image.asset("assets/images/points.png"),
                                  SizedBox(
                                      width: Screen.screenWidth / (428 / 15)),
                                  customText(
                                      text: "You have $points points",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.all(Screen.screenWidth / (428 / 30)),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: customText(
                                  text: "Edit Profile",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24)),
                        ),
                        Container(
                          width: Screen.screenWidth / (428 / 378),
                          height: Screen.screenHeight / (926 / 100),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: AppColors.customGrey)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Screen.screenWidth / (428 / 15)),
                            child: Row(
                              children: [
                                Image.asset("assets/images/change.png"),
                                SizedBox(
                                    width: Screen.screenWidth / (428 / 15)),
                                customText(
                                    text: "Change Name",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      child: const Icon(
                                        Icons.arrow_forward,
                                        color: Color(0xff1D592C),
                                        size: 35,
                                      ),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              var fNameController =
                                                  TextEditingController();
                                              var lNameController =
                                                  TextEditingController();
                                              return Form(
                                                key: _key,
                                                child: AlertDialog(
                                                  shape: Border.all(
                                                      color:
                                                          AppColors.customGrey,
                                                      width: 2),
                                                  title:
                                                      const Text("Change name"),
                                                  content: SizedBox(
                                                    height: 150,
                                                    width: 200,
                                                    child: ListView(
                                                      children: [
                                                        TextFormField(
                                                          controller:
                                                              fNameController,
                                                          decoration:
                                                              const InputDecoration(
                                                            label: Text(
                                                                "First name"),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: AppColors
                                                                      .primary),
                                                            ),
                                                          ),
                                                          validator: (input) {
                                                            if (input!
                                                                .isEmpty) {
                                                              return "Field is Required";
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        TextFormField(
                                                          controller:
                                                              lNameController,
                                                          decoration:
                                                              const InputDecoration(
                                                            label: Text(
                                                                "Last name"),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: AppColors
                                                                      .primary),
                                                            ),
                                                          ),
                                                          validator: (input) {
                                                            if (input!
                                                                .isEmpty) {
                                                              return "Field is Required";
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context,
                                                              "Cancel");
                                                        },
                                                        child: customText(
                                                            text: "Cancel",
                                                            fontSize: 16)),
                                                    TextButton(
                                                        onPressed: () {
                                                          if (_key.currentState!
                                                              .validate()) {
                                                            Provider.of<UserProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .updateData(
                                                                    fName:
                                                                        fNameController
                                                                            .text,
                                                                    lName:
                                                                        lNameController
                                                                            .text,
                                                                    email: provider
                                                                        .email!,
                                                                    address:
                                                                        provider
                                                                            .address)
                                                                .then((value) {
                                                              Navigator.pop(
                                                                  context,
                                                                  "Save");
                                                            }, onError: (e) {
                                                              Navigator.pop(
                                                                  context,
                                                                  e.toString());
                                                            });
                                                          }
                                                        },
                                                        child: customText(
                                                            text: "Save",
                                                            fontSize: 16)),
                                                  ],
                                                ),
                                              );
                                            }).then((value) {
                                          if (value == "Save") {
                                            Toast.show(
                                                "Name changed succefully",
                                                duration: 2);
                                          } else if (value != "Cancel" &&
                                              value != null) {
                                            Toast.show("$value", duration: 3);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Screen.screenHeight / (926 / 30)),
                        Container(
                          width: Screen.screenWidth / (428 / 378),
                          height: Screen.screenHeight / (926 / 100),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: AppColors.customGrey)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Screen.screenWidth / (428 / 15)),
                            child: Row(
                              children: [
                                Image.asset("assets/images/change.png"),
                                SizedBox(
                                    width: Screen.screenWidth / (428 / 15)),
                                customText(
                                    text: "Change Email",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      child: const Icon(
                                        Icons.arrow_forward,
                                        color: Color(0xff1D592C),
                                        size: 35,
                                      ),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              var emailController =
                                                  TextEditingController();

                                              return Form(
                                                key: _key,
                                                child: AlertDialog(
                                                  shape: Border.all(
                                                      color:
                                                          AppColors.customGrey,
                                                      width: 2),
                                                  title: const Text(
                                                      "Change Email"),
                                                  content: SizedBox(
                                                    height: 65,
                                                    width: 200,
                                                    child: TextFormField(
                                                      controller:
                                                          emailController,
                                                      decoration:
                                                          const InputDecoration(
                                                        label: Text("Email"),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: AppColors
                                                                  .primary),
                                                        ),
                                                      ),
                                                      validator: (input) {
                                                        if (input!.isEmpty ||
                                                            !input.contains(
                                                                "@")) {
                                                          return "This field is email";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context,
                                                              "Cancel");
                                                        },
                                                        child: customText(
                                                            text: "Cancel",
                                                            fontSize: 16)),
                                                    TextButton(
                                                        onPressed: () {
                                                          if (_key.currentState!
                                                              .validate()) {
                                                            Provider.of<UserProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .updateData(
                                                                    fName: provider
                                                                        .firstName!,
                                                                    lName: provider
                                                                        .lastName!,
                                                                    email:
                                                                        emailController
                                                                            .text,
                                                                    address:
                                                                        provider
                                                                            .address)
                                                                .then((value) {
                                                              Navigator.pop(
                                                                  context,
                                                                  "Save");
                                                            }, onError: (e) {
                                                              Navigator.pop(
                                                                  context,
                                                                  e.toString());
                                                            });
                                                          }
                                                        },
                                                        child: customText(
                                                            text: "Save",
                                                            fontSize: 16)),
                                                  ],
                                                ),
                                              );
                                            }).then((value) {
                                          if (value == "Save") {
                                            Toast.show(
                                                "Email changed succefully",
                                                duration: 2);
                                          } else if (value != "Cancel" &&
                                              value != null) {
                                            Toast.show("$value", duration: 3);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
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
  }
}

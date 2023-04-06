import 'package:flutter/material.dart';
import 'package:la_vie/provider/authentication_provider.dart';
import 'package:la_vie/provider/bottom_nav_bar.dart';
import 'package:la_vie/provider/user_profile_provider.dart';
import 'package:la_vie/utils/color.dart';
import 'package:la_vie/views/components/text_form_field.dart';
import 'package:la_vie/views/screens/main_screens/app_layout_screen.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../utils/screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset('assets/images/2.png')),
              Stack(
                children: [
                  const Center(
                    child: Text(
                      "La Vie",
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Meddon"),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/1.png',
                      width: 23,
                      height: 15.04,
                    ),
                    heightFactor: 2.5,
                  )
                ],
              ),
              SizedBox(
                height: Screen.screenHeight / (926 / 504),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Screen.screenWidth / (428 / 45)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: Screen.screenHeight / (926 / 55)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen()));
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                  fontSize: 18,
                                  shadows: [
                                    Shadow(
                                        color: AppColors.signupLoginText,
                                        offset: Offset(0, -15))
                                  ],
                                  color: Colors.transparent,
                                  decorationThickness: 4,
                                ),
                              ),
                            ),
                            const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 18,
                                  shadows: [
                                    Shadow(
                                        color: AppColors.primary,
                                        offset: Offset(0, -15))
                                  ],
                                  color: Colors.transparent,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primary,
                                  decorationThickness: 4,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: ListView(
                        children: [
                          textFormField(
                              labelName: 'Email',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (input) {
                                if (input!.isEmpty || !input.contains('@')) {
                                  return "This field must be an email";
                                }
                                return null;
                              }),
                          SizedBox(height: Screen.screenHeight / (926 / 10)),
                          textFormField(
                            labelName: "Password",
                            controller: _passwordController,
                            obscureText: true,
                            validator: (input) {
                              if (input!.isEmpty || input.length < 5) {
                                return "Password length must be greater than 5 characters";
                              }
                              return null;
                            },
                          )
                        ],
                      )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          !_isLoading
                              ? SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    child: const Text("Login"),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                AppColors.primary)),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        await Provider.of<Authentication>(
                                                context,
                                                listen: false)
                                            .login(
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text)
                                            .then((value) {
                                          Provider.of<BottomNavBar>(context,
                                                  listen: false)
                                              .changeSelected(2);
                                          Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .changeFreeSeedVal();
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AppLayoutScreen()));
                                        }, onError: (e) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          Toast.show(e.toString(), duration: 3);
                                        });
                                      } else {
                                        return;
                                      }
                                    },
                                  ))
                              : const CircularProgressIndicator(),
                          Padding(
                            padding: EdgeInsets.only(
                                top: Screen.screenHeight / (926 / 30)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/line.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  child: Text(
                                    "or continue with",
                                    style:
                                        TextStyle(color: AppColors.customGrey),
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/line.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: Screen.screenHeight / (926 / 20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.asset(
                                      "assets/icons/google.png",
                                      height: 30.0,
                                      width: 40.0,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                                InkWell(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.asset(
                                      "assets/icons/facebook.png",
                                      height: 30.0,
                                      width: 40.0,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset('assets/images/3.png')),
            ],
          ),
        ),
      ),
    );
  }
}

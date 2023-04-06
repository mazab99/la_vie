import 'package:flutter/material.dart';
import 'package:la_vie/provider/cart_provider.dart';
import 'package:la_vie/provider/categories.dart';
import 'package:la_vie/provider/user_profile_provider.dart';
import 'package:la_vie/services/cashe_helper.dart';
import 'package:la_vie/utils/color.dart';
import 'package:la_vie/utils/screen.dart';
import 'package:la_vie/views/components/categories.dart';
import 'package:la_vie/views/components/custom_text.dart';
import 'package:la_vie/views/screens/cart_screens/cart_screen.dart';
import 'package:la_vie/views/screens/cart_screens/empty_cart.dart';
import 'package:la_vie/views/screens/home_screens/plants_screen.dart';
import 'package:la_vie/views/screens/home_screens/products_screen.dart';
import 'package:la_vie/views/screens/home_screens/seeds_screen.dart';
import 'package:la_vie/views/screens/home_screens/tools_screen.dart';
import 'package:la_vie/views/screens/questions_screens/question_screen.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

enum Category { all, plants, seeds, tools }

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      var provider = Provider.of<UserProvider>(context, listen: false);
      if (provider.userData!.address == null) {
        if (provider.freeSeedAlert) {
          _showAlert(context);
        }
      }
    });

    return SafeArea(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(
              top: (50 / Screen.screenHeight) * Screen.screenHeight),
        ),
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
              heightFactor: 2.5,
              child: Image.asset(
                'assets/images/1.png',
                width: 23,
                height: 15.04,
              ),
            ),
            CacheHelper.getData(key: "userPoints") == null
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, right: 5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          primary: AppColors.secondary,
                        ),
                        child: const Icon(
                          Icons.question_mark,
                          color: AppColors.primary,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const QuestionScreen()));
                        },
                      ),
                    ),
                  )
                : Container()
          ],
        ),
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: (16 / Screen.screenWidth) * Screen.screenWidth,
                vertical: (25 / Screen.screenHeight) * Screen.screenHeight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: Material(
                    elevation: 1,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.secondary,
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                            icon:
                                Icon(Icons.search, color: AppColors.customGrey),
                            hintText: 'Search',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.primary,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Provider.of<Cart>(context, listen: false).myCart.isEmpty
                            ? Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const EmptyCartScreen()))
                            : Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CartScreen()));
                      },
                      icon: const Icon(Icons.shopping_cart_checkout),
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: (16 / Screen.screenWidth) * Screen.screenWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              categoryWidget(
                categorySelected:
                    Provider.of<Categories>(context).selectedCategory,
                value: "all",
                onTap: () {
                  if (Provider.of<Categories>(context, listen: false)
                          .selectedCategory !=
                      Category.all) {
                    Provider.of<Categories>(context, listen: false)
                        .changeSelectedCategory(Category.all);
                  }
                },
              ),
              categoryWidget(
                  categorySelected:
                      Provider.of<Categories>(context).selectedCategory,
                  value: "plants",
                  onTap: () {
                    if (Provider.of<Categories>(context, listen: false)
                            .selectedCategory !=
                        Category.plants) {
                      Provider.of<Categories>(context, listen: false)
                          .changeSelectedCategory(Category.plants);
                    }
                  }),
              categoryWidget(
                  categorySelected:
                      Provider.of<Categories>(context).selectedCategory,
                  value: "seeds",
                  onTap: () {
                    if (Provider.of<Categories>(context, listen: false)
                            .selectedCategory !=
                        Category.seeds) {
                      Provider.of<Categories>(context, listen: false)
                          .changeSelectedCategory(Category.seeds);
                    }
                  }),
              categoryWidget(
                  categorySelected:
                      Provider.of<Categories>(context).selectedCategory,
                  value: "tools",
                  onTap: () {
                    if (Provider.of<Categories>(context, listen: false)
                            .selectedCategory !=
                        Category.tools) {
                      Provider.of<Categories>(context, listen: false)
                          .changeSelectedCategory(Category.tools);
                    }
                  }),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Provider.of<Categories>(context).selectedCategory == Category.all
            ? const ProductsScreen()
            : Provider.of<Categories>(context).selectedCategory ==
                    Category.seeds
                ? const SeedsScreen()
                : Provider.of<Categories>(context).selectedCategory ==
                        Category.tools
                    ? const ToolsScreen()
                    : const PlantsScreen()
      ]),
    );
  }

  void _showAlert(BuildContext context) {
    ToastContext().init(context);
    showDialog(
        context: context,
        builder: (context) {
          var addressController = TextEditingController();
          final _key = GlobalKey<FormState>();
          return Form(
            key: _key,
            child: AlertDialog(
              contentPadding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 24.0),
              shape: Border.all(color: AppColors.customGrey, width: 2),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 130,
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/freeseed.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 4),
                      child: Stack(
                        children: [
                          const Center(
                            child: Text(
                              "La Vie",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Meddon"),
                            ),
                          ),
                          Center(
                            heightFactor: 2.5,
                            child: Image.asset(
                              'assets/images/1.png',
                              width: 18,
                              height: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    customText(
                        text: 'Get Seeds For Free',
                        fontFamily: "Karantina",
                        fontSize: 40),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: customText(
                          text: 'Enter Your Address',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      child: TextFormField(
                        controller: addressController,
                        decoration: const InputDecoration(
                          label: Text("Address"),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                        ),
                        validator: (input) {
                          if (input!.isEmpty || input.length < 3) {
                            return "Min 3 letters";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                            width: (double.infinity / 2),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.primary)),
                              onPressed: () {
                                if (_key.currentState!.validate()) {
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .addAddress(addressController.text)
                                      .then((value) {
                                    Navigator.pop(context, "Done");
                                  }, onError: (e) {
                                    Navigator.pop(context, e.toString());
                                  });
                                }
                              },
                              child: const Text("Send"),
                            ))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: (double.infinity / 2),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffF0F0F0)),
                          ),
                          onPressed: () {
                            Navigator.pop(context, "Cancel");
                          },
                          child: const Text(
                            "Save For Later",
                            style: TextStyle(color: Color(0xff979797)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).then((value) {
      Provider.of<UserProvider>(context, listen: false).changeFreeSeedVal();
      if (value == "Done") {
        Toast.show("Free seed will arrive in 2 days", duration: 3);
      } else if (value != "Cancel" && value != null) {
        Toast.show("$value", duration: 3);
      }
    });
  }
}

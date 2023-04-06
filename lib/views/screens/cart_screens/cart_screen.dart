import 'package:flutter/material.dart';

import 'package:la_vie/provider/cart_provider.dart';
import 'package:la_vie/provider/categories.dart';
import 'package:la_vie/services/cashe_helper.dart';
import 'package:la_vie/utils/color.dart';
import 'package:la_vie/utils/constants.dart';
import 'package:la_vie/utils/screen.dart';
import 'package:la_vie/views/screens/home_screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../components/custom_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    var providerListener = Provider.of<Cart>(context).myCart;
    var provider = Provider.of<Cart>(context, listen: false).myCart;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              top: Screen.screenHeight / (926 / 44),
              right: Screen.screenWidth / (428 / 24),
              left: Screen.screenWidth / (428 / 24),
              bottom: Screen.screenHeight / (926 / 25)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          text: "My Cart",
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                )
              ]),
              SizedBox(height: Screen.screenHeight / (926 / 10)),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: providerListener.length,
                    itemBuilder: (context, index) {
                      return Card(
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
                                        left: Screen.screenWidth / (428 / 11)),
                                    child: providerListener[index].imageUrl ==
                                            ""
                                        ? Image.asset("assets/images/55.png")
                                        : Image.network(
                                            url +
                                                providerListener[index]
                                                    .imageUrl!,
                                            fit: BoxFit.cover,
                                          ),
                                  )),
                              Expanded(
                                  flex: 8,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Screen.screenWidth / (428 / 23)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        customText(
                                            text: providerListener[index].name!,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                        customText(
                                            text:
                                                "${providerListener[index].price!} EGP",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primary),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: Screen.screenWidth /
                                                  (428 / 67),
                                              height: Screen.screenHeight /
                                                  (926 / 35),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(8),
                                                  )),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Provider.of<Cart>(context,
                                                              listen: false)
                                                          .updateCart(
                                                              provider[index]
                                                                  .productId!,
                                                              "-");
                                                    },
                                                    child: Center(
                                                      child: customText(
                                                          text: "-",
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .primary),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Screen.screenWidth *
                                                        0.01,
                                                  ),
                                                  Text(
                                                      "${providerListener[index].count}"),
                                                  SizedBox(
                                                    width: Screen.screenWidth *
                                                        0.01,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Provider.of<Cart>(context,
                                                              listen: false)
                                                          .updateCart(
                                                              provider[index]
                                                                  .productId!,
                                                              "+");
                                                    },
                                                    child: Center(
                                                      child: customText(
                                                          text: "+",
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .primary),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: Screen.screenWidth /
                                                      (428 / 8)),
                                              child: InkWell(
                                                  child: const Icon(
                                                      Icons.delete,
                                                      color: AppColors.primary),
                                                  onTap: () {
                                                    Provider.of<Cart>(context,
                                                            listen: false)
                                                        .removeFromCart(
                                                            provider[index]
                                                                .productId!,
                                                            CacheHelper.getData(
                                                                key: "userId"));
                                                  }),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: Screen.screenHeight / (926 / 15),
                    right: Screen.screenWidth / (428 / 10),
                    left: Screen.screenWidth / (428 / 20),
                    bottom: Screen.screenHeight / (926 / 20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customText(
                        text: "Total",
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                            children: [
                          TextSpan(
                              text:
                                  "${Provider.of<Cart>(context).orderPrice()}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary)),
                          const TextSpan(text: " EGP"),
                        ])),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Screen.screenWidth / (428 / 10)),
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    child: const Text("Checkout"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primary),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12.0)))),
                    onPressed: () {
                      Provider.of<Categories>(context, listen: false)
                          .changeSelectedCategory(Category.all);
                      Provider.of<Cart>(context, listen: false).removeAll();
                      Toast.show("Order will arrive in 2 days", duration: 3);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

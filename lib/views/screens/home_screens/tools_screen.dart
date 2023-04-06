import 'package:flutter/material.dart';
import 'package:la_vie/models/cart_model/mycart.dart';
import 'package:la_vie/provider/cart_provider.dart';
import 'package:la_vie/provider/tool_provider.dart';
import 'package:la_vie/services/cashe_helper.dart';
import 'package:la_vie/utils/constants.dart';
import 'package:la_vie/views/components/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../utils/screen.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Tool>(context).allTools;
    return provider.isEmpty
        ? const Expanded(child: Center(child: CircularProgressIndicator()))
        : Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 176 / 274,
                    crossAxisSpacing:
                        (14 / Screen.screenWidth) * Screen.screenWidth,
                    mainAxisSpacing: 5),
                itemCount: provider.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Padding(
                    padding: index % 2 == 0
                        ? EdgeInsets.only(
                            left:
                                (18 / Screen.screenWidth) * Screen.screenWidth)
                        : EdgeInsets.only(
                            right:
                                (18 / Screen.screenWidth) * Screen.screenWidth),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Stack(fit: StackFit.expand, children: [
                        Column(
                          children: [
                            const Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                                flex: 4,
                                child: Material(
                                  elevation: 6,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  child: Container(),
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            Expanded(
                                flex: 4,
                                child:
                                    Stack(clipBehavior: Clip.none, children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: provider[index].imageUrl == ""
                                        ? Image.asset("assets/images/55.png")
                                        : index == 3 || index == 17
                                            ? Image.network(
                                                "$url/uploads/71009e87-80a0-43f8-925c-2a6d54e531a0.jpg")
                                            : Image.network(
                                                url + provider[index].imageUrl!,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Container(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Provider.of<Cart>(context,
                                                      listen: false)
                                                  .updateCart(
                                                      provider[index].toolId!,
                                                      "-");
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(5),
                                                  )),
                                              child: const Center(
                                                child: Text(
                                                  "-",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Screen.screenWidth * 0.01,
                                          ),
                                          customText(
                                              text:
                                                  "${Provider.of<Cart>(context).getCount(provider[index].toolId!)}",
                                              fontWeight: FontWeight.bold),
                                          SizedBox(
                                            width: Screen.screenWidth * 0.01,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Provider.of<Cart>(context,
                                                      listen: false)
                                                  .updateCart(
                                                      provider[index].toolId!,
                                                      "+");
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(5),
                                                  )),
                                              child: const Center(
                                                child: Text(
                                                  "+",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ])),
                            const SizedBox(height: 6),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        provider[index].name!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(height: 3),
                                      const Text(
                                        "${270} EGP",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: Provider.of<Cart>(context)
                                                  .getCount(provider[index]
                                                      .toolId!) ==
                                              0
                                          ? () {
                                              Provider.of<Cart>(context,
                                                      listen: false)
                                                  .addToCart(
                                                MyCart(
                                                  productId:
                                                      provider[index].toolId,
                                                  userId: CacheHelper.getData(
                                                      key: "userId"),
                                                  name: provider[index].name,
                                                  imageUrl: provider[index]
                                                          .imageUrl ??
                                                      "/uploads/d8d6a270-1260-45dd-b6aa-9cf7555977cc.jpg",
                                                  price: 270,
                                                  count: 1,
                                                ),
                                              );
                                            }
                                          : null,
                                      child: const Text("Add to cart"),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xff1ABC00)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          )))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  );
                }),
          );
  }
}

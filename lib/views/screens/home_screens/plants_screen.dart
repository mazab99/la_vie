import 'package:flutter/material.dart';
import 'package:la_vie/models/cart_model/mycart.dart';
import 'package:la_vie/provider/cart_provider.dart';
import 'package:la_vie/services/cashe_helper.dart';
import 'package:la_vie/utils/constants.dart';
import 'package:la_vie/views/components/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../provider/plant_provider.dart';
import '../../../utils/screen.dart';

class PlantsScreen extends StatelessWidget {
  const PlantsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Plant>(context).allPlants;
    return provider.isEmpty
        ? const Expanded(child: Center(child: CircularProgressIndicator()))
        : Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 176 / 274,
                  crossAxisSpacing:
                      (14 / Screen.screenWidth) * Screen.screenWidth,
                  mainAxisSpacing: 10,
                ),
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
                                flex: 6,
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
                              flex: 5,
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12)),
                                  child: provider[index].imageUrl == ""
                                      ? Image.asset("assets/images/plant4.png")
                                      : Image.network(
                                          url + provider[index].imageUrl!,
                                          width: double.infinity,
                                          height:
                                              Screen.screenHeight / (926 / 160),
                                          fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey,),
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        provider[index].name!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(height: 3),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "${210} EGP",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Provider.of<Cart>(context,
                                                            listen: false)
                                                        .updateCart(
                                                      provider[index].plantId!,
                                                      "-",
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 25,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(5),
                                                        )),
                                                    child: const Center(
                                                      child: Text(
                                                        "-",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      Screen.screenWidth * 0.01,
                                                ),
                                                customText(
                                                    text:
                                                        "${Provider.of<Cart>(context).getCount(provider[index].plantId!)}",
                                                    fontWeight:
                                                        FontWeight.bold),
                                                SizedBox(
                                                  width:
                                                      Screen.screenWidth * 0.01,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Provider.of<Cart>(context,
                                                            listen: false)
                                                        .updateCart(
                                                            provider[index]
                                                                .plantId!,
                                                            "+");
                                                  },
                                                  child: Container(
                                                    height: 25,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(5),
                                                        )),
                                                    child: const Center(
                                                      child: Text(
                                                        "+",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: Provider.of<Cart>(context)
                                                  .getCount(provider[index]
                                                      .plantId!) ==
                                              0
                                          ? () {
                                              Provider.of<Cart>(context,
                                                      listen: false)
                                                  .addToCart(
                                                MyCart(
                                                  productId:
                                                      provider[index].plantId,
                                                  userId: CacheHelper.getData(
                                                      key: "userId"),
                                                  name: provider[index].name,
                                                  imageUrl: provider[index]
                                                          .imageUrl ??
                                                      "/uploads/09be504b-99e3-481d-9653-9b6c791741dc.png",
                                                  price: 70,
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

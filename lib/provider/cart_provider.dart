import 'package:flutter/material.dart';
import 'package:la_vie/models/cart_model/mycart.dart';
import 'package:la_vie/services/cashe_helper.dart';

import 'package:la_vie/services/sqlite_helper.dart';

class Cart with ChangeNotifier {
  final List<MyCart> _myCart = [];
  late int _orderPrice;
  final sqlInstance = SQLiteHelper.instance;

  List<MyCart> get myCart => _myCart;

  int orderPrice() {
    _orderPrice = 0;
    for (var element in _myCart) {
      _orderPrice += element.count * element.price!;
    }
    return _orderPrice;
  }

  Future getAllItems(String userId) async {
    _myCart.clear();
    try {
      await sqlInstance.initializeDatabase();
      var responseFromDB = await sqlInstance.getAll(userId);
      for (var element in responseFromDB) {
        _myCart.add(MyCart.fromJson(element));
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future addToCart(MyCart cartItem) async {
    try {
      await sqlInstance.initializeDatabase();
      var responseFromDB = await sqlInstance.insert(cartItem.toJson());
      _myCart.add(cartItem);
      notifyListeners();
      if (responseFromDB != 0) return "Done";
    } catch (e) {
      throw e.toString();
    }
  }

  Future updateCart(String prodId, String op) async {
    MyCart cartItem = getItemById(prodId);
    if (cartItem.count == -1 || cartItem.count == 0) return;
    if (op == '+') {
      cartItem.count++;
    } else {
      cartItem.count--;
      if (cartItem.count == 0) {
        removeFromCart(prodId, cartItem.userId!);
        return;
      }
    }
    try {
      await sqlInstance.initializeDatabase();
      var responseFromDB = await sqlInstance.update(cartItem.toJson());
      _myCart[_myCart.indexWhere(
          (element) => element.productId == cartItem.productId)] = cartItem;
      notifyListeners();
      if (responseFromDB != 0) return "Done";
    } catch (e) {
      throw e.toString();
    }
  }

  MyCart getItemById(String prodId) {
    return _myCart.firstWhere((element) => element.productId == prodId,
        orElse: () => MyCart(count: -1));
  }

  Future removeFromCart(String productId, String userID) async {
    try {
      await sqlInstance.initializeDatabase();
      var responseFromDB = await sqlInstance.delete(productId, userID);
      _myCart.removeWhere((element) => element.productId == productId);
      notifyListeners();
      if (responseFromDB != 0) return "Done";
    } catch (e) {
      throw e.toString();
    }
  }

  Future removeAll() async {
    try {
      await sqlInstance.initializeDatabase();
      var responseFromDB =
          await sqlInstance.deleteByUserId(CacheHelper.getData(key: "userId"));
      _myCart.clear();
      notifyListeners();
      if (responseFromDB != 0) return "Done";
    } catch (e) {
      throw e.toString();
    }
  }

  int getCount(String prodID) {
    for (var element in _myCart) {
      if (element.productId == prodID) return element.count;
    }
    return 0;
  }
}

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:la_vie/models/cart_model/mycart.dart';
// import 'package:la_vie/models/plants_model/plants.dart';
// import 'package:la_vie/models/plants_model/plants_model.dart';
// import 'package:la_vie/models/products_model/products.dart';
// import 'package:la_vie/models/products_model/products_model.dart';
// import 'package:la_vie/models/seeds_model/seeds.dart';
// import 'package:la_vie/models/seeds_model/seeds_model.dart';
// import 'package:la_vie/models/tools_model/tools.dart';
// import 'package:la_vie/models/tools_model/tools_model.dart';
// import 'package:la_vie/services/dio_client.dart';
// import 'package:la_vie/services/sqlite_helper.dart';
// import 'package:la_vie/utils/constants.dart';

// class Cart with ChangeNotifier {
//   final List<MyCart> _dataFromDatabase = [];
//   // final List<dynamic> _mycart = [];
//   final sqlInstance = SQLiteHelper.instance;

//   // List<dynamic> get allItems => _mycart;

//   Future getAllItems(String userId) async {
//     _dataFromDatabase.clear();
//     // _mycart.clear();
//     try {
//       await sqlInstance.initializeDatabase();
//       var responseFromDB = await sqlInstance.getAll(userId);
//       print(responseFromDB);
//       MyCart _item;
//       dynamic _product;
//       for (var element in responseFromDB) {
//         _item = MyCart.fromJson(element);
//         _dataFromDatabase.add(_item);
//         _product = await _getItem(_item.type, _item.productId);
//         // _mycart.add(_product);
//       }
//     } catch (e) {
//       throw e.toString();
//     }
//   }

//   Future addToCart(MyCart cartItem) async {
//     try {
//       await sqlInstance.initializeDatabase();
//       var responseFromDB = await sqlInstance.insert(cartItem.toJson());
//       _dataFromDatabase.add(cartItem);
//       dynamic _product = await _getItem(cartItem.type, cartItem.productId);
//       // _mycart.add(_product);
//       if (responseFromDB != 0) return "Done";
//     } catch (e) {
//       throw e.toString();
//     }
//   }

//   Future updateCart(MyCart cartItem, String op) async {
//     try {
//       await sqlInstance.initializeDatabase();
//       var responseFromDB = await sqlInstance.update(cartItem.toJson());

//       if (responseFromDB != 0) return "Done";
//     } catch (e) {
//       throw e.toString();
//     }
//   }

//   Future removeFromCart(String productId) async {
//     try {
//       await sqlInstance.initializeDatabase();
//       var responseFromDB = await sqlInstance.delete(productId);
//       _dataFromDatabase
//           .removeWhere((element) => element.productId == productId);
//       // _mycart.removeWhere((element) => element.)
//       if (responseFromDB != 0) return "Done";
//     } catch (e) {
//       throw e.toString();
//     }
//   }

//   int getCount(String prodID) {
//     for (var element in _dataFromDatabase) {
//       if (element.productId == prodID) return element.count!;
//     }
//     return 0;
//   }

//   Future<Tools> _getToolById(String? id) async {
//     try {
//       var response = await DioClient.dio.get(
//           "${DioClient.url}/api/v1/tools/toolId=$id",
//           options: Options(headers: ({'Authorization': 'Bearer $token'})));

//       ToolsModel res = ToolsModel.fromJson(response.data);
//       return res.data!.first;
//     } on DioError catch (e) {
//       throw (e.response?.data['message']);
//     }
//   }

//   Future<Seeds> _getSeedById(String? id) async {
//     try {
//       var response = await DioClient.dio.get(
//           "${DioClient.url}/api/v1/seeds/seedId=$id",
//           options: Options(headers: ({'Authorization': 'Bearer $token'})));

//       SeedsModel res = SeedsModel.fromJson(response.data);
//       return res.data!.first;
//     } on DioError catch (e) {
//       throw (e.response?.data['message']);
//     }
//   }

//   Future<Plants> _getPlantById(String? id) async {
//     try {
//       var response = await DioClient.dio.get(
//           "${DioClient.url}/api/v1/plants/plantId=$id",
//           options: Options(headers: ({'Authorization': 'Bearer $token'})));

//       PlantsModel res = PlantsModel.fromJson(response.data);
//       return res.data!.first;
//     } on DioError catch (e) {
//       throw (e.response?.data['message']);
//     }
//   }

//   Future<Products> _getProductById(String? id) async {
//     try {
//       var response = await DioClient.dio.get(
//           "${DioClient.url}/api/v1/products/productId=$id",
//           options: Options(headers: ({'Authorization': 'Bearer $token'})));

//       ProductsModel res = ProductsModel.fromJson(response.data);
//       return res.data!.first;
//     } on DioError catch (e) {
//       throw (e.response?.data['message']);
//     }
//   }

//   Future<dynamic> _getItem(String? type, String? productId) async {
//     dynamic _product;
//     try {
//       switch (type) {
//         case 'tools':
//           _product = await _getToolById(productId);
//           break;
//         case 'plants':
//           _product = await _getPlantById(productId);
//           break;
//         case 'seeds':
//           _product = await _getSeedById(productId);
//           break;
//         default:
//           _product = await _getProductById(productId);
//       }
//     } catch (e) {
//       throw e.toString();
//     }
//     return _product;
//   }
// }

import 'package:flutter/material.dart';
import 'package:food_delivery_v0/controllers/cart_controller.dart';
import 'package:food_delivery_v0/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({
    required this.popularProductRepo,
  });

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopulatProductList();

    if (response.statusCode == 200) {
      print('got products');
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      // print(_popularProductList.toString());
      _isLoaded = true;
      update(); //it's equivalent to notifyListeners
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar('Item count', 'You can\'t reduce more');
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar('Item count', 'You can\'t add more');
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = cart.existInCart(product);
    print('existe or not: ${exist.toString()}');
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    print('The quantity is: ${_inCartItems.toString()}');
    //if exist
    //get from storage _inCartItems = 3
  }

  void addItem(ProductModel product) {
    if (_quantity > 0) {
      _cart.addItem(product, _quantity);
      _quantity = 0;
      _cart.items.forEach((key, value) {
        print(
            'Id: ${value.id.toString()} | Quantity: ${value.quantity.toString()}');
      });
    } else {
      Get.snackbar('Select quantity', 'Quantity has to be greater then 0');
    }
  }
}

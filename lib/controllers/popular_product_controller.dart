import 'package:flutter/material.dart';
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
    if (quantity < 0) {
      Get.snackbar('Item count', 'You can\'t reduce more');
      return 0;
    } else if (quantity > 20) {
      Get.snackbar('Item count', 'You can\'t add more');
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct() {
    _quantity = 0;
  }
}

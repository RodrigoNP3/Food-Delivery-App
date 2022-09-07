import 'package:flutter/material.dart';
import 'package:food_delivery_v0/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';
import '../data/repository/recommended_product_repo.dart';
import '../models/product_model.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({
    required this.recommendedProductRepo,
  });

  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();

    if (response.statusCode == 200) {
      print('got products recommended');
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);

      _isLoaded = true;
      update(); //it's equivalent to notifyListeners
    } else {
      print('could not get products recommended');
    }
  }
}

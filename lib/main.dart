import 'package:flutter/material.dart';
import 'package:food_delivery_v0/controllers/popular_product_controller.dart';
import 'package:food_delivery_v0/pages/home/food_page_body.dart';
import 'package:food_delivery_v0/routes/route_helper.dart';
import 'package:get/get.dart';

import './pages/food/recommended_food_detail.dart';
import './pages/home/main_food_page.dart';
import './pages/food/popular_food_detail.dart';
import './helper/dependencies.dart' as dep;
import 'controllers/recommended_product_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // REMOVES THE DEBUD FLAG
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainFoodPage(),
      // initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}

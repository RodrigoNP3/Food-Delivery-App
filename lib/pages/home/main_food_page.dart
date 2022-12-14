import 'package:flutter/material.dart';
import 'package:food_delivery_v0/pages/home/food_page_body.dart';
import 'package:food_delivery_v0/utils/dimentions.dart';
import 'package:food_delivery_v0/widgets/big_text.dart';
import 'package:food_delivery_v0/widgets/small_text.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '/utils/colors.dart';
import 'package:get/get.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    Future<void> _loadResources() async {
      await Get.find<PopularProductController>().getPopularProductList();
      await Get.find<RecommendedProductController>()
          .getRecommendedProductList();
    }

    // Get.find<PopularProductController>();
    return RefreshIndicator(
        child: Column(
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimentions.height45, bottom: Dimentions.height15),
                padding: EdgeInsets.only(
                    left: Dimentions.width20, right: Dimentions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Set the position of the row's children
                  children: [
                    Column(
                      children: [
                        BigText(
                          text: 'Brazil',
                          color: AppColors.mainColor,
                          size: 30,
                        ),
                        Row(
                          children: [
                            SmallText(
                              text: 'Recife',
                              color: Colors.black54,
                            ),
                            const Icon(Icons.arrow_drop_down_rounded),
                          ],
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: Dimentions.height45,
                        height: Dimentions.height45,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Dimentions.iconSize24,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius15),
                          color: AppColors.mainColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            //Showing the body
            const Expanded(
              child: SingleChildScrollView(
                child: FoodPageBody(),
              ),
            ),
          ],
        ),
        onRefresh: _loadResources);
  }
}

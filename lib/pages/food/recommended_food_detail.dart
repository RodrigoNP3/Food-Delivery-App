import 'package:flutter/material.dart';
import 'package:food_delivery_v0/controllers/popular_product_controller.dart';
import 'package:food_delivery_v0/controllers/recommended_product_controller.dart';
import 'package:food_delivery_v0/pages/cart/cart_page.dart';
import 'package:food_delivery_v0/routes/route_helper.dart';
import 'package:food_delivery_v0/utils/app_constants.dart';
import 'package:food_delivery_v0/utils/colors.dart';
import 'package:food_delivery_v0/utils/dimentions.dart';
import 'package:food_delivery_v0/widgets/app_icon.dart';
import 'package:food_delivery_v0/widgets/big_text.dart';
import 'package:food_delivery_v0/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;

  const RecommendedFoodDetail({
    Key? key,
    required this.pageId,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      if (page == 'cartpage') {
                        Get.toNamed(RouteHelper.getCartPage());
                      } else {
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(icon: Icons.clear)),
                // AppIcon(icon: Icons.shopping_cart_outlined)
                GetBuilder<PopularProductController>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1) {
                          Get.toNamed(RouteHelper.getCartPage());
                        }
                      },
                      child: Stack(
                        children: [
                          const AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems >= 1
                              ? Positioned(
                                  top: 0,
                                  right: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backGroundColor: AppColors.mainColor,
                                  ),
                                )
                              : Container(),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  top: 3,
                                  right: 6,
                                  child: BigText(
                                    text: Get.find<PopularProductController>()
                                        .totalItems
                                        .toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimentions.radius20),
                    topRight: Radius.circular(Dimentions.radius20),
                  ),
                ),
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                width: double.maxFinite,
                child: Center(
                  child: BigText(
                    text: product.name!,
                    size: Dimentions.font26,
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Dimentions.width20, right: Dimentions.width20),
                  child: ExpandableTextWidget(
                    text: product.description!,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: Dimentions.width20 * 2.5,
                  right: Dimentions.width20 * 2.5,
                  top: Dimentions.height10,
                  bottom: Dimentions.height10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Minus Buttom
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                        icon: Icons.remove,
                        iconSize: Dimentions.iconSize24,
                        backGroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: Dimentions.height20,
                          bottom: Dimentions.height20),
                      child: BigText(
                        text: '\$${product.price} X ${controller.inCartItems}',
                        color: AppColors.mainBlackColor,
                        size: Dimentions.font26,
                      ),
                    ),

                    //Plus Buttom
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: AppIcon(
                        icon: Icons.add,
                        iconSize: Dimentions.iconSize24,
                        backGroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: Dimentions.bottomHeightBar,
                padding: EdgeInsets.only(
                  top: Dimentions.height30,
                  bottom: Dimentions.height30,
                  left: Dimentions.width20,
                  right: Dimentions.width20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimentions.radius20 * 2),
                    topRight: Radius.circular(Dimentions.radius20 * 2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: Dimentions.height20,
                        bottom: Dimentions.height20,
                        left: Dimentions.width20,
                        right: Dimentions.width20,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius20),
                          color: Colors.white),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: Dimentions.height20,
                          bottom: Dimentions.height20,
                          left: Dimentions.width20,
                          right: Dimentions.width20,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius20),
                        ),
                        child: BigText(
                          text: '\$${product.price!} | Add to Cart',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

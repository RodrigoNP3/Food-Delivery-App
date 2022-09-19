import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_v0/base/no_data_page.dart';
import 'package:food_delivery_v0/controllers/cart_controller.dart';
import 'package:food_delivery_v0/controllers/popular_product_controller.dart';
import 'package:food_delivery_v0/pages/auth/auth_controller.dart';
import 'package:food_delivery_v0/pages/home/main_food_page.dart';
import 'package:food_delivery_v0/utils/app_constants.dart';
import 'package:food_delivery_v0/utils/colors.dart';
import 'package:food_delivery_v0/utils/dimentions.dart';
import 'package:food_delivery_v0/widgets/app_icon.dart';
import 'package:food_delivery_v0/widgets/big_text.dart';
import 'package:food_delivery_v0/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        //Top icon buttoms
        Positioned(
          top: Dimentions.height20 * 3,
          left: Dimentions.width20,
          right: Dimentions.width20,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            AppIcon(
              icon: Icons.arrow_back_ios,
              iconColor: Colors.white,
              backGroundColor: AppColors.mainColor,
              iconSize: Dimentions.iconSize24,
            ),
            SizedBox(width: Dimentions.width20 * 5),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getInitial());
              },
              child: AppIcon(
                icon: Icons.home_outlined,
                iconColor: Colors.white,
                backGroundColor: AppColors.mainColor,
                iconSize: Dimentions.iconSize24,
              ),
            ),
            AppIcon(
              icon: Icons.shopping_cart,
              iconColor: Colors.white,
              backGroundColor: AppColors.mainColor,
              iconSize: Dimentions.iconSize24,
            ),
          ]),
        ),
        GetBuilder<CartController>(
          builder: (_cartController) {
            return _cartController.getItems.length > 0
                ? Positioned(
                    top: Dimentions.height20 * 5,
                    left: Dimentions.width20,
                    right: Dimentions.width20,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Dimentions.height15),
                      // color: Colors.red,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GetBuilder<CartController>(
                          builder: (cartController) {
                            var _cartList = cartController.getItems;

                            return ListView.builder(
                              itemCount: _cartList.length,
                              itemBuilder: (_, index) {
                                return Container(
                                  height: Dimentions.height20 * 5,
                                  width: double.maxFinite,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          var popularIndex = Get.find<
                                                  PopularProductController>()
                                              .popularProductList
                                              .indexOf(
                                                  _cartList[index].product!);
                                          if (popularIndex >= 0) {
                                            Get.toNamed(
                                                RouteHelper.getPopularFood(
                                                    popularIndex, 'cartpage'));
                                          } else {
                                            var recommendedIndex = Get.find<
                                                    RecommendedProductController>()
                                                .recommendedProductList
                                                .indexOf(
                                                    _cartList[index].product!);

                                            if (recommendedIndex < 0) {
                                              Get.snackbar(
                                                'History Product',
                                                'Product review is not available for history products',
                                              );
                                            } else {
                                              Get.toNamed(RouteHelper
                                                  .getRecommendedFood(
                                                      recommendedIndex,
                                                      'cartpage'));
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: Dimentions.height20 * 5,
                                          height: Dimentions.height20 * 5,
                                          margin: EdgeInsets.only(
                                              bottom: Dimentions.height10),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(AppConstants
                                                        .BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    _cartList[index].img!)),
                                            borderRadius: BorderRadius.circular(
                                                Dimentions.radius20),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Dimentions.width10,
                                      ),
                                      Expanded(
                                          child: Container(
                                        height: Dimentions.width20 * 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            //Product title
                                            BigText(
                                              text: _cartList[index].name!,
                                              color: Colors.black54,
                                            ),
                                            //Product small description
                                            SmallText(text: 'Spacy'),
                                            //Total price and quantity buttons
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // Total price
                                                BigText(
                                                  text:
                                                      '\$${_cartList[index].price!}',
                                                  color: Colors.redAccent,
                                                ),
                                                // Remove/Add buttons - X +
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    top: Dimentions.height10,
                                                    bottom: Dimentions.height10,
                                                    left: Dimentions.width20,
                                                    right: Dimentions.width20,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimentions
                                                                  .radius20),
                                                      color: Colors.white),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                _cartList[index]
                                                                    .product!,
                                                                -1);
                                                          },
                                                          child: Icon(
                                                              Icons.remove,
                                                              color: AppColors
                                                                  .signColor)),
                                                      SizedBox(
                                                          width: Dimentions
                                                                  .width10 /
                                                              2),
                                                      BigText(
                                                          text: _cartList[index]
                                                              .quantity
                                                              .toString()),
                                                      //popularProduct.inCartItems.toString()),
                                                      SizedBox(
                                                          width: Dimentions
                                                                  .width10 /
                                                              2),
                                                      GestureDetector(
                                                        onTap: () {
                                                          cartController
                                                              .addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  1);
                                                        },
                                                        child: Icon(Icons.add,
                                                            color: AppColors
                                                                .signColor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : const NoDataPage(text: 'Your cart is empty! :/');
          },
        ),
      ]),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (CartController) {
          return Container(
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
            child: CartController.getItems.length > 0
                ? Row(
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
                        child: Row(
                          children: [
                            SizedBox(width: Dimentions.width10 / 2),
                            BigText(
                                text:
                                    '\$${CartController.totalAmount.toString()}'),
                            SizedBox(width: Dimentions.width10 / 2),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (Get.find<AuthController>().userLoggedIn()) {
                            CartController.addToHistory();
                          } else {
                            Get.toNamed(RouteHelper.getSignInPage());
                          }
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
                            text: 'Checkout',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          );
        },
      ),
    );
  }
}

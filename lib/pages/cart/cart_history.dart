import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_delivery_v0/base/no_data_page.dart';

import 'package:food_delivery_v0/controllers/cart_controller.dart';
import 'package:food_delivery_v0/routes/route_helper.dart';
import 'package:food_delivery_v0/utils/app_constants.dart';
import 'package:food_delivery_v0/utils/colors.dart';
import 'package:food_delivery_v0/utils/dimentions.dart';
import 'package:food_delivery_v0/widgets/app_icon.dart';
import 'package:food_delivery_v0/widgets/big_text.dart';
import 'package:food_delivery_v0/widgets/small_text.dart';
import 'package:food_delivery_v0/models/cart_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseData = DateFormat('yyyy-MM-dd HH:mm:ss')
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseData.toString());
        var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
        outputDate = outputFormat.format(inputDate);
        return BigText(text: outputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      body: Column(
        children: [
          //Header or appbar
          Container(
            height: Dimentions.height10 * 10,
            color: AppColors.mainColor,
            width: double.infinity,
            padding: EdgeInsets.only(top: Dimentions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: 'Cart History', color: Colors.white),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                  backGroundColor: AppColors.yellowColor,
                ),
              ],
            ),
          ),
          //Body
          GetBuilder<CartController>(
            builder: (_cartController) {
              return _cartController.getCartHistoryList().length > 0
                  ? Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: Dimentions.height20,
                          left: Dimentions.width20,
                          right: Dimentions.width20,
                        ),
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(
                              // reverse: true,
                              children: [
                                for (int i = 0;
                                    i < cartItemsPerOrder.length;
                                    i++)
                                  Container(
                                    height: Dimentions.height30 * 4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        timeWidget(listCounter),
                                        SizedBox(
                                          height: Dimentions.height10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Wrap(
                                              direction: Axis.horizontal,
                                              children: List.generate(
                                                  itemsPerOrder[i], (index) {
                                                if (listCounter <
                                                    getCartHistoryList.length) {
                                                  listCounter++;
                                                }
                                                return index <= 2
                                                    ? Container(
                                                        height: Dimentions
                                                                .height20 *
                                                            4,
                                                        width:
                                                            Dimentions.width20 *
                                                                4,
                                                        margin: EdgeInsets.only(
                                                            right: Dimentions
                                                                    .width10 /
                                                                2),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(Dimentions
                                                                      .radius15 /
                                                                  2),
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(AppConstants
                                                                    .BASE_URL +
                                                                AppConstants
                                                                    .UPLOAD_URL +
                                                                getCartHistoryList[
                                                                        listCounter -
                                                                            1]
                                                                    .img!),
                                                          ),
                                                        ),
                                                        // child: const Text('Hi there'),
                                                      )
                                                    : Container();
                                              }),
                                            ),
                                            Container(
                                              height: 80,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  SmallText(
                                                    text: 'Total',
                                                    color: AppColors.titleColor,
                                                  ),
                                                  BigText(
                                                      text:
                                                          '${itemsPerOrder[i].toString()} ${itemsPerOrder[i] == 1 ? 'Item' : 'Items'}',
                                                      color:
                                                          AppColors.titleColor),
                                                  GestureDetector(
                                                    onTap: () {
                                                      var orderTime =
                                                          cartOrderTimeToList();
                                                      Map<int, CartModel>
                                                          moreOrder = {};
                                                      for (int j = 0;
                                                          j <
                                                              getCartHistoryList
                                                                  .length;
                                                          j++) {
                                                        if (getCartHistoryList[
                                                                    j]
                                                                .time ==
                                                            orderTime[i]) {
                                                          moreOrder.putIfAbsent(
                                                            getCartHistoryList[
                                                                    j]
                                                                .id!,
                                                            () => CartModel.fromJson(
                                                                jsonDecode(jsonEncode(
                                                                    getCartHistoryList[
                                                                        j]))),
                                                          );
                                                        }
                                                      }
                                                      Get.find<CartController>()
                                                          .setItems = moreOrder;
                                                      Get.find<CartController>()
                                                          .addToCartList();
                                                      Get.toNamed(
                                                        RouteHelper
                                                            .getCartPage(),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  Dimentions
                                                                      .width10,
                                                              vertical: Dimentions
                                                                      .height10 /
                                                                  2),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(Dimentions
                                                                      .radius15 /
                                                                  3),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: AppColors
                                                                  .mainColor)),
                                                      child: SmallText(
                                                        text: 'One more',
                                                        color:
                                                            AppColors.mainColor,
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
                                    margin: EdgeInsets.only(
                                        bottom: Dimentions.height20),
                                  ),
                              ]),
                        ),
                      ),
                    )
                  : const Expanded(
                      child: Center(
                        // height: MediaQuery.of(context).size.height / 1.5,
                        child: NoDataPage(
                          text: 'No Orders added yet',
                          imgPath: 'assets/image/empty_box.png',
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}

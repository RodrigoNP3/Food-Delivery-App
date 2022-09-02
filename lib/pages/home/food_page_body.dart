import 'package:flutter/material.dart';
import 'package:food_delivery_v0/controllers/popular_product_controller.dart';
import 'package:food_delivery_v0/controllers/recommended_product_controller.dart';
import 'package:food_delivery_v0/pages/food/popular_food_detail.dart';
import 'package:food_delivery_v0/routes/route_helper.dart';
import 'package:food_delivery_v0/utils/app_constants.dart';
import 'package:food_delivery_v0/utils/colors.dart';
import 'package:food_delivery_v0/utils/dimentions.dart';
import 'package:food_delivery_v0/widgets/big_text.dart';
import 'package:food_delivery_v0/widgets/icon_and_text_widget.dart';
import 'package:food_delivery_v0/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../../widgets/app_column.dart';
import '/utils/dimentions.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  //85% the percentage that each item will be displayed at the center of the screen
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimentions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      //page controler is the number of the item that is been showed, it is a double, and is refreshed during the swith of pages.
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Slider Section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          //GetBuilder is equivalent to consumer
          return popularProducts.isLoaded
              ? Container(
                  height: Dimentions.pageView,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: popularProducts.popularProductList.isEmpty
                        ? 1
                        : popularProducts.popularProductList.length,
                    itemBuilder: (context, position) {
                      return _buildPageItem(position,
                          popularProducts.popularProductList[position]);
                    },
                  ),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        //Dots
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return DotsIndicator(
              dotsCount: popularProducts.popularProductList.isEmpty
                  ? 1
                  : popularProducts.popularProductList.length,
              position: _currPageValue,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                // color: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            );
          },
        ), //Popular text
        //Popular text
        SizedBox(height: Dimentions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimentions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(width: Dimentions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26),
              ),
              SizedBox(width: Dimentions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: 'Food Pairing'),
              ),
            ],
          ),
        ),
        //Recommended food
        //List of food and images
        GetBuilder<RecommendedProductController>(
          builder: (recommendedProduct) {
            return recommendedProduct.isLoaded
                ? ListView.builder(
                    // Listview takes the height of the father, so if the father has no
                    //defined height you have to create a father that have, like a container.
                    shrinkWrap: true,
                    //makes listview take the minimum height to be created,
                    physics: const NeverScrollableScrollPhysics(),
                    // makes the list non scrowlable,
                    // each item is fixed and is part of the page
                    itemCount: recommendedProduct.recommendedProductList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                              RouteHelper.getRecommendedFood(index, 'home'));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: Dimentions.width20,
                            right: Dimentions.width20,
                            bottom: Dimentions.height10,
                          ),
                          child: Row(
                            children: [
                              //Image section
                              Container(
                                width: Dimentions.listViewImgSize,
                                height: Dimentions.listViewImgSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimentions.radius20),
                                  color: Colors.white38,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(AppConstants.BASE_URL +
                                        AppConstants.UPLOAD_URL +
                                        recommendedProduct
                                            .recommendedProductList[index]
                                            .img!),
                                  ),
                                ),
                              ),
                              //Text container
                              Expanded(
                                child: Container(
                                  height: Dimentions.listViewTextSize,
                                  // width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimentions.radius20),
                                      bottomRight:
                                          Radius.circular(Dimentions.radius20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Dimentions.width10,
                                        right: Dimentions.width10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BigText(
                                            text: recommendedProduct
                                                .recommendedProductList[index]
                                                .name!),
                                        SizedBox(height: Dimentions.height10),
                                        SmallText(
                                            text:
                                                'Description Description Description Description Description Description'
                                            // recommendedProduct
                                            //     .recommendedProductList[index]
                                            //     .description!,
                                            ),
                                        SizedBox(height: Dimentions.height10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            IconAndTextWidget(
                                              icon: Icons.circle_sharp,
                                              text: 'Normal',
                                              iconColor: AppColors.iconColor1,
                                            ),
                                            IconAndTextWidget(
                                              icon: Icons.location_on,
                                              text: '1.70km',
                                              iconColor: AppColors.mainColor,
                                            ),
                                            IconAndTextWidget(
                                              icon: Icons.access_time_rounded,
                                              text: '32min',
                                              iconColor: AppColors.iconColor2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          },
        ),
        // ),
      ],
    );
  }

  Widget _buildPageItem(int index, popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * ((1 - currScale) / 2);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(1, currTrans, 1);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * ((1 - currScale) / 2);
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(1, currTrans, 1);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * ((1 - currScale) / 2);
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(1, currTrans, 1);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, 'home'));
            },
            child: Container(
              height: Dimentions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimentions.width10, right: Dimentions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.radius30),
                color: index.isEven
                    ? const Color(0xFF69c5df)
                    : const Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      popularProduct.img!),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimentions.pageTextContainer,
              margin: EdgeInsets.only(
                left: Dimentions.width30,
                right: Dimentions.width30,
                bottom: Dimentions.height30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.radius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    offset: Offset(5, 5),
                    blurRadius: 5.0,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimentions.height15,
                    left: Dimentions.height15,
                    right: 15),
                child: AppColumn(
                  text: popularProduct.name!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

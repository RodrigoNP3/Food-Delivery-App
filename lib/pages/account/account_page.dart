import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_delivery_v0/base/custom_loader.dart';
import 'package:food_delivery_v0/controllers/cart_controller.dart';
import 'package:food_delivery_v0/controllers/user_controller.dart';
import 'package:food_delivery_v0/pages/auth/auth_controller.dart';
import 'package:food_delivery_v0/routes/route_helper.dart';
import 'package:food_delivery_v0/utils/colors.dart';
import 'package:food_delivery_v0/utils/dimentions.dart';
import 'package:food_delivery_v0/widgets/account_widget.dart';

import 'package:food_delivery_v0/widgets/app_icon.dart';
import 'package:food_delivery_v0/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool _userLoggedIn = true;
    print('BUILD USER LOGGED IN');
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      print('USER IS LOGGED');
      Get.find<UserController>();
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         print('clicked');

        //         Get.find<AuthController>().clearSharedData();
        //         Get.find<CartController>().clear();
        //         Get.find<CartController>().clearCartHistory();
        //         Get.offNamed(RouteHelper.getSignInPage());
        //       },
        //       icon: Icon(Icons.logout))
        // ],
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: 'Profile',
          size: 24,
          color: Colors.white,
        ),
      ),
      body: _userLoggedIn
          ? GetBuilder<UserController>(
              builder: (userController) {
                return (!userController.isLoading
                    ? Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: Dimentions.height20),
                        child: Column(
                          children: [
                            //Profille icon
                            AppIcon(
                              icon: Icons.person,
                              backGroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize: Dimentions.height15 * 5,
                              size: Dimentions.height15 * 10,
                            ),
                            SizedBox(height: Dimentions.height20),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    //Name
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.person,
                                        backGroundColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimentions.height10 * 5 / 2,
                                        size: Dimentions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: userController.userModel.name,
                                      ),
                                    ),
                                    SizedBox(height: Dimentions.height20),
                                    //Phone
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.phone,
                                        backGroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimentions.height10 * 5 / 2,
                                        size: Dimentions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: userController.userModel.phone,
                                      ),
                                    ),
                                    SizedBox(height: Dimentions.height20),
                                    //Email
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.email,
                                        backGroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimentions.height10 * 5 / 2,
                                        size: Dimentions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: userController.userModel.email,
                                      ),
                                    ),
                                    SizedBox(height: Dimentions.height20),
                                    //Address
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on,
                                        backGroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimentions.height10 * 5 / 2,
                                        size: Dimentions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: 'Fill in your location',
                                      ),
                                    ),
                                    SizedBox(height: Dimentions.height20),
                                    //Message
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.message_outlined,
                                        backGroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        iconSize: Dimentions.height10 * 5 / 2,
                                        size: Dimentions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: 'Messages',
                                      ),
                                    ),
                                    SizedBox(height: Dimentions.height20),
                                    //Logout
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<AuthController>()
                                            .userLoggedIn()) {
                                          Get.find<AuthController>()
                                              .clearSharedData();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>()
                                              .clearCartHistory();
                                          Get.offNamed(
                                              RouteHelper.getSignInPage());
                                        }
                                        null;
                                      },
                                      child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.logout,
                                          backGroundColor: Colors.redAccent,
                                          iconColor: Colors.white,
                                          iconSize: Dimentions.height10 * 5 / 2,
                                          size: Dimentions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                          text: 'Logout',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const CustomLoader());
              },
            )
          : Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Sign in image
                    Container(
                      width: double.maxFinite,
                      height: Dimentions.height20 * 8,
                      margin: EdgeInsets.only(
                          left: Dimentions.width20, right: Dimentions.width20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimentions.radius20),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              AssetImage('assets/image/signintocontinue.png'),
                        ),
                      ),
                    ),
                    //Sign in button
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getSignInPage());
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: Dimentions.height20 * 5,
                        margin: EdgeInsets.only(
                            left: Dimentions.width20,
                            right: Dimentions.width20),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius20),
                        ),
                        child: Center(
                          child: BigText(
                            text: 'Sign in',
                            color: Colors.white,
                            size: Dimentions.font26,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

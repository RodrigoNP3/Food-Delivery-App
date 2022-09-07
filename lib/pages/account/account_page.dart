import 'package:flutter/material.dart';
import 'package:food_delivery_v0/utils/colors.dart';
import 'package:food_delivery_v0/utils/dimentions.dart';
import 'package:food_delivery_v0/widgets/account_widget.dart';
import 'package:food_delivery_v0/widgets/app_column.dart';
import 'package:food_delivery_v0/widgets/app_icon.dart';
import 'package:food_delivery_v0/widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: 'Profile',
          size: 24,
          color: Colors.white,
        ),
      ),
      body: Container(
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
                        text: 'Rodrigo',
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
                        text: '81 99813859',
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
                        text: 'rodrigo_np@outlook.com',
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
                        text: 'Recife - Pernambuco',
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
                        text: 'Message',
                      ),
                    ),
                    SizedBox(height: Dimentions.height20),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.person,
                        backGroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimentions.height10 * 5 / 2,
                        size: Dimentions.height10 * 5,
                      ),
                      bigText: BigText(
                        text: 'Rodrigo',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

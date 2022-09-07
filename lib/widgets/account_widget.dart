import 'package:flutter/material.dart';
import 'package:food_delivery_v0/utils/dimentions.dart';
import 'package:food_delivery_v0/widgets/app_icon.dart';
import 'package:food_delivery_v0/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;

  AccountWidget({
    Key? key,
    required this.appIcon,
    required this.bigText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Dimentions.width20,
        top: Dimentions.height10,
        bottom: Dimentions.height10,
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimentions.width20),
          bigText,
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}

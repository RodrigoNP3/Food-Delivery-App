import 'package:flutter/material.dart';
import 'package:food_delivery_v0/widgets/big_text.dart';
import 'package:food_delivery_v0/widgets/icon_and_text_widget.dart';
import 'package:food_delivery_v0/utils/colors.dart';
import 'package:food_delivery_v0/widgets/small_text.dart';
import 'package:food_delivery_v0/utils/dimentions.dart';

class AppColumn extends StatelessWidget {
  final String text;

  const AppColumn({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BigText(
          text: text,
          size: Dimentions.font26,
          color: AppColors.mainBlackColor,
        ),
        SizedBox(height: Dimentions.height10),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Wrap(
              // Wrap create a row of iqual widgets
              children: List.generate(
                5,
                (index) => Icon(
                  // if you use {} instead of => you HAVE to return something
                  Icons.star,
                  color: AppColors.mainColor,
                  size: 15,
                ),
              ),
            ),
            const SizedBox(width: 10),
            SmallText(text: '4.5'),
            const SizedBox(width: 10),
            SmallText(text: '1287 Coments'),
          ],
        ),
        SizedBox(height: Dimentions.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
              icon: Icons.circle_sharp,
              text: 'Normal',
              iconColor: AppColors.iconColor1,
            ),
            IconAndTextWidget(
              icon: Icons.location_on,
              text: '1.70 km',
              iconColor: AppColors.mainColor,
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: '32 min',
              iconColor: AppColors.iconColor2,
            ),
          ],
        ),
      ],
    );
  }
}

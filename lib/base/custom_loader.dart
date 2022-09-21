import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:food_delivery_v0/utils/dimentions.dart';

// import '../pages/auth/auth_controller.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('I am printing a loading state ${Get.find<AuthController>().isLoading.toString()}');
    return Center(
      child: Container(
        height: Dimentions.height20 * 5,
        width: Dimentions.width20 * 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Dimentions.radius20 * 5 / 2,
          ),
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}

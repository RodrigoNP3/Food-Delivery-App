import 'package:flutter/material.dart';

// import '../pages/auth/auth_controller.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Dimentions.height20 * 5,
      // width: Dimentions.width20 * 5,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(
      //     Dimentions.radius20 * 5 / 2,
      //   ),
      // ),
      // alignment: Alignment.center,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}

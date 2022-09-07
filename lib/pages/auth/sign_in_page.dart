import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_v0/pages/auth/sign_up_page.dart';
import 'package:food_delivery_v0/utils/colors.dart';
import 'package:food_delivery_v0/utils/dimentions.dart';
import 'package:food_delivery_v0/widgets/app_text_field.dart';
import 'package:food_delivery_v0/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimentions.screenHeight * 0.05),
            //App logo
            Container(
              // color: Colors.redAccent,
              height: Dimentions.screenHeight * 0.25,
              child: const Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/image/logo part 1.png'),
                ),
              ),
            ),
            //Welcome Section
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(left: Dimentions.width20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello',
                    style: TextStyle(
                      fontSize: Dimentions.font20 * 7 / 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Sign into your account',
                    style: TextStyle(
                      fontSize: Dimentions.font20,
                      color: Colors.grey[500],
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimentions.height20),
            //Email textfield
            AppTextField(
              textController: emailController,
              hintText: 'Email',
              icon: Icons.email,
            ),
            SizedBox(height: Dimentions.height20),
            //Password textfield
            AppTextField(
              textController: passwordController,
              hintText: 'Password',
              icon: Icons.password,
            ),
            SizedBox(height: Dimentions.height20),
            //Sign into your account
            Row(
              children: [
                Expanded(child: Container()),
                RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.back(),
                    text: 'Sign into your account',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimentions.font20,
                    ),
                  ),
                ),
                SizedBox(width: Dimentions.width20),
              ],
            ),
            SizedBox(height: Dimentions.height20 * 2),
            //Sign Ip bottom
            Container(
              width: Dimentions.screenWidth / 2,
              height: Dimentions.screenHeight / 13,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(Dimentions.radius30),
              ),
              child: Center(
                child: BigText(
                  text: 'Sign In',
                  size: Dimentions.font20 * 3 / 2,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: Dimentions.screenHeight * 0.05),
            //Dont have an account?
            RichText(
              text: TextSpan(
                  text: 'Don\'t have an account? ',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimentions.font20,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => const SignUpPage(),
                            transition: Transition.fade),
                      text: 'Create',
                      style: TextStyle(
                        color: AppColors.mainBlackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimentions.font20,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

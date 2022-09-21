import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_v0/base/show_custom_snackbar.dart';
import 'package:food_delivery_v0/models/signup_body_model.dart';
import 'package:food_delivery_v0/pages/auth/auth_controller.dart';
import 'package:food_delivery_v0/pages/auth/sign_in_page.dart';
import 'package:food_delivery_v0/utils/colors.dart';
import 'package:food_delivery_v0/utils/dimentions.dart';
import 'package:food_delivery_v0/widgets/app_text_field.dart';
import 'package:food_delivery_v0/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/custom_loader.dart';
import '../../routes/route_helper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    const signUpImages = [
      't.png',
      'f.png',
      'g.png',
    ];

    void _registration(AuthController authController) {
      // var authController = Get.find<AuthController>();

      String name = nameController.text.trim();
      String password = passwordController.text.trim();
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();

      if (name.isEmpty) {
        ShowCustomSnackBar('Type in your name', title: 'Name');
      } else if (phone.isEmpty) {
        ShowCustomSnackBar('Type in your phone number', title: 'Phone Number');
      } else if (email.isEmpty) {
        ShowCustomSnackBar('Type in your email address', title: 'Email Adress');
      } else if (!GetUtils.isEmail(email)) {
        ShowCustomSnackBar('Type valid email address', title: 'Email Adress');
      } else if (password.isEmpty) {
        ShowCustomSnackBar('Type in your password', title: 'Password');
      } else if (password.length < 6) {
        ShowCustomSnackBar('Type a password longer then six characters',
            title: 'Password');
      } else {
        // ShowCustomSnackBar('You are perfect', title: 'Perfect');
        SignUpBody signUpBody = SignUpBody(
          name: name,
          email: email,
          password: password,
          phone: phone,
        );
        authController.registration(signUpBody).then(
          (status) {
            if (status.isSuccess) {
              print('Success registration');
              ShowCustomSnackBar('You are perfect', title: 'Perfect');
              Get.toNamed(RouteHelper.getInitial());
            } else {
              ShowCustomSnackBar(status.message);
            }
          },
        );
      }
    }

    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 233, 192, 192),
      body: GetBuilder<AuthController>(
        builder: (_authController) {
          return !_authController.isLoading
              ? SingleChildScrollView(
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
                            backgroundImage:
                                AssetImage('assets/image/logo part 1.png'),
                          ),
                        ),
                      ),
                      //Name textfield
                      AppTextField(
                        textController: nameController,
                        hintText: 'Name',
                        icon: Icons.person,
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
                        isObscure: true,
                        textController: passwordController,
                        hintText: 'Password',
                        icon: Icons.password,
                      ),
                      SizedBox(height: Dimentions.height20),
                      //Phone textfield
                      AppTextField(
                        textController: phoneController,
                        hintText: 'Phone',
                        icon: Icons.phone,
                      ),
                      SizedBox(height: Dimentions.height20 * 2),
                      //Sign Up bottom
                      GestureDetector(
                        onTap: () {
                          _registration(_authController);
                        },
                        child: Container(
                          width: Dimentions.screenWidth / 2,
                          height: Dimentions.screenHeight / 13,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimentions.radius30),
                          ),
                          child: Center(
                            child: BigText(
                              text: 'Sign Up',
                              size: Dimentions.font20 * 3 / 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimentions.height10),
                      //Have an account text button
                      RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(const SignInPage(),
                                transition: Transition.fade),
                          text: 'Have an account already?',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimentions.font20,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimentions.screenHeight * 0.05),
                      //Sign Up methods
                      RichText(
                        text: TextSpan(
                          text: 'Sign Up  using one of the following methods',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimentions.font16,
                          ),
                        ),
                      ),
                      //Sign up methods icons
                      Wrap(
                        spacing: Dimentions.width10 * 2,
                        children: List.generate(
                          3,
                          (index) => CircleAvatar(
                            radius: Dimentions.radius30,
                            backgroundImage: AssetImage(
                                'assets/image/${signUpImages[index]}'),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const CustomLoader();
        },
      ),
    );
  }
}

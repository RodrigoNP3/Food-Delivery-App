import 'dart:developer';
import 'package:food_delivery_v0/data/repository/auth_repo.dart';
import 'package:food_delivery_v0/models/response_model.dart';
import 'package:food_delivery_v0/models/signup_body_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController implements Service {
  final AuthRepo authRepo;

  AuthController({
    required this.authRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async {
    print('Gerting User Token');
    print(authRepo.getUserToken().toString());
    _isLoading = true;
    update();
    Response response = await authRepo.login(email, password);
    print('response ${response.statusCode.toString()}');
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      print('Backend token 3');
      authRepo.saveUserToken(response.body['token']);
      print('TOKEN: ${response.body['token'].toString()}');
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      print('Backend token 4');
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }
}
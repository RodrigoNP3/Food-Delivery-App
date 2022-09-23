import 'dart:developer';

import 'package:food_delivery_v0/data/repository/user_repo.dart';
import 'package:food_delivery_v0/models/response_model.dart';

import 'package:food_delivery_v0/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements Service {
  final UserRepo userRepo;

  UserController({
    required this.userRepo,
  });

  bool _isLoading = false;
  late UserModel _userModel;
  bool get isLoading => _isLoading;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print(response.body);
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, 'Successfully');
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}

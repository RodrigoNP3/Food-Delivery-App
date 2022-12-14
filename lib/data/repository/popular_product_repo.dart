import 'dart:convert';

import 'package:food_delivery_v0/data/api/api_client.dart';
import 'package:food_delivery_v0/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({
    required this.apiClient,
  });

  Future<dynamic> getPopulatProductList() async {
    var response = await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
    print(
        'popular repo response status code: ${response.statusCode.toString()}');
    return response;
  }
}

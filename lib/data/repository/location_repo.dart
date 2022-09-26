import 'package:flutter/cupertino.dart';
import 'package:food_delivery_v0/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> getAddressFromGeocode(LatLng latlang) async {
    return await apiClient.getData(
        '${AppConstants.GEOCODE_URI}${latlang.latitude},${latlang.longitude}');
  }
}

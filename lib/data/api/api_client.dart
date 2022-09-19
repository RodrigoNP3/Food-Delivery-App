import 'package:food_delivery_v0/utils/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;

  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String url, {Map<String, String>? headers}) async {
    try {
      Response response = await get(
        url,
        headers: headers ?? _mainHeaders,
      );
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    print('${body.toString()}');
    try {
      Response response = await post(uri, body, headers: _mainHeaders);
      // print('Api cliente post data response: ${response.statusCode}');
      print('postaData: ${response.body.toString()}');
      return response;
    } catch (e) {
      print('DEU ERRO CARAIO: ${e.toString()}');
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}

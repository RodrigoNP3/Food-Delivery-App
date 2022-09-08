class AppConstants {
  static const String APP_NAME = 'DBFood';
  static const int APP_VERSION = 1;

  static const String BASE_URL = 'http://10.0.2.2:8000'; //android
  // static const String BASE_URL = 'http://127.0.0.1:8000';
  // static const String BASE_URL = 'http://mvs.bslmeiyu.com';
  static const String POPULAR_PRODUCT_URI = '/api/v1/products/popular';
  static const String RECOMMENDED_PRODUCT_URI = '/api/v1/products/recommended';
  static const String DRINKS_URI = '/api/v1/products/drinks';
  static const String UPLOAD_URL = '/uploads/';

  //Auth endpoints
  static const String REGISTRATION_URI = '/api/v1/auth/register';

  static const String TOKEN = 'DBtoken';
  static const String CART_LIST = 'Cart-list';
  static const String CART_HISTORY_LIST = 'Cart-history-list';
}

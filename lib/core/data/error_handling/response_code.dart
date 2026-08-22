class ResponseCode {


  ///local status code in app
  static int connectTimeOut = -1;
  static int canceled = -2;
  static int receiveTimeOut = -3;
  static int sendTimeOut = -4;
  static int cacheError = -5;
  static int noInternetConnection = -6;
  static int defaultError = -7;
  static const int badCertificate = -8;
  static const int unknown = -9;
  static const int walletEmpty = -10;

  //location
  static const int serviceDisabled = -66;
  static const int permissionDenied = -67;
  static const int permissionDeniedForever = -68;
}

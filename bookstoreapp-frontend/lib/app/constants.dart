class Constant {
  static const String baseURL = "http://10.0.2.2:4000";

//for phone
  // static const String baseURL = "http://172.26.1.89:4000/";

  //fortesting
  // static const String baseURL = "http://localhost:4000/";

  // //gharko
  // static const String baseURL = "http://192.168.101.4:4000/books";

  // For iOS
  // static const String baseURL = "http://172.26.1.89:4000/";

// Block E
  // static const String baseURL = "http://10.12.2.200:4000/";

  // wear os : adb -d forward tcp:5601 tcp:5601

  // ----------------Student URL----------------
  static const String userLoginURL = "/api/user/loginuser";
  static const String regitserURL = "/api/user/registeruser";
  static const String productURL = "/api/product/";
  static const String getuser = "/api/users";
  static const String createorder = "api/order/createOrder/";
  static const String order = "api/order/";
  static const String getorder = "/api/order/getorder";
  static const String userImageURL = "http://10.0.2.2:3000";
  // For storing token or you can store token in shared preferences
  static String token = "";
  static String usserid = "";
  static String Productid = "";
}

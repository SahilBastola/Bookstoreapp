import 'package:ebuy/controller/Cart_controller.dart';
import 'package:ebuy/controllers/favorite_controller.dart';
import 'package:get/get.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
     Get.lazyPut(() => FavoriteController());
  }
}
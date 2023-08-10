import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ebuy/model/product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  List<Product> CartItem = [];

  // Method for adding item into walletFood List
  void add({
    required id,
    required title,
    Productid,
    desc,
    img,
    author,
    price,
  }) {
    var contain = CartItem.where((element) => element.productid == Productid);
    if (contain.isEmpty) {
      CartItem.add(Product(
        pId: id,
        title: title,
        productid: Productid,
        desc: desc,
        img: img,
        price: price,
        Author: author,
      ));
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 1,
              channelKey: 'basic_channel',
              title: 'eBuy',
              body: 'Successsfully Added'));
      update();
    } else {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 1,
              channelKey: 'basic_channel',
              title: 'eBuy',
              body: 'Alredy in cart'));
    }
  }

  // Method for removing all items from the walletFood List
  void removeAllItems() {
    CartItem = [];
    update();
  }

  // Method for removing single item from walletFood List
  void removeSingleItem(int index) {
    CartItem.removeAt(index);
    update();
  }

  // Method For Calculating Total Price of foods
  double totalAmount() {
    var sumPrice = 0.0;

    for (Product cartItem in CartItem) {
      int price = int.parse("${cartItem.price}");
      sumPrice = sumPrice + price;
      //  walletFood.cheapestPrice ;
    }
    return sumPrice;
  }
}

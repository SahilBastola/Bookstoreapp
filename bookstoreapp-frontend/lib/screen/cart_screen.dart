import 'package:animate_do/animate_do.dart';
import 'package:ebuy/controller/Cart_controller.dart';
import 'package:ebuy/repository/order_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPageScreen extends StatefulWidget {
  const CartPageScreen({Key? key}) : super(key: key);

  @override
  State<CartPageScreen> createState() => _CartPageScreenState();
}

class _CartPageScreenState extends State<CartPageScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(CartController());
  }

  _updateUserPoints(int pointsToAdd) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentPoints = prefs.getInt('userPoints') ?? 0;
    int updatedPoints = currentPoints + pointsToAdd;
    await prefs.setInt('userPoints', updatedPoints);
  }

  _Order(Prodiutid) async {
    try {
      int status = await OrderRepositoryImpl().addOrderhostel(Prodiutid);
      if (status == 1) {
        MotionToast.success(
                description: const Text("Order Successful"), onClose: () {})
            .show(context);
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      MotionToast.success(
          description: const Text("Order Successful"),
          onClose: () {
            MotionToast.success(
                description: const Text("10 Xp Rewarded"),
                onClose: () {
                  _updateUserPoints(10);
                }).show(context);
          }).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            appBar: const MyAppBar(),
            body: Container(
              color: const Color.fromARGB(227, 250, 245, 245),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        width: w,
                        height: h / 20,
                        // color: Colors.yellow,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: w / 3,
                              height: h / 24,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: const Color.fromARGB(255, 40, 38, 38)),
                              child: Center(
                                  child: Text(
                                "Total Item : ${cartController.CartItem.length}",
                                style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )),
                            ),
                            Container(
                              width: w / 1.8,
                              height: h / 24,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: const Color.fromARGB(255, 38, 36, 36)),
                              child: Center(
                                  child: Text(
                                "Total Price : Rs ${cartController.totalAmount().toStringAsFixed(2)}",
                                style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )),
                            )
                          ],
                        )),
                    SizedBox(
                      width: w,
                      height: h / 1.65,
                      child: ListView.builder(
                        itemCount: cartController.CartItem.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            child: SizedBox(
                              width: w,
                              height: h / 4.5,
                              child: Stack(children: [
                                Positioned(
                                  top: 20,
                                  right: 0,
                                  child: FadeInLeft(
                                    delay: Duration(
                                        milliseconds:
                                            (index / 0.5 * 100).toInt()),
                                    child: Container(
                                      width: w / 1.3,
                                      height: h / 6,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 7, 64, 164),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 221, 219, 219),
                                                spreadRadius: 3,
                                                blurRadius: 10,
                                                offset: Offset(-7, 11))
                                          ]),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 3,
                                  child: FadeInLeft(
                                    delay: Duration(
                                        milliseconds:
                                            (index / 0.5 * 200).toInt()),
                                    child: Spin(
                                      delay: Duration(
                                          milliseconds:
                                              (index / 0.5 * 250).toInt()),
                                      child: SizedBox(
                                        width: w / 2.5,
                                        height: h / 5,
                                        child: Hero(
                                          tag: cartController
                                              .CartItem[index].pId,
                                          child: Image.network(
                                            cartController
                                                    .CartItem[index].img ??
                                                "",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 170,
                                  top: 40,
                                  child: FadeInLeft(
                                    delay: Duration(
                                        milliseconds:
                                            (index / 0.5 * 300).toInt()),
                                    child: Text(
                                      "${cartController.CartItem[index].title}",
                                      style: GoogleFonts.oxygen(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 171,
                                  top: 68,
                                  child: FadeInLeft(
                                    delay: Duration(
                                        milliseconds:
                                            (index / 0.5 * 400).toInt()),
                                    child: Text(
                                      "${cartController.CartItem[index].desc}",
                                      style: GoogleFonts.oxygen(
                                          color: const Color.fromARGB(
                                              255, 16, 14, 14),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 171,
                                  top: 95,
                                  child: FadeInLeft(
                                    delay: Duration(
                                        milliseconds:
                                            (index / 0.5 * 500).toInt()),
                                    child: Text(
                                      "Rs ${cartController.CartItem[index].price}",
                                      style: GoogleFonts.oxygen(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 25,
                                    right: 20,
                                    child: FadeInRight(
                                      delay: Duration(
                                          milliseconds:
                                              (index / 0.5 * 700).toInt()),
                                      child: Spin(
                                        delay: Duration(
                                            milliseconds:
                                                (index / 0.5 * 800).toInt()),
                                        child: IconButton(
                                            onPressed: () {
                                              Get.defaultDialog(
                                                  barrierDismissible: false,
                                                  title: "Warning!",
                                                  content: const Text(
                                                    "Do you really wanna remove this Item from this list?",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  confirmTextColor:
                                                      Colors.white,
                                                  onCancel: () {},
                                                  onConfirm: () {
                                                    setState(() {
                                                      cartController
                                                          .removeSingleItem(
                                                              index);
                                                      Get.back();
                                                    });
                                                  });
                                            },
                                            icon: const Icon(
                                              LineIcons.times,
                                              color: Colors.red,
                                            )),
                                      ),
                                    )),
                                Positioned(
                                  bottom: 1,
                                  right: 20,
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    onPressed: () {
                                      print(cartController
                                          .CartItem[index].productid);
                                      _Order(cartController
                                          .CartItem[index].productid);
                                    },
                                    minWidth: w / 2,
                                    height: h / 14,
                                    color:
                                        const Color.fromARGB(255, 7, 64, 164),
                                    child: Text(
                                      "Buy Now",
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}

/// MyAppBar Widget Components
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(55);
  @override
  Widget build(BuildContext context) {
    var walletController = Get.find<CartController>();
    return AppBar(
      elevation: 3,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(
          Icons.menu_rounded,
          color: Color.fromARGB(211, 52, 50, 50),
          size: 35,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
        GetBuilder<CartController>(builder: (context) {
          return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: () {
                  Get.defaultDialog(
                      barrierDismissible: false,
                      title: "Warning!",
                      content: const Text(
                        "Do you really wanna remove all items from this list?",
                        textAlign: TextAlign.center,
                      ),
                      confirmTextColor: Colors.white,
                      onCancel: () {},
                      onConfirm: () {
                        walletController.removeAllItems();
                        Get.back();
                      });
                },
                icon: const Icon(
                  LineIcons.alternateTrash,
                  color: Color.fromARGB(112, 54, 50, 50),
                  size: 35,
                ),
              ));
        }),
      ],
    );
  }
}

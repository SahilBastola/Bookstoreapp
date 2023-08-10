import 'package:animate_do/animate_do.dart';
import 'package:ebuy/controller/Cart_controller.dart';
import 'package:ebuy/controllers/favorite_controller.dart';
import 'package:ebuy/screen/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(FavoriteController());
  }

  @override
  Widget build(BuildContext context) {
    var favoritecontroller = Get.find<FavoriteController>();
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 4,
              backgroundColor: const Color.fromARGB(255, 7, 64, 164),
              foregroundColor: Colors.white,
              title: const Text("Favorite"),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings_rounded),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: w,
                    height: h / 1.65,
                    child: ListView.builder(
                      itemCount: favoritecontroller.CartItem.length,
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
                                        tag: favoritecontroller
                                            .CartItem[index].pId,
                                        child: Image.network(
                                          favoritecontroller
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
                                    "${favoritecontroller.CartItem[index].title}",
                                    style: GoogleFonts.oxygen(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
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
                                    "${favoritecontroller.CartItem[index].desc}",
                                    style: GoogleFonts.oxygen(
                                        color:
                                            const Color.fromARGB(255, 2, 2, 2),
                                        fontWeight: FontWeight.w300,
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
                                    "Rs ${favoritecontroller.CartItem[index].price}",
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
                                                confirmTextColor: Colors.white,
                                                onCancel: () {},
                                                onConfirm: () {
                                                  setState(() {
                                                    favoritecontroller
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
                            ]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
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
          color: Colors.black,
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
                  LineIcons.trash,
                  color: Colors.red,
                  size: 35,
                ),
              ));
        }),
      ],
    );
  }
}

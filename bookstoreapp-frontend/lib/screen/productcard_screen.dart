import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductCardScreen extends StatelessWidget {
  String img;
  ProductCardScreen(this.img);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: const Color.fromARGB(9, 200, 212, 211),
            child: Stack(
              children: [
                InkWell(
                  onTap: () {},
                  child: Image.network(
                    "https://www.getnow.pk/wp-content/uploads/2018/03/Rich-dad-poor-dad.png",
                    fit: BoxFit.cover,
                    height: 230,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    // decoration: BoxDecoration(
                    //     color: const Color.fromARGB(255, 190, 205, 190),
                    //     borderRadius: BorderRadius.circular(20)),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

import 'package:ebuy/utils/color.dart';
import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  var text = "Login";

  HeaderContainer(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [orangeColors, orangeLightColors],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 10,
              right: 160,
              child: Text(
                text,
                style: const TextStyle(
                    color: Color.fromRGBO(6, 214, 197, 0.77),
                    fontSize: 30,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w900),
              )),
          Center(
            child: Image.asset("asset/image/ebuylogo.png"),
          ),
        ],
      ),
    );
  }
}

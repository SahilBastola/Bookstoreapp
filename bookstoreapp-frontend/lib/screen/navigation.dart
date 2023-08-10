import 'package:ebuy/screen/cart_screen.dart';
import 'package:ebuy/screen/home_screen.dart';
import 'package:ebuy/screen/productpage.dart';
import 'package:ebuy/screen/profileScreen.dart';
import 'package:flutter/material.dart';

class Navifation extends StatefulWidget {
  final int totalPoints;
  const Navifation({super.key, required this.totalPoints});

  @override
  State<Navifation> createState() => _NavifationState();
}

class _NavifationState extends State<Navifation> {
  int _selectedIndex = 0;

  List<Widget> lstBottomScreen = [
    const HomeScreen(),
    const ProductPage(),
    const CartPageScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey(),
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          // BottomNavigationBarItem(icon: Icon(Icons.note), label: 'About'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books_outlined), label: 'Product'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_checkout), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined), label: 'Profile'),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 7, 64, 164),
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

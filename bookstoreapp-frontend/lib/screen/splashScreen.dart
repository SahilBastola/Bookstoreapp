import 'dart:async';

import 'package:ebuy/pages/login_page.dart';
import 'package:ebuy/screen/navigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<int> _getUserPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userPoints') ?? 0;
  }

  _updateUserPoints(int pointsToAdd) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentPoints = prefs.getInt('userPoints') ?? 0;
    int updatedPoints = currentPoints + pointsToAdd;
    await prefs.setInt('userPoints', updatedPoints);
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => _getDataFromSharedPref());
  }

  _getDataFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString("username");
    if (username == "") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
    } else {
      await _updateUserPoints(0);
      int totalPoints = await _getUserPoints();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Navifation(totalPoints: totalPoints),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 7, 64, 164),
                Color.fromARGB(255, 63, 118, 237),
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  "asset/image/logo.png",
                  height: 300.0,
                  width: 300.0,
                ),
                const Text(
                  "BookMania",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 1, 23, 22),
                    fontWeight: FontWeight.bold,
                    fontSize: 45.0,
                  ),
                ),
              ],
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}

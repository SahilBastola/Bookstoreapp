import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserLevel { Diamond, Gold, Silver, Bronze, NoLevel }

class PointsPage extends StatefulWidget {
  const PointsPage({Key? key}) : super(key: key);

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  late int userPoints;
  late UserLevel userLevel;
  late String userPrivilege;

  @override
  void initState() {
    _getUserPoints();
    super.initState();
  }

  _getUserPoints() async {
    int points = await _getUserPointsFromStorage();
    UserLevel level = _calculateUserLevel(points);
    String privilege = _calculateUserPrivilege(level);

    setState(() {
      userPoints = points;
      userLevel = level;
      userPrivilege = privilege;
    });
  }

  Future<int> _getUserPointsFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userPoints') ?? 0;
  }

  UserLevel _calculateUserLevel(int points) {
    if (points > 1500) {
      return UserLevel.Diamond;
    } else if (points > 800) {
      return UserLevel.Gold;
    } else if (points > 500) {
      return UserLevel.Silver;
    } else if (points > 100) {
      return UserLevel.Bronze;
    } else {
      return UserLevel.NoLevel;
    }
  }

  String _calculateUserPrivilege(UserLevel level) {
    switch (level) {
      case UserLevel.Diamond:
        return "10% Discount";
      case UserLevel.Gold:
        return "5% Discount";
      case UserLevel.Silver:
        return "3% Discount";
      case UserLevel.Bronze:
        return "1% Discount";
      default:
        return "No Privileges Yet";
    }
  }

  String _getLevelTitle(UserLevel level) {
    switch (level) {
      case UserLevel.Diamond:
        return "Diamond Level";
      case UserLevel.Gold:
        return "Gold Level";
      case UserLevel.Silver:
        return "Silver Level";
      case UserLevel.Bronze:
        return "Bronze Level";
      default:
        return "No Level Yet";
    }
  }

  Color _getLevelColor(UserLevel level) {
    switch (level) {
      case UserLevel.Diamond:
        return Colors.blue;
      case UserLevel.Gold:
        return Colors.amber;
      case UserLevel.Silver:
        return Colors.grey;
      case UserLevel.Bronze:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Points Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.stars,
              size: 80,
              color: _getLevelColor(userLevel),
            ),
            const SizedBox(height: 16),
            Text(
              "$userPoints Points",
              style: GoogleFonts.oxygen(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _getLevelTitle(userLevel),
              style: GoogleFonts.oxygen(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: userPoints / 1500,
              color: _getLevelColor(userLevel),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              "Privilege: $userPrivilege",
              style: GoogleFonts.oxygen(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

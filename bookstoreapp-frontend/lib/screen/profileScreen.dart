// ignore_for_file: must_be_immutable
import 'package:animate_do/animate_do.dart';
import 'package:ebuy/model/user.dart';
import 'package:ebuy/pages/favoritepage.dart';
import 'package:ebuy/pages/login_page.dart';
import 'package:ebuy/repository/user_repo.dart';
import 'package:ebuy/screen/constant.dart';
import 'package:ebuy/screen/edit_profile.dart';
import 'package:ebuy/screen/googemaps/googlemaps.dart';
import 'package:ebuy/screen/order.dart';
import 'package:ebuy/screen/pointpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    _setDataToGetPref(String username, String password) async {
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("username", username);
        await prefs.setString("password", password);
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    ShakeDetector.autoStart(onPhoneShake: () {
      setState(() async {
        await _setDataToGetPref("", "");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (index) => const LoginPage(),
          ),
        );
      });
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          backgroundColor: const Color.fromARGB(255, 7, 64, 164),
          foregroundColor: const Color.fromARGB(255, 157, 154, 154),
          title: const Text("PROFILE"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings_rounded),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              // decoration change
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(),
                color: Color.fromARGB(124, 237, 224, 224),
              ),
              margin: const EdgeInsets.only(top: 10),
              width: w,
              height: h / 1.6,
              child: const SingleChildScrollView(
                child: Column(children: [
                  TopUserInfo(),
                  PurpleSection(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCompletionCard {
  final String title;
  final String buttonText;
  final IconData icon;
  ProfileCompletionCard({
    required this.title,
    required this.buttonText,
    required this.icon,
  });
}

class CustomListTile {
  final IconData icon;
  final String title;
  final Widget page;
  CustomListTile({required this.icon, required this.title, required this.page});
}

List<CustomListTile> customListTiles = [
  CustomListTile(
    icon: Icons.list,
    title: "Order",
    page: OrderPage(),
  ),
  CustomListTile(
    icon: Icons.location_on_outlined,
    title: "Location",
    page: const GoogleMaps(),
  ),
  CustomListTile(
    title: "Favorite",
    icon: CupertinoIcons.square_favorites,
    page: const FavoriteScreen(),
  ),
  CustomListTile(
    title: "Logout",
    icon: CupertinoIcons.arrow_right_arrow_left,
    page: const LoginPage(),
  ),
];

///Purple Section Widget Components
class PurpleSection extends StatefulWidget {
  const PurpleSection({
    Key? key,
  }) : super(key: key);

  @override
  State<PurpleSection> createState() => _PurpleSectionState();
}

class _PurpleSectionState extends State<PurpleSection> {
  _setDataToGetPref(String username, String password) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("username", username);
      await prefs.setString("password", password);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    ShakeDetector.waitForStart(onPhoneShake: () {
      setState(() async {
        await _setDataToGetPref("", "");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (index) => const LoginPage(),
          ),
        );
      });
    });

    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
            customListTiles.length,
            (index) {
              final tile = customListTiles[index];
              return InkWell(
                onTap: () async {
                  if (customListTiles[index] == "Logout") {
                    await _setDataToGetPref("", "");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (index) => const LoginPage(),
                      ),
                    );
                  } else {
                    await _setDataToGetPref("", "");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (index) => tile.page,
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Card(
                    color: const Color.fromARGB(255, 7, 64, 164),
                    elevation: 4,
                    shadowColor: Colors.orange,
                    child: ListTile(
                      leading: Icon(tile.icon, color: Colors.white),
                      title: Text(
                        tile.title,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

/// Components of Purple Section Widget Components
class ComponentsOfPurpleSection extends StatelessWidget {
  Text title;
  String subtitle;
  //
  ComponentsOfPurpleSection(
      {Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 400),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Container(
          margin: const EdgeInsets.only(top: 0, bottom: 0),
          width: w / 4,
          height: h / 2,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInUp(
                delay: const Duration(milliseconds: 450),
                child: title,
              ),
              const SizedBox(
                height: 10,
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 500),
                child: Text(subtitle,
                    style: const TextStyle(color: Colors.orange, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Top User Section Info Widget Components
class TopUserInfo extends StatefulWidget {
  const TopUserInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<TopUserInfo> createState() => _TopUserInfoState();
}

class _TopUserInfoState extends State<TopUserInfo> {
  late Future<int> userPointsFuture;

  @override
  void initState() {
    userPointsFuture = _getUserPoints();
    super.initState();
  }

  Future<int> _getUserPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userPoints') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<List<User>>(
            future: Userrepositoryimp().getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print(snapshot.data);
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error loading user data');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No user data available');
              } else {
                final user = snapshot.data![0];
                return Column(
                  children: [
                    const CircleAvatar(
                      radius: 60.0,
                      backgroundImage: NetworkImage(
                        "https://th.bing.com/th/id/R.88a6a68e235ccdb2e12f9573a296492d?rik=%2f8ojC8JRbK0mxQ&riu=http%3a%2f%2fclipground.com%2fimages%2fuser-icon-png-free-2.jpg&ehk=F%2fbwK6CA3%2bXvYOQmRwhQCMDldyyq6QIs0g5wf2hlfoU%3d&risl=&pid=ImgRaw&r=0",
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user.name ?? "",
                      style: GoogleFonts.oxygen(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      user.email ?? "",
                      style: GoogleFonts.oxygen(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        // Navigate to edit page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const EditProfile(), // Make sure EditProfile widget is properly defined
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Edit Profile',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 20),
          _buildUserPointsGrid(),
        ],
      ),
    );
  }

  Widget _buildUserPointsGrid() {
    return FutureBuilder<int>(
      future: userPointsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error loading user points');
        } else {
          final userPoints = snapshot.data ?? 0;
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: Colors.grey[200],
            child: Column(
              children: [
                const Text(
                  'XP Points:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$userPoints',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PointsPage(),
                            ),
                          );
                        },
                        child: const Text("View"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

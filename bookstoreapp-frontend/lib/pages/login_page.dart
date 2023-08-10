import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ebuy/pages/regi_page.dart';
import 'package:ebuy/repository/user_repo.dart';
import 'package:ebuy/screen/navigation.dart';
import 'package:ebuy/widgets/herder_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController(text: 'sahil');
  final _passwordController = TextEditingController(text: 'sahil@1997');
  bool? _hasBioSensor;
  LocalAuthentication authentication = LocalAuthentication();

  @override
  void initState() {
    _checkNotification();
    _checkBio();
    _getUserPoints();
    _updateLastLoginDate();
    _getLastLoginDate();
    super.initState();
  }

  Future<int> _getUserPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userPoints') ?? 0;
  }

  Future<void> _updateLastLoginDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt('lastLoginTimestamp', timestamp);
  }

  Future<DateTime?> _getLastLoginDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? timestamp = prefs.getInt('lastLoginTimestamp');
    return timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timestamp)
        : null;
  }

  Future<void> _checkBio() async {
    try {
      _hasBioSensor = await authentication.canCheckBiometrics;
      print(_hasBioSensor);

      if (_hasBioSensor!) {
        _getAuth();
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _getAuth() async {
    bool isAuth = false;
    try {
      isAuth = await authentication.authenticate(
        localizedReason: "Scan your Finger",
      );
      if (isAuth) {
        int totalPoints = await _getUserPoints();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Navifation(totalPoints: totalPoints),
          ),
        );
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  _checkNotification() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  _loginUser() async {
    try {
      // Call the API to attempt login
      var status = await Userrepositoryimp().loginstudent(
        _usernameController.text,
        _passwordController.text,
      );

      // Successful login

      print("mir mir");

      // Check if user has already earned points today
      DateTime? lastLoginDate = await _getLastLoginDate();
      DateTime currentDate = DateTime.now();
      bool sameDay = lastLoginDate != null &&
          lastLoginDate.year == currentDate.year &&
          lastLoginDate.month == currentDate.month &&
          lastLoginDate.day == currentDate.day;

      if (!sameDay) {
        // User has not earned points today, give them 10 points
        _updateUserPoints(10);
        await _updateLastLoginDate();

        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            channelKey: 'basic_channel',
            title: 'Bookmania',
            body: 'Successfully LoggedIn and earned 10 points!',
          ),
        );
      } else {
        // User has already earned points today
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            channelKey: 'basic_channel',
            title: 'Bookmania',
            body: 'Successfully LoggedIn',
          ),
        );
      }

      int totalPoints = await _getUserPoints();

      // Show the "Order Successful" toast
      MotionToast.success(
        description: const Text("Success"),
        onClose: () async {
          // Delay for a moment before showing the "10 Xp Rewarded" toast
          await Future.delayed(const Duration(seconds: 1));

          MotionToast.success(
            description: const Text("10 Xp Rewarded"),
            onClose: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Navifation(totalPoints: totalPoints),
                ),
              );
            },
          ).show(context);
        },
      ).show(context);
    } catch (e) {
      // Handle exceptions
      MotionToast.error(
        description: const Text("Username or Password Invalid"),
      ).show(context);
    }
  }

  _setDataToGetPref(String username, String password) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("username", username);
      await prefs.setString("password", password);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black87,
    backgroundColor: const Color.fromARGB(255, 7, 64, 164),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );

  _updateUserPoints(int pointsToAdd) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentPoints = prefs.getInt('userPoints') ?? 0;
    int updatedPoints = currentPoints + pointsToAdd;
    await prefs.setInt('userPoints', updatedPoints);
    print('Updated Points: $updatedPoints');
  }

  @override
  Widget build(BuildContext context) {
    ShakeDetector.waitForStart(onPhoneShake: () {
      setState(() {
        _usernameController.text = "";
        _passwordController.text = "";
      });
    });
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.horizontal(),
          color: Color.fromARGB(123, 192, 188, 188),
        ),
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: <Widget>[
            HeaderContainer("Login"),
            const SizedBox(height: 45),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _textInput(
                      hint: "Username",
                      icon: Icons.person_4,
                      controller: _usernameController,
                    ),
                    _textInput(
                      hint: "Password",
                      
                      icon: Icons.vpn_key,
                      controller: _passwordController,
                    ),
                    const SizedBox(
                      height: 27,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _setDataToGetPref(
                            _usernameController.text, _passwordController.text);
                        _loginUser();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 7, 64, 164),
                        textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 144),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                              color: Colors.white, width: 2), // Custom border
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(
                              254, 239, 232, 232), // Custom text color
                        ),
                      ),

                      // ElevatedButton(
                      //   onPressed: () async {
                      //     await _setDataToGetPref(
                      //         _usernameController.text, _passwordController.text);
                      //     _loginUser();
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: const Color.fromARGB(255, 7, 64, 164),
                      //     textStyle: const TextStyle(
                      //       fontSize: 35,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      //   child: const Text('Login'),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     _checkBio();
                    //   },
                    //   child: const Text("Finger Print"),
                    // ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegPage()),
                        );
                      },
                      child: Column(
                        children: [
                          const SizedBox(height: 200),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: "Register",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 7, 64, 164),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textInput({controller, hint, icon}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}

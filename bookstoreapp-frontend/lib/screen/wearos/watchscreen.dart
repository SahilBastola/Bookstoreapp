import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ebuy/repository/user_repo.dart';
import 'package:ebuy/screen/wearos/wearHome.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import 'package:wear/wear.dart';

class WearLogin extends StatefulWidget {
  const WearLogin({super.key});

  @override
  State<WearLogin> createState() => _WearLoginState();
}

class _WearLoginState extends State<WearLogin> {
  final _usernameController = TextEditingController(text: 'teknath');
  final _passwordController = TextEditingController(text: 'tek123');

  @override
  void initState() {
    _checkNotification();
    super.initState();
  }

  _checkNotification() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowded) {
      if (!isAllowded) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  _loginUser() async {
    final islogin = await Userrepositoryimp()
        .loginstudent(_usernameController.text, _passwordController.text);
    if (islogin) {
      // write here

      _goToAnotherPage();
    } else {
      _showMessage();
    }
  }

  _goToAnotherPage() async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: 'basic_channel',
            title: 'eBuy',
            body: 'Successfully LoggedIn'));

    MotionToast.success(
        description: const Text("Success"),
        iconSize: 25,
        width: 150,
        height: 50,
        onClose: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WatchHome(),
            ),
          );
        }).show(context);
  }

  _showMessage() {
    MotionToast.error(
      description: const Text("Username or Password Invalid"),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(builder: (context, mode, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: const SizedBox(
                          child: Text(
                            'Login ',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 15,
                                color: Colors.orange,
                                fontFamily: "OpenSans Bold"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 30,
                        child: TextFormField(
                          controller: _usernameController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 2, 128, 231),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )),
                            labelText: 'Username',
                          ),
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter username';
                            }
                            return null;
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 30,
                        child: TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 2, 128, 231),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )),
                            labelText: 'Password',
                          ),
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter username';
                            }
                            return null;
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 100,
                        height: 30,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                backgroundColor: Colors.orange),
                            onPressed: () {
                              _loginUser();
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}

import 'package:ebuy/model/user.dart';
import 'package:ebuy/pages/login_page.dart';
import 'package:ebuy/repository/user_repo.dart';
import 'package:ebuy/widgets/btn_widget.dart';
import 'package:ebuy/widgets/herder_container.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final _gap = const SizedBox(height: 8);

  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'tek@gmail.com');
  final _usernameController = TextEditingController(text: 'Tek');
  final _passwordController = TextEditingController(text: 'Tek@123');

  _saveStudent() async {
    User user = User(
        email: _emailController.text,
        name: _usernameController.text,
        password: _passwordController.text);

    int status = await Userrepositoryimp().registeruser(user);
    _showmessage(status);
  }

  _showmessage(int status) {
    if (status > 0) {
      MotionToast.success(
        description: const Text("User added successfully"),
      ).show(context);
    } else {
      MotionToast.error(
        description: const Text("Error Adding User"),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Register"),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _textInput(
                        hint: "Username",
                        icon: Icons.person,
                        controller: _usernameController),
                    _textInput(
                        hint: "Email",
                        icon: Icons.email,
                        controller: _emailController),
                    _textInput(
                        hint: "Password",
                        icon: Icons.vpn_key,
                        controller: _passwordController),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          btnText: "REGISTER",
                          onClick: () {
                            _saveStudent();
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginPage(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Already Have an Account? ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: "Login",
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
                      // child: RichText(
                      //   text: TextSpan(children: [
                      //     const TextSpan(
                      //         text: "Already a member ? ",
                      //         style: TextStyle(color: Colors.black)),
                      //     TextSpan(
                      //         text: "Login",
                      //         style: TextStyle(color: orangeColors)),
                      //   ]),
                      // ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textInput({controller, hint, icon}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
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

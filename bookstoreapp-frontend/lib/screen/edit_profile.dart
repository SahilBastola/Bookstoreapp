import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ebuy/model/user.dart';
import 'package:ebuy/repository/user_repo.dart';
import 'package:ebuy/screen/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool showPassword = false;
  var _imageController = TextEditingController(
      text:
          'https://i.pinimg.com/736x/73/fb/e1/73fbe1175ea93f5e701499bc56a68a68.jpg');
  var _usernameController = TextEditingController(text: 'sahil');
  var _emailController = TextEditingController(text: 'teknath@gmail.com');
  final _passwordcontroller = TextEditingController(text: 'sahil@1997');
  final _locationcontroller = TextEditingController(text: 'Nepal');

  _updateUser() async {
    int islogin = await Userrepositoryimp().updateUser(
        _usernameController.text, _emailController.text, _imageController.text);
    if (islogin == 1) {
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
            body: 'Profile Updated'));

    MotionToast.success(
      description: const Text("Updated Sccessfully"),
    ).show(context);
  }

  _showMessage() {
    MotionToast.error(
      description: const Text("OOps! somthing Went Wrong"),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 3,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const ProfileScreen()));
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: Column(
          children: [
            const Text(
              "Edit Profile",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: FutureBuilder<List<User>>(
                future: Userrepositoryimp().getUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 130,
                                      height: 130,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 4,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor),
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 2,
                                                blurRadius: 10,
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                offset: const Offset(0, 10))
                                          ],
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                snapshot.data![index].image ??
                                                    "",
                                              ))),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          Get.defaultDialog(
                                              barrierDismissible: false,
                                              title: "Warning!",
                                              content: buildTextField(
                                                  "Image-link",
                                                  "enter your image link here",
                                                  false,
                                                  _imageController =
                                                      TextEditingController(
                                                          text: snapshot
                                                                  .data![index]
                                                                  .image ??
                                                              "")),
                                              confirmTextColor: Colors.white,
                                              onCancel: () {},
                                              onConfirm: () {
                                                Get.back();
                                              });
                                        });
                                      },
                                      child: Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                width: 4,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                              ),
                                              color: const Color.fromARGB(
                                                  255, 7, 64, 164),
                                            ),
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              buildTextField(
                                  "Full Name",
                                  snapshot.data![index].name ?? "",
                                  false,
                                  _usernameController = TextEditingController(
                                      text: snapshot.data![index].name ?? "")),
                              buildTextField(
                                  "E-mail",
                                  snapshot.data![index].email ?? "",
                                  false,
                                  _emailController = TextEditingController(
                                      text: snapshot.data![index].email ?? "")),
                              buildTextField(
                                  "Password",
                                  snapshot.data![index].password ?? "",
                                  true,
                                  _passwordcontroller),
                              buildTextField(
                                  "Location",
                                  _locationcontroller.text,
                                  false,
                                  _locationcontroller),
                              const SizedBox(
                                height: 35,
                              ),
                            ],
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("CANCEL",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: () {
                    _updateUser();
                  },
                  child: const Text(
                    "SAVE",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}

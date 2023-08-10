import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ebuy/screen/wearos/watchscreen.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import 'package:wear/wear.dart';

class WatchHome extends StatefulWidget {
  const WatchHome({super.key});

  @override
  State<WatchHome> createState() => _WatchHomeState();
}

class _WatchHomeState extends State<WatchHome> {
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

  alert() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 2,
            channelKey: 'Alert_channel',
            title: 'eBuy',
            body: 'Sent Alert!'));
  }

  @override
  Widget build(BuildContext context) {
    return WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
      return AmbientMode(builder: (context, mode, child) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Tek Nath Bastola",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 30,
                                child: FloatingActionButton.extended(
                                  onPressed: () {
                                    alert();
                                  },
                                  heroTag: 'Success',
                                  elevation: 0,
                                  label: const Text("Alert"),
                                  icon: const Icon(Icons.mobile_friendly),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 30,
                                child: FloatingActionButton.extended(
                                  onPressed: () {
                                    MotionToast.error(
                                        description: const Text("success"),
                                        iconSize: 25,
                                        width: 150,
                                        height: 50,
                                        onClose: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const WearLogin(),
                                            ),
                                          );
                                        }).show(context);
                                  },
                                  heroTag: 'Logout',
                                  elevation: 0,
                                  backgroundColor: Colors.red,
                                  label: const Text("Logout"),
                                  icon: const Icon(Icons.logout),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
    });
  }
}
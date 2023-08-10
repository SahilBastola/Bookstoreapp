import 'package:ebuy/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';


void main() {
  testWidgets("Login user", (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(
      home: LoginPage(),
     
    ));

    Finder username = find.byKey(const Key('textfirst'));
    await tester.enterText(username, "textfirst");
    Finder password = find.byKey(const Key('textSecond'));
    await tester.enterText(password, "textSecond");
    Finder login = find.byKey(const Key('btnlogin'));
    await tester.tap(login);

    Finder homescreen = find.byKey(const Key('popular'));
    expect(homescreen, findsOneWidget);
  });
}
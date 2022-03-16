import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ticketless_project/screens/homeScreen/homescreen.dart';
import 'package:ticketless_project/screens/loginScreen/loginscreen.dart';
import 'package:ticketless_project/screens/sharedWidgets/bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyCustomBottomNavbar(initailIndex: 0),
    );
  }
}

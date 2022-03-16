import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ticketless_project/screens/homeScreen/homescreen.dart';
import 'package:ticketless_project/screens/loginScreen/loginscreen.dart';
import 'package:ticketless_project/screens/sharedWidgets/navbar.dart';

class MyCustomBottomNavbar extends StatefulWidget {
  MyCustomBottomNavbar(
      {Key? key, required this.initailIndex})
      : super(key: key);
  final initailIndex;
  @override
  State<MyCustomBottomNavbar> createState() => _MyCustomBottomNavbarState();
}

class _MyCustomBottomNavbarState extends State<MyCustomBottomNavbar>
    with SingleTickerProviderStateMixin {
  //controller to manage different tabs of the navbar
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 4, vsync: this, initialIndex: widget.initailIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //custom made tabview used as bottom navbar
        bottomNavigationBar: CustomNavBarWidget(tabController: _tabController),
        body: TabBarView(
          controller: _tabController,
          //tab pages in correspondence to the navbar
          children: [
           HomeScreen(),
           LoginScreen(),
           Container(),
           Container()
          ],
        ));
  }
}
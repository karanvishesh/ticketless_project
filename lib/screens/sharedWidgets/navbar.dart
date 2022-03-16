import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class CustomNavBarWidget extends StatelessWidget {
  const CustomNavBarWidget({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    //outer container to hold the navbar
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
          decoration: BoxDecoration(color: Colors.white),
          child: TabBar(
            unselectedLabelColor: Colors.white,
            //indicator package for the dot indication
            indicator: DotIndicator(
              color: Colors.blue,
              distanceFromCenter: 22,
              radius: 3,
              paintingStyle: PaintingStyle.fill,
            ),
            // BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
            //inner padding for the icons of the navbar
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                icon: Image.asset("assets/icons/home.png", width: 30),
              ),
              Tab(
                icon: Icon(
                  CupertinoIcons.squares_below_rectangle,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
              Tab(
                icon: Icon(
                  CupertinoIcons.settings,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
              Tab(
                icon: Icon(
                  CupertinoIcons.person_fill,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

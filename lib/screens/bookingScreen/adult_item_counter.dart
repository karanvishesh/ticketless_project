import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticketless_project/controller/count_controller.dart';

class AdultItemCounter extends StatefulWidget {
  @override
  _AdultItemCounterState createState() => _AdultItemCounterState();
}

class _AdultItemCounterState extends State<AdultItemCounter> {
  final countState = Get.put(CountController());
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (countState.adult_count > 1) {
              countState.decrementAdult();
            }
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Obx(
            () => Text(
              // if our item is less  then 10 then  it shows 01 02 like that
              countState.adult_count.toString().padLeft(2, "0"),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              countState.incrementAdult();
            }),
      ],
    );
  }

  SizedBox buildOutlineButton(
      {required IconData icon, required Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: () {
          press();
        },
        child: Icon(icon),
      ),
    );
  }
}

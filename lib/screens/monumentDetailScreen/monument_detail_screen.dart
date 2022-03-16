import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticketless_project/model/monument.dart';
import 'package:ticketless_project/screens/bookingScreen/booking_screen.dart';
import 'package:ticketless_project/screens/monumentDetailScreen/widgets/bottom_row.dart';
import 'package:ticketless_project/screens/monumentDetailScreen/widgets/top_image_card.dart';
import 'package:ticketless_project/screens/sharedWidgets/landingpage.dart';

class MonumentDetailScreen extends StatelessWidget {
  const MonumentDetailScreen({Key? key, required this.monument})
      : super(key: key);
  final Monument monument;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopImageCard(monument: monument),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        monument.name,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Text(
                        monument.desc,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      BottomRow(monument: monument),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

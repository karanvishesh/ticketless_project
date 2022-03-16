import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticketless_project/model/monument.dart';
import 'package:ticketless_project/screens/bookingScreen/booking_screen.dart';
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
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Positioned(
                      child: Container(
                        height: 380,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(
                              monument.imageUrl,
                            ),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.7),
                                BlendMode.softLight),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 15,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => (Get.offAll(() => LandingPage())),
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.9),
                              child: Icon(
                                Icons.keyboard_arrow_left,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                            fontSize: 32, fontWeight: FontWeight.bold),
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
                        height: 150,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Price',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: "₹",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: monument.price.toString(),
                                  style: TextStyle(
                                    fontSize: 27,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ])),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.off(BookingScreen(monument: monument,));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 20),
                              child: Text(
                                "Book Now",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          )
                        ],
                      ),
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

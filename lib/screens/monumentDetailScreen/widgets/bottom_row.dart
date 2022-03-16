import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticketless_project/model/monument.dart';
import 'package:ticketless_project/screens/bookingScreen/booking_screen.dart';

class BottomRow extends StatelessWidget {
  const BottomRow({
    Key? key,
    required this.monument,
  }) : super(key: key);

  final Monument monument;

  @override
  Widget build(BuildContext context) {
    return Row(
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
            Get.off(() => BookingScreen(
              monument: monument,
            ));
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
    );
  }
}
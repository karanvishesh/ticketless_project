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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Text(
                'Price',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                  text: "₹",
                  style: const TextStyle(
                    fontSize: 27,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: monument.price.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]))
            ],
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.to(BookingScreen(monument: monument));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Center(
                  child: const Text(
                    "Book Now",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

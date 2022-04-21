import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:ticketless_project/screens/BookedTicketScreen/widgets/ticket_detail_widget.dart';
import 'package:ticketless_project/screens/sharedWidgets/landingpage.dart';

class BookedTicketScreen extends StatelessWidget {
  BookedTicketScreen(
      {Key? key,
      required this.booked_by,
      required this.no_of_adults,
      required this.no_of_children,
      required this.time_slot,
      required this.price,
      // ignore: non_constant_identifier_names
      required this.monument_name,
      required this.visiting_date,
      required this.ticket_id})
      : super(key: key);
  final String booked_by;
  final int no_of_adults;
  final int no_of_children;
  final DateTime visiting_date;
  final String time_slot;
  final int price;
  final String monument_name;
  final String ticket_id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
            child: TicketWidget(
              width: 350.0,
              height: 600.0,
              isCornerRounded: true,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 120.0,
                              height: 25.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                border:
                                    Border.all(width: 1.0, color: Colors.green),
                              ),
                              child: const Center(
                                child: Text(
                                  'Booked',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 160,
                            ),
                            const Icon(
                              Icons.share,
                              size: 25,
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        monument_name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ticketDetailsWidget(
                                'Booked by',
                                booked_by,
                                'Date',
                                DateFormat('d-MM-y').format(visiting_date)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, right: 0),
                            child: ticketDetailsWidget(
                                'No of Adults',
                                no_of_adults.toString(),
                                'Time Slot',
                                time_slot),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, right: 10.0),
                            child: ticketDetailsWidget(
                                'No of Children',
                                no_of_children.toString(),
                                'Total Amount',
                                '₹$price'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                          "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0),
                    ),
                    Center(
                      child: QrImage(
                        size: 150,
                        data: ticket_id,
                        version: QrVersions.auto,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        ticket_id,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Get.offAll(() => LandingPage());
            },
            child: Container(
              width: 210,
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Text(
                    "Continue to App",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Icon(Icons.keyboard_arrow_right, color: Colors.white)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

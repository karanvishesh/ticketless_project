import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:ticketless_project/screens/BookedTicketScreen/widgets/ticket_detail_widget.dart';

class BookedTicket extends StatelessWidget {
  const BookedTicket(
      {Key? key,
      required this.booked_by,
      required this.no_of_adults,
      required this.no_of_children,
      required this.booking_date,
      required this.time_slot,
      required this.price,
      required this.monument_name,
      required this.ticket_id})
      : super(key: key);
  final String booked_by;
  final int no_of_adults;
  final int no_of_children;
  final DateTime booking_date;
  final String time_slot;
  final int price;
  final String monument_name;
  final String ticket_id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
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
                            border: Border.all(width: 1.0, color: Colors.green),
                          ),
                          child: Center(
                            child: Text(
                              'Booked',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 160,
                        ),
                        Icon(
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
                    style: TextStyle(
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
                        child: ticketDetailsWidget('Booked by', booked_by,
                            'Date', DateFormat('d-MM-y').format(booking_date)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, right: 0),
                        child: ticketDetailsWidget('No of Adults',
                            no_of_adults.toString(), 'Time Slot', time_slot),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, right: 10.0),
                        child: ticketDetailsWidget(
                            'No of Children',
                            no_of_children.toString(),
                            'Total Amount',
                            '₹$price'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0),
                ),
                Center(
                  child: QrImage(
                    size: 150,
                    data: ticket_id,
                    version: QrVersions.auto,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    ticket_id,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

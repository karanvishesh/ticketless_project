import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:ticketless_project/screens/bookedTicketScreen/booked_ticket_screen.dart';
import 'package:ticketless_project/screens/ticketHistoryScreen/widgets/text_widget.dart';

class UpcomingTicketsWidget extends StatelessWidget {
  const UpcomingTicketsWidget(
      {Key? key,
      required this.booked_by,
      required this.no_of_adults,
      required this.no_of_children,
      required this.visiting_date,
      required this.time_slot,
      required this.price,
      // ignore: non_constant_identifier_names
      required this.monument_name,
      required this.ticket_id})
      : super(key: key);
  final String booked_by;
  final int no_of_adults;
  final int no_of_children;
  final String visiting_date;
  final String time_slot;
  final int price;
  final String monument_name;
  final String ticket_id;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => BookedTicketScreen(
            booked_by: booked_by,
            no_of_adults: no_of_adults,
            no_of_children: no_of_children,
            visiting_date: DateFormat("dd-MM-yyyy").parse(visiting_date),
            time_slot: time_slot,
            price: price,
            monument_name: monument_name,
            ticket_id: ticket_id));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
        child: TicketWidget(
          width: double.infinity,
          height: 190,
          color: Color(0xff87CEEB).withOpacity(0.4),
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Text(monument_name,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: textWidget('No of Adults', no_of_adults.toString(),
                  'No of Children', no_of_children.toString()),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: textWidget('Date', visiting_date, 'Time Slot', time_slot),
            ),
            SizedBox(
              height: 10,
            )
          ]),
        ),
      ),
    );
  }
}

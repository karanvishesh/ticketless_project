import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:ticketless_project/screens/bookedTicketScreen/booked_ticket_screen.dart';
import 'package:ticketless_project/screens/ticketHistoryScreen/booking_history_screen.dart';
import 'package:ticketless_project/screens/ticketHistoryScreen/widgets/upcoming_ticket_widget.dart';

class TicketHistory extends StatelessWidget {
  TicketHistory({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _bookedTicketsStream = FirebaseFirestore.instance
      .collection("bookedTickets")
      .orderBy("bookingDate", descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Upcoming Bookings",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: (() => Get.to(BookingHistoryScreen())),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Text(
                              "Booking History",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Icon(Icons.keyboard_arrow_right,
                                color: Colors.white)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: _bookedTicketsStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      //implement error screen
                      print('Something went Wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: const CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      );
                    }
                    if (snapshot.data!.size == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 250.0),
                        child: Center(
                          child: Center(child: Text("No Bookings Yet")),
                        ),
                      );
                    }
                    final List bookedTicketList = [];
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map a = document.data() as Map<String, dynamic>;
                      if (a['uid'] == FirebaseAuth.instance.currentUser!.uid) {
                        bookedTicketList.add(a);
                        a['id'] = document.id;
                      }
                    }).toList();
                    return Expanded(
                      child: ListView.builder(
                          itemCount: bookedTicketList.length,
                          itemBuilder: (context, index) {
                            return UpcomingTicketsWidget(
                              no_of_adults: bookedTicketList[index]
                                  ["noOfAdults"],
                              no_of_children: bookedTicketList[index]
                                  ["noOfChildren"],
                              visiting_date: bookedTicketList[index]
                                  ["visitingDate"],
                              monument_name: bookedTicketList[index]
                                  ["monument"],
                              time_slot: bookedTicketList[index]["timeSlot"],
                              booked_by: bookedTicketList[index]["bookedBy"],
                              price: bookedTicketList[index]["price"].round(),
                              ticket_id: bookedTicketList[index]["id"],
                            );
                          }),
                    );
                  }),
            ],
          )),
    );
  }
}

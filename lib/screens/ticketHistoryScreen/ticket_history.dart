import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:ticketless_project/screens/bookedTicketScreen/booked_ticket_screen.dart';

class TicketHistory extends StatelessWidget {
  TicketHistory({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _bookedTicketsStream =
      FirebaseFirestore.instance.collection("bookedTickets").snapshots();
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
                child: Text(
                  "Upcoming Bookings",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
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
                      return Center(
                        child: Text("No Bookings Yet"),
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
                            return UpcomingTickets(
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
              Divider(color: Colors.black, thickness: 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                      child: Text(
                        "Booking History",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: 2,
                        itemBuilder: ((context, index) =>
                            HistoryTicketWidget()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class HistoryTicketWidget extends StatelessWidget {
  const HistoryTicketWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            "T",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        title: Text("Taj Mahal"),
        subtitle: Text("23-03-2022"),
        trailing: Text(
          "₹ 500",
          style: TextStyle(fontSize: 22),
        ));
  }
}

class UpcomingTickets extends StatelessWidget {
  const UpcomingTickets(
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

Widget textWidget(String firstTitle, String firstDesc, String secondTitle,
    String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                firstDesc,
                style: const TextStyle(color: Colors.black, fontSize: 17),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              secondTitle,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                secondDesc,
                style: const TextStyle(color: Colors.black, fontSize: 17),
              ),
            )
          ],
        ),
      )
    ],
  );
}

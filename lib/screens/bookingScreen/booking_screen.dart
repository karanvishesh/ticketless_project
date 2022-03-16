import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ticketless_project/model/monument.dart';
import 'package:ticketless_project/screens/BookedTicketScreen/booked_ticket_screen.dart';
import 'package:ticketless_project/screens/bookingScreen/item_counter.dart';
import 'package:ticketless_project/screens/monumentDetailScreen/monument_detail_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key, required this.monument}) : super(key: key);
  final Monument monument;
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String time_slot = "";
  final no_of_adults = 2;
  final no_of_children = 3;
  bool isimagepicked = false;
  DateTime _selectedDate = DateTime.now().add(Duration(days: 1));
  final List time_slots = [
    "09:00 - 11:00",
    "11:00 - 13:00",
    "14:00 - 16:00",
    " 17:00 - 19:00"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // switch_category = widget.mySwitch.category;
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime.now().add(Duration(days: 3)),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    }
  }

  _bookTicket() {
    CollectionReference ticketRef =
        FirebaseFirestore.instance.collection('bookedTickets');
    ticketRef.add({
      'bookedBy': name,
      'monument': widget.monument.name,
      'noOfAdults': no_of_adults,
      'noOfChildren': no_of_children,
      'bookingDate': _selectedDate,
      'timeSlot': time_slot,
      'price': (widget.monument.price * 3) + (widget.monument.price / 2 * 1),
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Ticket Booked Successfully"),
        ),
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'bookedTickets': FieldValue.arrayUnion([value.id])
      });
      Get.to(BookedTicket(
        monument_name: widget.monument.name,
        booked_by: name,
        time_slot: time_slot,
        no_of_adults: no_of_adults,
        no_of_children: no_of_children,
        price: widget.monument.price,
        booking_date: DateTime.now(),
        ticket_id: value.id,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.offAll(
                      () => MonumentDetailScreen(monument: widget.monument));
                },
              ),
              title: Text(
                "Add Booking Information",
                // style: Responsive.title1Style,
              ),
            ),
            Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.monument.name,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Booking Person's name",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 22, horizontal: 15),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Please Enter Item name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            'Number of Adults :',
                            style: TextStyle(fontSize: 17),
                          ),
                          Spacer(),
                          ItemCounter(),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            'Number of Children :',
                            style: TextStyle(fontSize: 17),
                          ),
                          Spacer(),
                          ItemCounter(),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Text(
                            "Select Date :",
                            style: TextStyle(fontSize: 17),
                          ),
                          IconButton(
                            onPressed: _getDateFromUser,
                            icon: Icon(Icons.calendar_today_outlined,
                                color: Colors.blue),
                          ),
                          Expanded(
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: DateFormat('dd-MM-yyyy')
                                    .format(_selectedDate),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      DropdownButtonFormField(
                        validator: (value) {
                          if (value == null) {
                            return 'Please Select Preferred Time';
                          }
                          return null;
                        },
                        focusColor: Colors.blue,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.red,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 22, horizontal: 10),
                          labelText: "Choose Preferred time slot",
                        ),
                        items: time_slots
                            .map((object) => DropdownMenuItem(
                                child: Text(object.toString()), value: object))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            time_slot = val.toString();
                          });
                        },
                      ),
                      SizedBox(
                        height: 110,
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
                                  text: widget.monument.price.toString(),
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
                              if (_formKey.currentState!.validate()) {
                                _bookTicket();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 20),
                              child: Text(
                                "Confirm Booking",
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
                )),
          ],
        ),
      ),
    ));
  }
}

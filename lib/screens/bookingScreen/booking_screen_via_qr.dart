import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pay/pay.dart';
import 'package:ticketless_project/controller/count_controller.dart';
import 'package:ticketless_project/model/monument.dart';
import 'package:ticketless_project/screens/bookedTicketScreen/booked_ticket_screen.dart';
import 'package:ticketless_project/screens/bookingScreen/adult_item_counter.dart';
import 'package:ticketless_project/screens/bookingScreen/children_item_counter.dart';
import 'package:ticketless_project/screens/monumentDetailScreen/monument_detail_screen.dart';

class BookingScreenViaQr extends StatefulWidget {
  const BookingScreenViaQr({Key? key, required this.monument})
      : super(key: key);
  final Monument monument;

  @override
  State<BookingScreenViaQr> createState() => _BookingScreenViaQrState();
}

class _BookingScreenViaQrState extends State<BookingScreenViaQr> {
  final countState = Get.put(CountController());
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String time_slot = DateFormat("HH").format(DateTime.now()) + ":00" + " "
      '-' + " " +
      DateFormat("HH").format(DateTime.now().add(Duration(hours: 2)))  + ":00";
  bool isimagepicked = false;
  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];

  _bookTicket() {
    CollectionReference ticketRef =
        FirebaseFirestore.instance.collection('bookedTickets');
    ticketRef.add({
      'bookedBy': name,
      'monument': widget.monument.name,
      'noOfAdults': countState.adult_count.toInt(),
      'noOfChildren': countState.child_count.toInt(),
      'bookingDate': DateTime.now(),
      'timeSlot': time_slot,
      'isScanned': false,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'visitingDate': DateFormat("dd-MM-yyyy").format(_selectedDate),
      'price': (widget.monument.price * countState.adult_count.toInt()) +
          ((widget.monument.price) / 2 * countState.child_count.toInt()),
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ticket Booked Successfully"),
        ),
      );
      Get.to(BookedTicketScreen(
        monument_name: widget.monument.name,
        booked_by: name,
        time_slot: time_slot,
        no_of_adults: countState.adult_count.toInt(),
        no_of_children: countState.child_count.toInt(),
        price: (widget.monument.price * countState.adult_count.toInt()) +
            ((widget.monument.price) / 2 * countState.child_count.toInt())
                .toInt(),
        visiting_date: _selectedDate,
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
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.offAll(
                      () => MonumentDetailScreen(monument: widget.monument));
                },
              ),
              title: const Text(
                "Add Booking Information",
                // style: Responsive.title1Style,
              ),
            ),
            Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.monument.name,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
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
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 22, horizontal: 15),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2.0),
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
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Number of Adults :',
                            style: const TextStyle(fontSize: 17),
                          ),
                          const Spacer(),
                          AdultItemCounter(),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Number of Children :',
                            style: const TextStyle(fontSize: 17),
                          ),
                          const Spacer(),
                          ChildrenItemCounter(),
                        ],
                      ),
                      const SizedBox(
                        height: 340,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Price',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Obx(
                                (() => RichText(
                                        text: TextSpan(children: [
                                      const TextSpan(
                                        text: "???",
                                        style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: countState.adult_count == 0 &&
                                                countState.child_count == 0
                                            ? widget.monument.price.toString()
                                            : ((widget.monument.price *
                                                        countState.adult_count
                                                            .toInt()) +
                                                    ((widget.monument.price) /
                                                        2 *
                                                        countState.child_count
                                                            .toInt()))
                                                .toString(),
                                        style: const TextStyle(
                                          fontSize: 27,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ]))),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child:
                                // GooglePayButton(
                                //   paymentConfigurationAsset: 'gpay.json',
                                //   paymentItems: _paymentItems,
                                //   width: 200,
                                //   height: 50,
                                //   style: GooglePayButtonStyle.black,
                                //   type: GooglePayButtonType.pay,
                                //   margin: const EdgeInsets.only(top: 15.0),
                                //   onPaymentResult: (data) {
                                //     print(data);
                                //   },
                                //   loadingIndicator: const Center(
                                //     child: CircularProgressIndicator(),
                                //   ),
                                // ),
      
                                GestureDetector(
                              onTap: () {
                                if (countState.adult_count == 0 &&
                                    countState.child_count == 0) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text("Please add atleast one person"),
                                  ));
                                } else if (_formKey.currentState!.validate()) {
                                  _bookTicket();
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Center(
                                  child: const Text(
                                    "Confirm Booking",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
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
                    ],
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ticketless_project/model/monument.dart';
import 'package:ticketless_project/screens/bookingScreen/item_counter.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key, required this.monument}) : super(key: key);
  final Monument monument;
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isNonveg = false;
  String item_name = "";
  String item_price = "";
  String item_desc = "";
  String time_slot = " ";
  String price = "";
  String menu_item_category = "";
  bool isimagepicked = false;
  DateTime _selectedDate = DateTime.now();
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
              leading: BackButton(),
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
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          setState(() {
                            item_name = val;
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
                            'Number of People :',
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
                            child: DropdownButtonFormField(
                              validator: (value) {
                                if (value == null) {
                                  return 'Please Select Preparation Time';
                                }
                                return null;
                              },
                              focusColor: Colors.blue,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                fillColor: Colors.red,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 22, horizontal: 10),
                                labelText: "Choose Preferred time slot",
                              ),
                              items: time_slots
                                  .map((object) => DropdownMenuItem(
                                      child: Text(object.toString()),
                                      value: object))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  time_slot = val.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 300,
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
                            onTap: () {},
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

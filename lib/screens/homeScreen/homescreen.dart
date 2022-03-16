import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticketless_project/screens/homeScreen/widgets/monument_display_widget.dart';
import 'package:ticketless_project/screens/homeScreen/widgets/qr_scanner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        "https://d2qp0siotla746.cloudfront.net/img/use-cases/profile-picture/template_3.jpg"),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Hey Hannah!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => QrScanner());
                    },
                    child: Image.asset(
                      "assets/icons/scanner.png",
                      width: 30,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Explore the\nbeauty of India",
                style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          CupertinoIcons.search,
                          color: Colors.black45,
                          size: 25,
                        ),
                        hintText: "Search monuments",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 380,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) => MonumentDisplayWidget()),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

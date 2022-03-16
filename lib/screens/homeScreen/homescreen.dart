import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                  Image.asset(
                    "assets/icons/scanner.png",
                    width: 30,
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
                  itemBuilder: ((context, index) => Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: 270,
                            height: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://th-thumbnailer.cdn-si-edu.com/NaExfGA1op64-UvPUjYE5ZqCefk=/fit-in/1600x0/filters:focal(1471x1061:1472x1062)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/b6/30/b630b48b-7344-4661-9264-186b70531bdc/istock-478831658.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            right: 20,
                            child: Container(
                              width: double.infinity,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Taj Mahal",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Agra, Uttar Pradesh",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

// TextField(
//                       decoration: InputDecoration(
//                         isDense: true,
//                         focusColor: Colors.white,
//                         hoverColor: Colors.white,
//                         filled: true,
//                         fillColor: Colors.white,
//                         prefixIcon: Icon(
//                           Icons.search,
//                           color: Colors.black45,
//                           size: 22,
//                         ),
//                         border: OutlineInputBorder(
//                           // width: 0.0 produces a thin "hairline" border
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                           borderSide: BorderSide.none,
//                           //borderSide: const BorderSide(),
//                         ),
//                         hintText: 'Search',
//                         contentPadding: EdgeInsets.all(15),
//                         hintStyle: TextStyle(
//                           color: Colors.black,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ),
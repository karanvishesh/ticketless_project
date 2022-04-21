import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticketless_project/model/monument.dart';
import 'package:ticketless_project/screens/sharedWidgets/landingpage.dart';

class TopImageCard extends StatelessWidget {
  const TopImageCard({
    Key? key,
    required this.monument,
  }) : super(key: key);

  final Monument monument;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Positioned(
          child: Container(
            height: 360,
            child: Carousel(
              autoplay: false,
              dotBgColor: Colors.transparent,
              images: monument.imageUrl.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      height: 500,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image:  CachedNetworkImageProvider(image),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.7),
                              BlendMode.softLight),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
        Positioned(
          top: 15,
          left: 18,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => (Get.offAll(() => LandingPage())),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

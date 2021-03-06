import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticketless_project/model/monument.dart';
import 'package:ticketless_project/screens/monumentDetailScreen/monument_detail_screen.dart';

class MonumentDisplayWidget extends StatelessWidget {
  const MonumentDisplayWidget({
    Key? key,
    required this.monument,
  }) : super(key: key);
  final Monument monument;
  List<Widget> _createStars() {
    List<Widget> stars = [];
    for (int i = 0; i < monument.stars; i++) {
      stars.add(
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Image.asset(
            "assets/icons/star.png",
            width: 15,
          ),
        ),
      );
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    print(monument.imageUrl);
    return GestureDetector(
      onTap: () {
        Get.to(MonumentDetailScreen(monument: monument));
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 270,
            height: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: CachedNetworkImageProvider(monument.imageUrl[0], ),
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
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          monument.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              monument.location,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 110,
                            ),
                            Row(children: _createStars()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ticketless_project/model/monument.dart';
import 'package:ticketless_project/screens/monumentDetailScreen/widgets/assist_widgets.dart';
import 'package:ticketless_project/screens/monumentDetailScreen/widgets/bottom_row.dart';
import 'package:ticketless_project/screens/monumentDetailScreen/widgets/top_image_card.dart';

class MonumentDetailScreen extends StatelessWidget {
  const MonumentDetailScreen({Key? key, required this.monument})
      : super(key: key);
  final Monument monument;
  List<Widget> _createStars() {
    List<Widget> stars = [];
    for (int i = 0; i < monument.stars; i++) {
      stars.add(
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Image.asset(
            "assets/icons/star.png",
            width: 20,
          ),
        ),
      );
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:
            Container(height: 80, child: BottomRow(monument: monument)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopImageCard(monument: monument),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          children: [
                            Text(
                              monument.name,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Row(
                              children: _createStars(),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Row(
                        children: [
                          AssisWidgets(
                            image: "google_maps",
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          AssisWidgets(
                            image: "food",
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          AssisWidgets(
                            image: "guide",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        monument.desc,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

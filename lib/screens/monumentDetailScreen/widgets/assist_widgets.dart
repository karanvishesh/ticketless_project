import 'package:flutter/material.dart';

class AssisWidgets extends StatelessWidget {
  const AssisWidgets({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff87CEEB).withOpacity(0.4),
          borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.all(8),
      width: 50,
      height: 50,
      child: Image.asset(
        "assets/icons/$image.png",
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

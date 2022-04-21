import 'package:flutter/material.dart';

class HistoryTicketWidget extends StatelessWidget {
  const HistoryTicketWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                "T",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            title: Text("Taj Mahal"),
            subtitle: Text("23-03-2022"),
            trailing: Text(
              "₹ 500",
              style: TextStyle(fontSize: 22),
            )),
        Divider(
          thickness: 1,
        ),
      ],
    );
  }
}

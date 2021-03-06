import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketless_project/controller/googel_sign_in.dart';
import 'package:ticketless_project/model/monument.dart';
import 'package:ticketless_project/screens/homeScreen/widgets/monument_display_widget.dart';
import 'package:ticketless_project/screens/homeScreen/widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> _monumentStream =
      FirebaseFirestore.instance.collection("monuments").snapshots();
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
                    backgroundImage: NetworkImage(user!.photoURL.toString()),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Hey ${user!.displayName!.split(" ")[0]}!",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.GoogleLogOut();
                    },
                    icon: Image.asset(
                      "assets/icons/logout.png",
                      width: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Explore the\nbeauty of India...",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              const SearchBar(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Nearby Monuments",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 365,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: StreamBuilder<QuerySnapshot>(
                    stream: _monumentStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        //implement error screen
                        print('Something went Wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: const CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.size,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) {
                          final List monumentList = [];
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map a = document.data() as Map<String, dynamic>;
                            monumentList.add(a);
                            a['id'] = document.id;
                          }).toList();
                          return MonumentDisplayWidget(
                            monument: Monument(
                                name: monumentList[index]["name"],
                                id: monumentList[index]["id"],
                                imageUrl: monumentList[index]["imgUrl"],
                                stars: monumentList[index]["stars"],
                                price: monumentList[index]["price"],
                                location: monumentList[index]["location"],
                                desc: monumentList[index]["desc"],
                                timeSlot: monumentList[index]["time"]),
                          );
                        }),
                      );
                    }),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ticketless_project/screens/loginScreen/loginscreen.dart';
import 'package:ticketless_project/screens/sharedWidgets/bottom_nav.dart';
class LandingPage extends StatefulWidget {
  const LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.blue));
          } else if (snapshot.hasData) {
            return MyCustomBottomNavbar(initailIndex: 0);
          } else if (snapshot.hasError) {
            //implement error screen
            print("error");
            return const Center(child: Text("Error"));
          } else {
            print("user not logged in");
            return const LoginScreen();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ticketless_project/controller/googel_sign_in.dart';
import 'package:ticketless_project/screens/sharedWidgets/landingpage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String pass = "";
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo/logo.gif",
                    height: 250,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome to Ticketless!",
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Hasle free ticket booking",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: "Email",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Please Enter Item name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (val) {
                              setState(() {
                                pass = val;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: "Password",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Please Enter Item Description';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                splashColor: Colors.blue,
                                minWidth: double.infinity,
                                height: 55,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Get.to(AddMenuItem());
                                    print(email);
                                    print(pass);
                                  }
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SignInButton(
                    Buttons.Google,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    text: "Sign in with Google",
                    onPressed: () {
                        final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
           provider.googleLogIn().then((value) => Get.offAll(LandingPage()));
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}

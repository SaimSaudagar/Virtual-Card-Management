import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:project/widget/MainButton.dart';
import 'package:project/widget/textfild.dart';

class ForgotPasswordUI extends StatefulWidget {
  const ForgotPasswordUI({
    Key? key,
  }) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordUI> {
  final auth = FirebaseAuth.instance;
  TextEditingController userEmail = TextEditingController();
  @override
  Widget build(BuildContext content) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
                child: SizedBox(
              height: 900,
              width: 500,
              child: Column(children: [
                Image.asset(
                  "assets/images/applogo.png",
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.only(left: 90, right: 100, top: 0),
                  child: Text(
                    key: Key('forgotpwdheading'),
                    'Forgot Password',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 4.0,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 317, top: 0),
                  child: Text(
                    key: Key('emailheading'),
                    'Email',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                textfild(
                  const Text(
                    key: Key('emailhinttext'),
                    'UserEmail',
                    style: TextStyle(color: Colors.white),
                  ),
                  const Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                  Color(0XFF00B686),
                  userEmail,
                  TextInputType.emailAddress,
                  Key("forgotpasswordtextfield"),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                MainButton(
                  key: Key('sendrequest'),
                  onTap: () {
                    auth
                        .sendPasswordResetEmail(email: userEmail.text)
                        .then((value) {
                      if (userEmail.text == null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Email Field is empty'),
                              content: const Text(
                                  'Please enter a valid email address to receive the recovery email'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Continue'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Recovery Email Sent!'),
                              content: const Text(
                                  'The email to recover the password has been sent. Please check your email.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Close'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }).onError((error, stackTrace) {
                      print("Email :  ${error.toString()}");
                    });
                  },
                  btncolor: Colors.white,
                  text: const Text('Send Request'),
                ),
              ]),
            ))));
  }
}

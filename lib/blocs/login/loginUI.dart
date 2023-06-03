import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/blocs/forgotpassword/forgotPasswordUI.dart';
import 'package:project/blocs/signup/siginupUI.dart';
import 'package:project/blocs/userhome/userHomeUI.dart';
import 'package:project/widget/MainButton.dart';
import 'package:project/widget/bottom_navigation.dart';
import 'package:project/widget/textfild.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'add.dart';

class LoginPageUI extends StatefulWidget {
  const LoginPageUI({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

TextEditingController userEmail = TextEditingController();
TextEditingController userPassword = TextEditingController();

class _LoginPageState extends State<LoginPageUI> {
  //FirebaseServices _service= new FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: bottomNavigation(),
      // backgroundColor: Colors.black,
      body: Container(
        height: 900,
        width: 500,
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0XFF00B686), Color(0XFF00838F)])),
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(height: 30),
              Text(
                key: Key('welcomeback'),
                'WELCOME BACK',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 4.0,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                key: Key('signintoyouraccount'),
                'Please sign in to your account',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 60.0),
              const Padding(
                padding: const EdgeInsets.only(left: 10, right: 317, top: 0),
                child: Text(
                  key: Key("emailheading"),
                  'Email',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              textfild(
                const Text(
                  'UserEmail',
                  style: TextStyle(color: Colors.white),
                ),
                const Icon(
                  Icons.mail,
                  color: Colors.white,
                ),
                Colors.black,
                userEmail,
                TextInputType.emailAddress,
                Key("useremailtextfield"),
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 300, top: 0),
                child: Text(
                  key: Key('passwordheading'),
                  'Password',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              textfild(
                const Text(
                  'UserPassword',
                  style: TextStyle(color: Colors.white),
                ),
                const Icon(
                  Icons.remove_red_eye,
                  color: Colors.white,
                ),
                Colors.black,
                userPassword,
                TextInputType.text,
                Key("userpasswordtextfield"),
              ),
              const SizedBox(height: 5.0),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: TextButton(
                      key: Key("forgotpasswordtext"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => ForgotPasswordUI()));
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
              const SizedBox(height: 15.0),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      MainButton(
                        key: Key("loginbutton"),
                        onTap: () {
                          if (userEmail.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Please enter email'),
                                  content: const Text(
                                      'Email is empty, please enter email'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Close'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            return;
                          }
                          if (userPassword.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Please enter password'),
                                  content: const Text(
                                      'Password is empty, please enter password'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Close'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            // return;
                          }
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: userEmail.text,
                                  password: userPassword.text)
                              .then((userCredential) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => bottomNavigation()),
                            );
                            userEmail.text = "";
                            userPassword.text = "";
                          }).catchError((error) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                      'Please enter correct email and password'),
                                  content: const Text(
                                      'Email or password is incorrect, please enter correct email and password'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Close'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                        },
                        btncolor: Color.fromARGB(0, 7, 6, 6),
                        text: const Text('Log in',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(height: 2.0),
                      Row(children: [
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            key: const Key('image'),
                            "assets/images/line.png",
                            width: 20,
                            height: 80,
                            scale: 0.1,
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(
                                left: 5, right: 5, top: 0, bottom: 0),
                            child: Text('OR CONNECT WITH',
                                key: Key('connectwithtext'),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ))),
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            key: const Key('image'),
                            "assets/images/line.png",
                            width: 15,
                            height: 80,
                            scale: 0.1,
                          ),
                        ),
                      ]),
                      const SizedBox(height: 0.25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 3, top: 3, bottom: 2)),
                          TextButton(
                              key: Key('googlebutton'),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Sign in with Google'),
                                      content: const Text(
                                          'This allows the app to access the information about you.'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Close'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Continue'),
                                          onPressed: () async {
                                            await signInWithGoogle(context);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: TextButton.styleFrom(
                                side: const BorderSide(
                                    width: 1, color: Colors.grey),
                                minimumSize: const Size(100, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                primary: Colors.white,
                                backgroundColor: Colors.red,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    key: Key("googleicon"),
                                    FontAwesomeIcons.google,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                  Text('  Google',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ))
                                ],
                              )),
                          const Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 20, top: 3, bottom: 2)),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => SignUpPageUI()));
                          },
                          child: RichText(
                              key: Key('signuptext'),
                              text: const TextSpan(children: [
                                TextSpan(
                                    text: "Don't have an account? ",
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.white)),
                                TextSpan(
                                    text: "Sign up",
                                    style: TextStyle(
                                      color: Color(0XFF00B686),
                                      fontSize: 14.0,
                                    ))
                              ])))
                    ],
                  )),
            ],
          )),
        ),
      ),
    );
  }
}

GoogleSignIn _googleSignIn = GoogleSignIn();
FirebaseAuth _auth = FirebaseAuth.instance;

Future<UserCredential?> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    User? user = userCredential.user;
    // Do something with the user object
    if (user != null) {
      // Navigate to the desired page
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserHomeUI()),
      );
    }
    print(user?.phoneNumber);
    return userCredential;
  } catch (e) {
    print(e.toString());
    return null;
  }
}

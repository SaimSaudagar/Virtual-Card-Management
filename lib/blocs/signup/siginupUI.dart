import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/blocs/login/loginUI.dart';
import 'package:project/blocs/signup/bloc/siginupBloc.dart';
import 'package:project/blocs/signup/bloc/siginupEvents.dart';
import 'package:project/blocs/signup/bloc/siginupStates.dart';
import 'package:project/blocs/signup/model/siginupModel.dart';
import 'package:project/blocs/signup/repo/siginupRepo.dart';

import 'package:project/widget/MainButton.dart';
import 'package:project/widget/textfild.dart';

class SignUpPageUI extends StatefulWidget {
  const SignUpPageUI({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPageUI> {
  TextEditingController userFName = TextEditingController();
  TextEditingController userLName = TextEditingController();
  TextEditingController userGender = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignupBloc>(
          create: (BuildContext context) => SignupBloc(SignupRepository()),
        ),
      ],
      child: Scaffold(
        body: blocBody(),
      ),
    );
  }

  bool showPassword = false;

  Widget blocBody() {
    return BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
      if (state is SignupLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is SignupSuccess) {
        return const LoginPageUI();
      } else {
        return Scaffold(
            backgroundColor: Colors.black,
            body: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: SingleChildScrollView(
                    child: Container(
                  key: Key('containerholder'),
                  height: 900,
                  width: 500,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0XFF00B686), Color(0XFF00838F)])),
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      const Text(
                        key: Key('signupscreenheading'),
                        'Create Your Account',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 4.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      const Text(
                        key: Key('signupinstruction'),
                        'Please fill in the form to continue',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2.5,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, right: 300, top: 0),
                        child: Text(
                          'First Name',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 1.0,
                      ),
                      textfild(
                        const Text(
                          'first name',
                          style: TextStyle(color: Colors.white),
                        ),
                        const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        Colors.black,
                        userFName,
                        TextInputType.text,
                        Key("firstnametextfield"),
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, right: 300, top: 0),
                        child: Text(
                          'Last Name',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 1.0,
                      ),
                      textfild(
                        const Text(
                          'last name',
                          style: TextStyle(color: Colors.white),
                        ),
                        const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        Colors.black,
                        userLName,
                        TextInputType.text,
                        Key("lastnametextfield"),
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, right: 300, top: 0),
                        child: Text(
                          'Password',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 1.0,
                      ),
                      textfild(
                        const Text(
                          'password',
                          style: TextStyle(color: Colors.white),
                        ),
                        const Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        ),
                        Colors.black,
                        userPassword,
                        TextInputType.text,
                        Key("passwordtextfield"),
                      ),
                      const SizedBox(height: 3.0),
                      const Padding(
                        padding: EdgeInsets.only(left: 4, right: 312, top: 0),
                        child: Text(
                          'Email',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 1.0,
                      ),
                      textfild(
                        const Text(
                          'email',
                          style: TextStyle(color: Colors.white),
                        ),
                        const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        Colors.black,
                        userEmail,
                        TextInputType.emailAddress,
                        Key("emailtextfield"),
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8, right: 310, top: 0),
                        child: Text(
                          'Gender',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 1.0,
                      ),
                      textfild(
                        const Text(
                          'gender',
                          style: TextStyle(color: Colors.white),
                        ),
                        const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        Colors.black,
                        userGender,
                        TextInputType.text,
                        Key("gendertextfield"),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8, right: 310, top: 0),
                        child: Text(
                          'Phone No',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 1.0,
                      ),
                      textfild(
                        const Text(
                          'phone no',
                          style: TextStyle(color: Colors.white),
                        ),
                        const Icon(
                          Icons.smartphone,
                          color: Colors.white,
                        ),
                        Colors.black,
                        userPhone,
                        TextInputType.number,
                        Key("phonetextfield"),
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      Column(children: [
                        MainButton(
                          key: Key("signupbutton"),
                          onTap: () {
                            final signupModel = SignupModel(
                              firstName: userFName.text,
                              lastName: userLName.text,
                              gender: userGender.text,
                              password: userPassword.text,
                              email: userEmail.text,
                              phonenumber: userPhone.text,
                            );
                            BlocProvider.of<SignupBloc>(context)
                                .add(SignupButtonPressed(signupModel));
                          },
                          btncolor: const Color.fromARGB(0, 7, 6, 6),
                          text: const Text('Sign up',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: RichText(
                                text: const TextSpan(children: [
                              TextSpan(
                                  text: "Already have an account? ",
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white)),
                              TextSpan(
                                  text: "Log in",
                                  style: TextStyle(
                                    color: Color(0XFF00B686),
                                    fontSize: 14.0,
                                  ))
                            ])))
                      ]),
                    ],
                  ),
                ))));
      }
    });
  }
}

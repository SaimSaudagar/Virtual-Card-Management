import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  FocusNode ph_num = FocusNode();
  FocusNode passwordN = FocusNode();
  final List<String> gender = [
    'Male',
    'Female',
  ];
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
      }
      if (state is SignupFailure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        });
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
                          key: Key('firstnameicon'),
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
                          key: Key('lastnameicon'),
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
                      password(),
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
                          key: Key("emailicon"),
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
                          key: Key("gendericon"),
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
                      phoneNumber(),
                      const SizedBox(
                        height: 3.0,
                      ),
                      Column(children: [
                        MainButton(
                          key: Key("signupbutton"),
                          onTap: () {
                            if (userFName.text.isEmpty ||
                                userLName.text.isEmpty ||
                                userGender.text.isEmpty ||
                                userPhone.text.isEmpty ||
                                userEmail.text.isEmpty ||
                                userPassword.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please fill all the fields'),
                                ),
                              );
                              return;
                            } else if (!isValidEmail(userEmail.text)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please enter a valid email address'),
                                ),
                              );
                              return;
                            } else if (userPassword.text.length < 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'password must be at least 8 characters'),
                                ),
                              );
                              return;
                            } else if (userGender.text != 'male' &&
                                userGender.text != 'female') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Gender can only be male or female'),
                                ),
                              );
                              return;
                            } else if (!isValidNumber(userPhone.text)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Phone number not long enough, should be 11 digits and should start with 03'),
                                ),
                              );
                            } else {
                              final signupModel = SignupModel(
                                firstName: userFName.text,
                                lastName: userLName.text,
                                gender: userGender.text,
                                phonenumber: userPhone.text,
                              );

                              BlocProvider.of<SignupBloc>(context).add(
                                  SignupButtonPressed(signupModel,
                                      userEmail.text, userPassword.text));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Singup Successful'),
                                ),
                              );
                            }
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
      return const LoginPageUI();
    });
  }

  Padding phoneNumber() {
    bool showPhoneNumber = false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        height: 70.0,
        decoration: BoxDecoration(
          color: const Color.fromARGB(19, 211, 209, 209),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 360.0,
              child: StatefulBuilder(
                builder: (context, setState) {
                  return TextFormField(
                    key: Key("phonetextfield"),
                    keyboardType: TextInputType.phone,
                    focusNode: ph_num,
                    controller: userPhone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 3.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding password() {
    bool showPassword = false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        height: 70.0,
        decoration: BoxDecoration(
          color: const Color.fromARGB(19, 211, 209, 209),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 360.0,
              // padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return TextField(
                    key: Key('passwordtextfield'),
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: passwordN,
                    controller: userPassword,
                    obscureText: !showPassword,
                    style: const TextStyle(color: Colors.white),
                    // textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 3.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'password',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      prefixIcon: const Icon(
                        key: Key('passwordicon'),
                        Icons.lock,
                        color: Colors.white,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: showPassword ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    // Regular expression pattern for email validation
    final emailRegex =
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';

    // Create a RegExp object with the email pattern
    final regex = RegExp(emailRegex);

    // Return true if the email matches the pattern, false otherwise
    return regex.hasMatch(email);
  }

  bool isValidNumber(String phoneNumber) {
    if (phoneNumber.length == 11 && phoneNumber.startsWith('03')) {
      return true;
    } else {
      return false;
    }
  }
}

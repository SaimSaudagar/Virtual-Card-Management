import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/blocs/card/addCardUI.dart';
import 'package:project/blocs/login/loginUI.dart';
import 'package:project/blocs/update/bloc/updateBloc.dart';
import 'package:project/blocs/update/bloc/updateEvents.dart';
import 'package:project/blocs/update/bloc/updateStates.dart';
import 'package:project/blocs/update/model/updateModel.dart';
import 'package:project/blocs/update/repo/updateRepo.dart';
import 'package:project/widget/MainButton.dart';
import 'package:project/widget/bottom_navigation.dart';

class UpdateUI extends StatefulWidget {
  const UpdateUI({super.key});

  @override
  State<UpdateUI> createState() => _UpdateState();
}

class _UpdateState extends State<UpdateUI> {
  final TextEditingController FirstName = TextEditingController();
  FocusNode first = FocusNode();
  final TextEditingController LastName = TextEditingController();
  FocusNode last = FocusNode();
  final TextEditingController Email = TextEditingController();
  FocusNode email = FocusNode();
  final TextEditingController Password = TextEditingController();
  FocusNode pwd = FocusNode();
  final TextEditingController PhoneNumber = TextEditingController();
  FocusNode ph_num = FocusNode();

  @override
  void initState() {
    // super.initState();
    // first.addListener(() {
    //   setState(() {});
    // });
    // last.addListener(() {
    //   setState(() {});
    // });
    // email.addListener(() {
    //   setState(() {});
    // });
    // pwd.addListener(() {
    //   setState(() {});
    // });
    // ph_num.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UpdateUIBloc>(
          create: (BuildContext context) => UpdateUIBloc(UpdateUIRepository()),
        ),
      ],
      child: Scaffold(
        body: blocBody(),
      ),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) =>
          UpdateUIBloc(UpdateUIRepository())..add(UserLoadEvent()),
      child:
          BlocBuilder<UpdateUIBloc, UpdateUIState>(builder: (context, state) {
        if (state is UpdatedUser) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => bottomNavigation()));
          });
        }

        if (state is UpdatedUserLogout) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => LoginPageUI()));
          });
        }
        if (state is DeletedUser) {
          Navigator.pop(context);
        }
        if (state is UpdateUIProcessing) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UpdateUISuccess) {
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            body: SafeArea(
                child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                background_container(context),
                Positioned(
                  top: 120,
                  child: main_container(state, context),
                )
              ],
            )),
          );
        }
        return Container();
      }),
    );
  }

  Padding ChangeFirstName(String firstName) {
    FirstName.text = firstName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        focusNode: first,
        controller: FirstName,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'First Name',
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey.shade500,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color(0XFF00B686))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color(0XFF00838F)))),
      ),
    );
  }

  Padding ChangeLastName(String lastName) {
    LastName.text = lastName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        focusNode: last,
        controller: LastName,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Last Name',
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey.shade500,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color(0XFF00B686))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color(0XFF00838F)))),
      ),
    );
  }

  Padding ChangePassword() {
    bool showPassword =
        false; // Add a boolean variable to track the state of the password visibility

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        keyboardType: TextInputType.visiblePassword,
        focusNode: pwd,
        controller: Password,
        obscureText:
            !showPassword, // Set obscureText based on the showPassword variable
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'Password',
          labelStyle: TextStyle(
            fontSize: 17,
            color: Colors.grey.shade500,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: Color(0XFF00B686)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: Color(0XFF00838F)),
          ),
          suffixIcon: IconButton(
            // Add a suffixIcon to the input field
            icon: Icon(
              showPassword ? Icons.visibility : Icons.visibility_off,
              color: showPassword ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              // Toggle the showPassword variable when the button is pressed
              setState(() {
                showPassword = !showPassword;
              });
            },
          ),
        ),
      ),
    );
  }

  Padding ChangeEmail(String userEmail) {
    Email.text = userEmail;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        focusNode: email,
        controller: Email,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Email',
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey.shade500,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color(0XFF00B686))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color(0XFF00838F)))),
      ),
    );
  }

  Padding ChangePhoneNumber(String phoneNumber) {
    PhoneNumber.text = phoneNumber;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        focusNode: ph_num,
        controller: PhoneNumber,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ],
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Phone Number',
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey.shade500,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color(0XFF00B686))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color(0XFF00838F)))),
      ),
    );
  }

  Container main_container(UpdateUISuccess state, BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            height: 600,
            width: 340,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                ChangeFirstName(state.updatedUser.firstName),
                const SizedBox(
                  height: 30,
                ),
                ChangeLastName(state.updatedUser.lastName),
                const SizedBox(
                  height: 30,
                ),
                ChangeEmail(state.updatedUser.email),
                const SizedBox(
                  height: 30,
                ),
                ChangePassword(),
                const SizedBox(
                  height: 30,
                ),
                ChangePhoneNumber(state.updatedUser.phoneNumber),
                const SizedBox(
                  height: 50,
                ),
                UpdateButton(context),
                const SizedBox(
                  height: 20,
                ),
                DeleteButton(context),
              ],
            )),
      ),
    );
  }

  MainButton UpdateButton(BuildContext context) {
    return MainButton(
      onTap: () {
        final updatedUser = UpdateUserModel(
          firstName: FirstName.text,
          lastName: LastName.text,
          password: Password.text,
          email: Email.text,
          phoneNumber: PhoneNumber.text,
        );

        if (Password.text.length < 6) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                    'Please enter your current password if you dont want to change it'),
                content:
                    const Text('Password must be at least 6 characters long'),
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
        } else {
          BlocProvider.of<UpdateUIBloc>(context)
              .add(UpdateButtonPressed(updatedUser));
        }
      },
      btncolor: Color.fromARGB(0, 14, 14, 14),
      text: Text('Update',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  MainButton DeleteButton(BuildContext context) {
    return MainButton(
      onTap: () {
        BlocProvider.of<UpdateUIBloc>(context).add(DeleteButtonPressed());
      },
      btncolor: Color.fromARGB(0, 14, 14, 14),
      text: Text('Delete',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  Column background_container(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          width: 500,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0XFF00B686), Color(0XFF00838F)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          child: Column(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   child: const Icon(
                    //     Icons.arrow_back,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    Text('Update Your Information',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600)),
                    Icon(
                      Icons.attach_file_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

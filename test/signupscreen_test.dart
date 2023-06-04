import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/blocs/signup/siginupUI.dart';

void main() {
  testWidgets('Signup Screen Renders All The Required Widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));

    final signupscreenheading =
        find.byKey(const ValueKey('signupscreenheading'));
    final instruction = find.byKey(const ValueKey("signupinstruction"));
    final signupbtn = find.byKey(const ValueKey('signupbutton'));
    final containerhold = find.byKey(const ValueKey('containerholder'));

    expect(signupscreenheading, findsOneWidget);
    expect(instruction, findsOneWidget);
    expect(find.bySubtype<TextField>(), findsNWidgets(6));
    expect(find.byType(Text), findsNWidgets(15));
    expect(find.byType(Icon), findsNWidgets(6));
    expect(signupbtn, findsOneWidget);
    expect(containerhold, findsOneWidget);
  });

  testWidgets('Checking First Name Field Visibility and Functionality',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));

    final firstname = find.text('First Name');
    expect(firstname, findsOneWidget);
// add a key inside the Icon of textfild as 'firstnameicon'
    final firstnamefield = find.byKey(const ValueKey('firstnameicon'));
    expect(firstnamefield, findsOneWidget);
  });

  testWidgets('Checking Last Name Field Visibility and Functionality',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));

    final lastname = find.text('Last Name');
    expect(lastname, findsOneWidget);
// add a key inside the Icon of textfild as 'lastnameicon'
    final lastnamefield = find.byKey(const ValueKey('lastnameicon'));
    expect(lastnamefield, findsOneWidget);
    final userValidlastname = TextEditingController();
    userValidlastname.text = 'female';
    final islastnameTextValid =
        RegExp(r'^[a-zA-Z]+$').hasMatch(userValidlastname.text);
    final islastnameValid = (userValidlastname.text.length <= 6 &&
            userValidlastname.text.length >= 4) &&
        islastnameTextValid;
    expect(islastnameValid, true);

    //checking for a invalid working
    final userlastnameInValid = TextEditingController();
    userlastnameInValid.text = '1234';
    final islastNameTextValid =
        RegExp(r'^[a-zA-Z]+$').hasMatch(userlastnameInValid.text);
    final isLastNameInValid = !(userlastnameInValid.text.length <= 6 &&
            userlastnameInValid.text.length >= 4) ||
        !islastNameTextValid;
    expect(isLastNameInValid, true);
  });

  testWidgets('Checking Password Field Visibility and Functionality',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));

    final password = find.text('Password');
    expect(password, findsOneWidget);
// add a key inside the Icon of textfild as 'passwordicon'
    final passwordfield = find.byKey(const ValueKey('passwordicon'));
    expect(passwordfield, findsOneWidget);

//checking that the legth of the password should atleast be 6
    final userPassword = TextEditingController();
    userPassword.text = 'passd';
    final isPasswordValid = userPassword.text.length < 6;
    expect(isPasswordValid, false);
  });

  testWidgets('Checking Email Field Visibility and Functionality',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));
    final email = find.text('Email');
    expect(email, findsOneWidget);
// add a key inside the Icon of textfild as 'emailicon'
    final emailfield = find.byKey(const ValueKey('emailicon'));
    expect(emailfield, findsOneWidget);

//checking if the email field accepts a valid email address
    final userEmailvalid = TextEditingController();
    userEmailvalid.text = 'test@example.com';
    final isValidEmail = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(userEmailvalid.text);
    expect(isValidEmail, true);

    //checking if the Email field  rejects an invalid email address
    final userEmailinvalid = TextEditingController();
    userEmailinvalid.text = 'invalid-email';
    final isInValidEmail =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
            .hasMatch(userEmailinvalid.text);
    expect(isInValidEmail, false);
  });

  testWidgets('Checking Gender Field Visibility and Functionality',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));
    final gender = find.text('Gender');
    expect(gender, findsOneWidget);
// add a key inside the Icon of textfild as 'gendericon'
    final genderfield = find.byKey(const ValueKey('gendericon'));
    expect(genderfield, findsOneWidget);

//checking that the gender field should not be accepting number or special characters
    final userValidgender = TextEditingController();
    userValidgender.text = 'female';
    final isGenderTextOnlyValid =
        RegExp(r'^[a-zA-Z]+$').hasMatch(userValidgender.text);
    final isGenderValid = (userValidgender.text.length <= 6 &&
            userValidgender.text.length >= 4) &&
        isGenderTextOnlyValid;
    expect(isGenderValid, true);

    //checking for a invalid working
    final userGenderInValid = TextEditingController();
    userGenderInValid.text = '1234';
    final isGenderTextOnlyInvalid =
        RegExp(r'^[a-zA-Z]+$').hasMatch(userGenderInValid.text);
    final isGenderInValid = !(userGenderInValid.text.length <= 6 &&
            userValidgender.text.length >= 4) ||
        !isGenderTextOnlyInvalid;
    expect(isGenderInValid, true);
  });

  testWidgets('Checking Phone Field Visibility and Functionality',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));
    final phone = find.text('Phone No');
    expect(phone, findsOneWidget);

    // add a key inside the Icon of textfild as 'phoneicon'
    final phonefield = find.byKey(const ValueKey('phoneicon'));
    expect(phone, findsOneWidget);

    //checking for a valid working
    final userValidphone = TextEditingController();
    userValidphone.text = '12345678910';
    final isCVVDigitsOnlyValid =
        RegExp(r'^[0-9]+$').hasMatch(userValidphone.text);
    final isCVVValid = userValidphone.text.length == 11 && isCVVDigitsOnlyValid;
    expect(isCVVValid, true);

    //checking for a invalid working
    final userInValidphone = TextEditingController();
    userInValidphone.text = 'invalid-cvv';
    final isCVVDigitsOnlyInvalid =
        RegExp(r'^[0-9]+$').hasMatch(userInValidphone.text);
    final isCVVInValid =
        userInValidphone.text.length != 11 || !isCVVDigitsOnlyInvalid;
    expect(isCVVInValid, true);
  });

  testWidgets('Test Singup button functionality and visibility',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));

    // Check if the add button is initially visible
    final signupbtn = find.byKey(const ValueKey('signupbutton'));
    expect(signupbtn, findsOneWidget);

    // Tapping on the add button
    await tester.tap(signupbtn);
    await tester.pumpAndSettle();

    //finding all the fields and then ensuring that they display the error text if they are left empty and the button is pressed
    final allfields = find.descendant(
        of: find.bySubtype<TextField>(),
        matching: find.text('Field can not be empty'));
    expect(allfields, findsNWidgets(6));

    // Checking here for the add button functionality
    // ... that is firbase user creation
  });
}

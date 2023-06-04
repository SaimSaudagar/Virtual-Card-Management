import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/blocs/signup/model/siginupModel.dart';
import 'package:project/blocs/signup/repo/siginupRepo.dart';
import 'package:project/blocs/signup/siginupUI.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockSignupRepository extends Mock implements SignupRepository {}

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
    expect(find.byType(Text), findsNWidgets(21));
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

    final textField =
        tester.widget<TextField>(find.byKey(ValueKey('firstnametextfield')));
    expect(textField.controller!.text, equals(''));

    await tester.enterText(
        find.byKey(ValueKey('lastnametextfield')), 'abcdefg');
    expect(RegExp(r'^[a-zA-Z]+$').hasMatch(textField.controller!.text), true);

    await tester.enterText(find.byKey(ValueKey('lastnametextfield')), '123456');
    expect(RegExp(r'^[a-zA-Z]+$').hasMatch(textField.controller!.text), false);
  });

  testWidgets('Checking Last Name Field Visibility and Functionality',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));

    final lastname = find.text('Last Name');
    expect(lastname, findsOneWidget);
// add a key inside the Icon of textfild as 'lastnameicon'
    final lastnamefield = find.byKey(const ValueKey('lastnameicon'));
    expect(lastnamefield, findsOneWidget);

    final textField =
        tester.widget<TextField>(find.byKey(ValueKey('lastnametextfield')));
    expect(textField.controller!.text, equals(''));

    await tester.enterText(
        find.byKey(ValueKey('lastnametextfield')), 'abcdefg');
    expect(RegExp(r'^[a-zA-Z]+$').hasMatch(textField.controller!.text), true);

    await tester.enterText(find.byKey(ValueKey('lastnametextfield')), '123456');
    expect(RegExp(r'^[a-zA-Z]+$').hasMatch(textField.controller!.text), false);
  });

  testWidgets('Checking Password Field Visibility and Functionality',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));

    final password = find.text('Password');
    expect(password, findsOneWidget);
// add a key inside the Icon of textfild as 'passwordicon'
    final passwordfield = find.byKey(const ValueKey('passwordicon'));
    expect(passwordfield, findsOneWidget);

    final textField =
        tester.widget<TextField>(find.byKey(ValueKey('passwordtextfield')));
    await tester.enterText(find.byKey(ValueKey('passwordtextfield')), '123456');
    expect(textField.controller!.text.length > 6, false);

    await tester.enterText(
        find.byKey(ValueKey('passwordtextfield')), '12345678');
    expect(textField.controller!.text.length > 6, true);
  });

  testWidgets('Checking Email Field Visibility and Functionality',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));
    final email = find.text('Email');
    expect(email, findsOneWidget);
// add a key inside the Icon of textfild as 'emailicon'
    final emailfield = find.byKey(const ValueKey('emailicon'));
    expect(emailfield, findsOneWidget);

    final textField =
        tester.widget<TextField>(find.byKey(ValueKey('emailtextfield')));

/*checking if the email field accepts a valid email address
 final userEmailvalid = TextEditingController();
  userEmailvalid.text = 'test@example.com';
  final isValidEmail = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
      .hasMatch(userEmailvalid.text);
  expect(isValidEmail, true); 

  //checking if the Email field  rejects an invalid email address
  final userEmailinvalid = TextEditingController();
  userEmailinvalid.text = 'invalid-email';
  final isInValidEmail = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
      .hasMatch(userEmailinvalid.text);
  expect(isInValidEmail, false);*/
  });

  testWidgets('Checking Gender Field Visibility and Functionality',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));
    final gender = find.text('Gender');
    expect(gender, findsOneWidget);
// add a key inside the Icon of textfild as 'gendericon'
    final genderfield = find.byKey(const ValueKey('gendericon'));
    expect(genderfield, findsOneWidget);

    final textField =
        tester.widget<TextField>(find.byKey(ValueKey('gendertextfield')));

/*checking that the gender field should not be accepting number or special characters
  final userValidgender = TextEditingController();
    userValidgender.text = 'female';
    final isGenderTextOnlyValid = RegExp(r'^[a-zA-Z]+$').hasMatch(userValidgender.text);
    final isGenderValid = (userValidgender.text.length <= 6 && userValidgender.text.length >= 4 )&&  isGenderTextOnlyValid;
    expect(isGenderValid, true);

    //checking for a invalid working
    final userGenderInValid = TextEditingController();
    userGenderInValid.text = '1234';
    final isGenderTextOnlyInvalid = RegExp(r'^[a-zA-Z]+$').hasMatch(userGenderInValid.text);
    final isGenderInValid =  !(userGenderInValid.text.length <= 6 && userValidgender.text.length >= 4 ) || !isGenderTextOnlyInvalid;
    expect(isGenderInValid, true);*/
  });

  testWidgets('Checking Phone Field Visibility and Functionality',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));
    final phone = find.text('Phone No');
    expect(phone, findsOneWidget);

    // add a key inside the Icon of textfild as 'phoneicon'
    final phonefield = find.byKey(const ValueKey('phoneicon'));
    expect(phone, findsOneWidget);

    final textField =
        tester.widget<TextField>(find.byKey(ValueKey('phonetextfield')));

    /*checking for a valid working
  final userValidphone = TextEditingController();
  userValidphone.text = '12345678910';
  final isCVVDigitsOnlyValid = RegExp(r'^[0-9]+$').hasMatch(userValidphone.text);
  final isCVVValid = userValidphone.text.length == 11 && isCVVDigitsOnlyValid;
  expect(isCVVValid, true);

  //checking for a invalid working
  final userInValidphone = TextEditingController();
  userInValidphone.text = 'invalid-cvv';
  final isCVVDigitsOnlyInvalid = RegExp(r'^[0-9]+$').hasMatch(userInValidphone.text);
  final isCVVInValid = userInValidphone.text.length != 11 || !isCVVDigitsOnlyInvalid;
  expect(isCVVInValid, true);*/
  });

  testWidgets('Test Singup button functionality and visibility',
      (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
        MaterialApp(home: SignUpPageUI(), navigatorObservers: [mockObserver]));

    // Check if the add button is initially visible
    final signupbtn = find.byKey(const ValueKey('signupbutton'));
    expect(signupbtn, findsOneWidget);

    // Tapping on the add button
    await tester.tap(signupbtn);
    await tester.pumpAndSettle();

    //finding all the fields and then ensuring that they display the error text if they are left empty and the button is pressed

    final signupModel = SignupModel(
      // email: 'test@example.com',
      firstName: 'John',
      lastName: 'Doe',
      // password: 'password',
      gender: 'Male',
      phonenumber: '1234567890',
    );

// to check if the navigation is taking place properly
//verify(mockObserver.didPush(any, any)).called(1);
    // Checking here for the add button functionality
    // ... that is firbase user creation
  });
}

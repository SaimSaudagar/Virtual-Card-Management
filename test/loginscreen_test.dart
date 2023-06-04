import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project/blocs/login/loginUI.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  final mockObserver = MockNavigatorObserver();

/*test('Email field is required', () {
final userEmail = TextEditingController();

userEmail.text = '';

expect(userEmail.text.isEmpty, true);
});

test('Password field is required', () {
  final userPassword = TextEditingController(); 

  userPassword.text = '';

  expect(userPassword.text.isEmpty, true);
});

/*test('Sign in with valid credentials', () async {
  final userEmail = TextEditingController();
  final userPassword = TextEditingController();
  	
  userEmail.text = 'a@a.com';
  userPassword.text = 'saim1234';
  
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: userEmail.text,
    password: userPassword.text,
  );
  
  expect(FirebaseAuth.instance.currentUser, isNotNull);
});*/

test('Password should atleast have a length of 6', () {
  final userPassword = TextEditingController();
  
  // Simulating a password with less than the minimum length
  userPassword.text = 'passwd';
  
  // Perform the validation
  final isPasswordValid = userPassword.text.length < 6;
  expect(isPasswordValid, false);
});

test('Email field should accept a valid email address', () {
 final userEmail = TextEditingController();
 
  userEmail.text = 'test@example.com';

  final isValidEmail = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
      .hasMatch(userEmail.text);
  expect(isValidEmail, true); 
});

test('Email field should reject an invalid email address', () {
  final userEmail = TextEditingController();
  
  userEmail.text = 'invalid-email';
  // Perform the validation
  final isValidEmail = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
      .hasMatch(userEmail.text);
  expect(isValidEmail, false);
});*/

//works  successfully
  testWidgets('Login Screen Renders All The Required Widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPageUI()));

    final loginheading1 = find.byKey(const ValueKey("welcomeback"));
    final loginheading2 = find.byKey(const ValueKey("signintoyouraccount"));
    final emailheading = find.byKey(const ValueKey("emailheading"));
    final passwordheading = find.byKey(const ValueKey("passwordheading"));
// final connectwithtxt = find.byKey(const ValueKey("connectwithtext"));
    final forgotpasswordtxt = find.byKey(const ValueKey("forgotpasswordtext"));
    final loginbtn = find.byKey(const ValueKey("loginbutton"));
    // final image = find.byKey(const ValueKey("image"));
    // final googlebtn = find.byKey(const ValueKey("googlebutton"));
    final signupbutton = find.byKey(const ValueKey('signupbutton'));

    expect(loginheading1, findsOneWidget);
    expect(loginheading2, findsOneWidget);
    expect(emailheading, findsOneWidget);
    expect(passwordheading, findsOneWidget);
    // expect(connectwithtxt, findsOneWidget);
    expect(forgotpasswordtxt, findsOneWidget);
    expect(loginbtn, findsOneWidget);
    // expect(image, findsNWidgets(2));
    // expect(googlebtn, findsOneWidget);
    expect(find.byType(Icon), findsNWidgets(3));
    expect(signupbutton, findsOneWidget);
    expect(find.bySubtype<TextField>(), findsNWidgets(2));
  });

  testWidgets('Email Field', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPageUI()));
    final emailfield = find.bySubtype<TextField>().first;
    expect(emailfield, findsOneWidget);

    final textField = tester.widget<TextField>(emailfield);
    expect(textField.controller!.text, equals(''));
    await tester.enterText(emailfield, 'abcd@efg.com');
    expect(
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
            .hasMatch(textField.controller!.text),
        true);

    await tester.enterText(emailfield, 'abcd@efg.com');
    expect(
        !RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
            .hasMatch(textField.controller!.text),
        false);
  });

  testWidgets('Password Field', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPageUI()));

    final passwordfield = find.bySubtype<TextField>().last;
    expect(passwordfield, findsOneWidget);

    final textField = tester.widget<TextField>(passwordfield);
    expect(textField.controller!.text, equals(''));

    //checking if what we are entering in the field is being entered
    await tester.enterText(passwordfield, '300');
    expect(textField.controller!.text, equals('300'));

    await tester.pump();
  });

  //need to do some initialization for forgot password
  testWidgets('Forgot Password Button', (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: LoginPageUI(), navigatorObservers: []));

    final forgotpwdbutton = find.byKey(const ValueKey("forgotpasswordtext"));
    expect(forgotpwdbutton, findsOneWidget);

    // await tester.tap(forgotpwdbutton);
    // await tester.pumpAndSettle();

    //Need to check here that the navigation to signup page takes place
    //expect(find.text('Forgot Password'), findsOneWidget);
  });

  testWidgets('Signup Button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPageUI()));
    final signupbutton = find.byKey(const ValueKey('signupbutton'));
    expect(signupbutton, findsOneWidget);

    await tester.tap(signupbutton);
    await tester.pumpAndSettle();

    //Need to check here that the navigation to signup page takes place
    //expect(find.text('Create Your Account'), findsOneWidget);
  });
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/blocs/signup/siginupUI.dart';


void main() {
 
testWidgets('Signup Screen Renders All The Required Widgets', (WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));

final signupscreenheading =  find.byKey(const ValueKey('signupscreenheading'));
final instruction = find.byKey(const ValueKey("signupinstruction"));
  final signupbtn = find.byKey(const ValueKey('signupbutton'));
  final containerhold = find.byKey(const ValueKey('containerholder'));

  expect(signupscreenheading, findsOneWidget);
  expect(instruction, findsOneWidget);
  expect(find.bySubtype<TextField>(),findsNWidgets(6));
  expect(find.byType(Text), findsNWidgets(15));
  expect(find.byType(Icon), findsNWidgets(6));
  expect(signupbtn,findsOneWidget);
  expect(containerhold, findsOneWidget);
});

testWidgets('Checking First Name Field Visibility and Functionality', (WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));

final firstname =  find.byKey(const ValueKey("firstnametextfield"));

 

 
});

testWidgets('Checking Last Name Field Visibility and Functionality', (WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));

 
});

testWidgets('Checking Email Field Visibility and Functionality', (WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));

 
});

testWidgets('Checking Gender Field Visibility and Functionality', (WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));

 
});

testWidgets('Checking Phone Field Visibility and Functionality', (WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: SignUpPageUI()));

 
});



}

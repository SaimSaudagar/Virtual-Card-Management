import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/blocs/forgotpassword/forgotPasswordUI.dart';



void main() {
 
testWidgets('Forgot Password Screen Renders All The Required Widgets', (WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: ForgotPasswordUI()));

  final sendrequestbtn = find.byKey(const ValueKey('sendrequest'));

  expect(sendrequestbtn,findsOneWidget);
  expect(find.byType(Image), findsOneWidget);
});
}

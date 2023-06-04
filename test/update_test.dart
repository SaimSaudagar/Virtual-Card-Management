import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/blocs/update/updateUI.dart';
import 'package:project/widget/MainButton.dart';

void main() {
  testWidgets('Checking Update Screen Texts and Icon Visibility',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: UpdateUI()));

    //check if the  Update Your Information Heading is visible on Screen
    final updatescreenheading = find.byKey(const ValueKey('updatescreenheading'));
    expect(updatescreenheading, findsOneWidget);

    //check if the backgtoundcontainer with gradient appears
    final background = find.byKey(ValueKey('backgroundcontainer'));
    expect(background, findsOneWidget);

    //check if the total number of icons on the screen are 3 i.e backarrow, pin, person, cvv
    expect(find.byType(Icon), findsNWidgets(1));
  });
  testWidgets('Testing add button functionality and visibility',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: UpdateUI()));

    // Check if the add button is initially visible
    final updatebtn = find.byKey(const ValueKey('updatebutton'));
    expect(updatebtn, findsOneWidget);

    // Tapping on the add button
    await tester.tap(updatebtn);
    await tester.pumpAndSettle();

    // Checking here for the add button functionality
    // ...
  });

  testWidgets('Testing Delete button functionality and visibility',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: UpdateUI()));

    // Check if the add button is initially visible
    final deletebtn = find.widgetWithText(MainButton, 'Delete');
    expect(deletebtn, findsOneWidget);

    // Tapping on the add button
    await tester.tap(deletebtn);
    await tester.pumpAndSettle();

    // Checking here for the add button functionality
    // ...
  });
}

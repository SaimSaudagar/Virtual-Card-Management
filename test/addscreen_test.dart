import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/blocs/add/addUI.dart';

void main() {
  testWidgets('Background Container', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Add()));

    final background = find.byKey(ValueKey('background_container'));
    expect(background, findsOneWidget);

    final addscreenheading = find.text('Adding');
    expect(addscreenheading, findsOneWidget);

    // expect(find.byType(Icon), findsNWidgets(2));
    expect(find.byType(Text), findsNWidgets(11));
  });

//'Checking the visibility and functionality of Name drop down'
  testWidgets('Name drop down', (WidgetTester tester) async {
    String? selectedItem;
    final List<String> dropdown_item = [
      'Food',
      'Education',
      'Utility',
      'Upwork',
      'Starbucks'
    ];
    await tester.pumpWidget(const MaterialApp(home: Add()));

    // finding the name()
    final transaction_name = find.text('Name');
    expect(transaction_name, findsOneWidget);

    final dropdownButtonFinder = find.byType(DropdownButton<String>);
    expect(dropdownButtonFinder, findsOneWidget);

    await tester.tap(dropdownButtonFinder);
    await tester.pumpAndSettle();

//checking that all the items mentione in the list appear in the drop down when the drop down button is tapped
    for (String item in dropdown_item) {
      expect(find.text(item), findsAtLeastNWidgets(2));
    }

//     await tester.tap(find.text(dropdown_item[0]));
//     await tester.pumpAndSettle();
// // Verify the selected item
//     expect(find.text(dropdown_item[0]), findsOneWidget);
  });

//'Checking the visibility and functionality of Explanation TextField'
  testWidgets('Explanation TextField', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Add()));

    // finding the explanation()
    final explainfield = find.byKey(ValueKey('explaintextfield'));
    expect(explainfield, findsOneWidget);

    final explaintext = find.text('Explain');
    expect(explaintext, findsOneWidget);

    final textField =
        tester.widget<TextField>(find.byKey(ValueKey('explaintextfield')));
    //checking that the initial state of the explanation text field is empty
    expect(textField.controller!.text, equals(''));

    //checking if what we entered is being entered in the text field on the screen
    await tester.enterText(explainfield, 'Example explanation');
    expect(textField.controller!.text, equals('Example explanation'));
  });

//'Checking the visibility and functionality of Amount TextField'
  testWidgets('Amount TextField', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Add()));

    // finding the amount()
    final amountfield = find.byKey(ValueKey('amountfield'));
    expect(amountfield, findsOneWidget);

    final amounttext = find.text('Amount');
    expect(amounttext, findsOneWidget);

    final textField = tester.widget<TextField>(amountfield);
    expect(textField.controller!.text, equals(''));

    await tester.enterText(amountfield, '300');
    expect(textField.controller!.text, equals('300'));

    //NEED TO CHECK HERE ALSO THAT THIS FIELD DOESNOT TAKES ALPHABETS
    // final errorTextFinder = find.text('can only enter numbers');
    // await tester.enterText(amountfield, 'abc');
    // await tester.pump();
    // expect(errorTextFinder, findsOneWidget);
  });

//'Checking the visibility and functionality of Date Time Field'
  testWidgets('Date Time Field', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Add()));

    // finding the date_time()
    final datetimefield = find.byKey(ValueKey('date_time'));
    expect(datetimefield, findsOneWidget);
  });

  testWidgets('Add Button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Add()));

    final addbutton = find.byKey(ValueKey('addbutton'));
    expect(addbutton, findsOneWidget);

    //CHECK HERE WHAT HAPPENS WHEN THE ADD BUTTON IS PRESSED, DOES IT ENTERS THE TRANSACTION DETAIL? DOES IT NAVIGATES?
  });
}

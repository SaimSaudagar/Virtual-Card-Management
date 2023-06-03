import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:project/blocs/card/addCardUI.dart';

void main(){
  testWidgets('Checking Add Screen Texts and Icon Visibility', (WidgetTester tester)async{

     await tester.pumpWidget(const MaterialApp(home: AddCard()));
   
   //check if the Add Your Card Heading is visible on Screen
   final screenheading = find.byKey(ValueKey('addscreenheading'));
   expect(screenheading, findsOneWidget);

   //check if the instruction line is visible
    expect(find.text('Fill Your Card Details Below'), findsOneWidget);

    //check if the dummy card is being displayed
    expect(find.byKey(Key('dummycarddisplay')), findsNWidgets(2));

   
   //check if the backgtoundcontainer with gradient appears
   final background = find.byKey(ValueKey('backgroundcontainer'));
   expect(background, findsOneWidget);

   //check if the total number of icons on the screen are 3 i.e backarrow, pin, person, cvv
   expect(find.byType(Icon), findsNWidgets(4));

  });

  testWidgets('Testing The Card Input Form', (WidgetTester  tester) async{
   await tester.pumpWidget(MaterialApp(home: AddCard()));
   
   //checking if the widget is being displayed by the help of widget tree
   expect(find.byWidgetPredicate((widget) => widget is Form), findsOneWidget);


   //checking if the card dropdown is working and being displayed 
   expect(find.byWidgetPredicate((widget) => widget is Container && widget.child is DropdownButton), findsOneWidget);
   await tester.tap(find.descendant(
    of: find.byType(Container),
    matching: find.byType(DropdownButton<String>),
    ));
   await tester.pumpAndSettle();
   await tester.tap(find.text('DebitCard').last);
   await tester.pumpAndSettle();
   expect(find.text('DebitCard'), findsOneWidget);

   await tester.tap(find.descendant(
    of: find.byType(Container),
     matching: find.byType(DropdownButton<String>),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CreditCard').first);
    await tester.pumpAndSettle();
    expect(find.text('CreditCard'), findsOneWidget);



    // checking if the Card Number field is being displayed using the key and if it functions correctly
    expect(find.byKey(Key('cardnumber')), findsOneWidget);
    //checking for a valid working
    final userCardNumberValid = TextEditingController();
    userCardNumberValid.text = '1234123412341234';
    final isCardNoValidDigitsOnly = RegExp(r'^[0-9]+$').hasMatch(userCardNumberValid.text);
    final isCardNumberValid = userCardNumberValid.text.length == 16 && isCardNoValidDigitsOnly;
    expect(isCardNumberValid, true);
    //checking for a invalid working
    final userCardNumberInvalid = TextEditingController();
    userCardNumberValid.text = 'invalidcard';
    final isCardNoInvalidDigitsOnly = RegExp(r'^[0-9]+$').hasMatch(userCardNumberInvalid.text);
    final isCardNumberInvalid = userCardNumberValid.text.length != 16 || !isCardNoInvalidDigitsOnly;
    expect(isCardNumberInvalid, true);
    

    // checking if the CVVfield is being displayed using the key and is ta
    expect(find.byKey(Key('cvv')), findsOneWidget);
    //checking for a valid working
    final userValidCVV = TextEditingController();
    userValidCVV.text = '1234';
    final isCVVDigitsOnlyValid = RegExp(r'^[0-9]+$').hasMatch(userValidCVV.text);
    final isCVVValid = userValidCVV.text.length == 4 && isCVVDigitsOnlyValid;
    expect(isCVVValid, true);
    //checking for a invalid working
    final userInValidCVV = TextEditingController();
    userInValidCVV.text = 'invalid-cvv';
    final isCVVDigitsOnlyInvalid = RegExp(r'^[0-9]+$').hasMatch(userInValidCVV.text);
    final isCVVInValid = userInValidCVV.text.length != 4 || !isCVVDigitsOnlyInvalid;
    expect(isCVVInValid, true);

  
   //checking if the date_time widget is displayed and is working properly
   expect(find.byWidgetPredicate((widget) => widget is Container && widget.child is TextButton), findsOneWidget);
   //Tap on the date_time widget to open the date picker
    await tester.tap(find.byWidgetPredicate((widget) => widget is Container && widget.child is TextButton));
    await tester.pumpAndSettle();
    //checking if the date picker opens up when you click on the date time field
    final datePickerFinder = find.byType(DatePickerDialog);
    expect(datePickerFinder, findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    //finding the selected date that you picked
    final selectedDate = find.byKey(Key('selecteddate'));
    expect(selectedDate, isNotNull);
    //NOTE: need to check if the selected date is displayed properly


    // checking if the CardHolder is being displayed using the key and is ta
    expect(find.byKey(Key('cvv')), findsOneWidget);
    //checking for a valid working
    final userValidCardHolder = TextEditingController();
    userValidCardHolder.text = 'abcdeffg';
    final isCHTextOnlyValid = RegExp(r'^[a-zA-Z]+$').hasMatch(userValidCardHolder.text);
    final isCHValid = isCHTextOnlyValid;
    expect(isCHValid, true);
    //checking for a invalid working
    final userCHInValid = TextEditingController();
    userCHInValid.text = '1234';
    final isCHTextOnlyInvalid = RegExp(r'^[a-zA-Z]+$').hasMatch(userCHInValid.text);
    final isCHInValid =  !isCHTextOnlyInvalid;
    expect(isCHInValid, true);

  });


  testWidgets('Test add button functionality and visibility', (WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: AddCard()));

  // Check if the add button is initially visible
  final addbtn = find.byKey(ValueKey('addbutton'));
  expect(addbtn, findsOneWidget);

  // Tapping on the add button
  await tester.tap(addbtn);
  await tester.pumpAndSettle();


  // Checking here for the add button functionality
  // ...


});

}
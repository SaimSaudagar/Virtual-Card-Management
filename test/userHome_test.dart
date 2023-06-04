import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/blocs/login/loginUI.dart';
import 'package:project/blocs/userhome/bloc/userHomeBloc.dart';
import 'package:project/blocs/userhome/bloc/userHomeEvents.dart';
import 'package:project/blocs/userhome/bloc/userHomeStates.dart';
import 'package:project/blocs/userhome/repo/userHomeRepo.dart';
import 'package:project/blocs/userhome/userHomeUI.dart';

void main() {
  setUpAll(() async {
    await Firebase.initializeApp();
  });
  testWidgets('UserHomeUI - Widget Tests', (WidgetTester tester) async {
    final userHomeBloc = UserHomeBloc(UserHomeRepository());

    await tester.pumpWidget(UserHomeUI());

    // Verify that CircularProgressIndicator is shown when loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Emit UserHomeSuccess state to test the UI when data is loaded successfully
    // userHomeBloc.emit(UserHomeSuccess());

    // Wait for the UI to rebuild
    await tester.pumpAndSettle();

    // Verify that CircularProgressIndicator is not shown anymore
    // expect(find.byType(CircularProgressIndicator()), findsNothing);

    // Verify that the available balance text is displayed
    expect(find.text('Available Balance'), findsOneWidget);

    // Verify that the user's name is displayed
    expect(find.text('John Doe'), findsOneWidget);

    // TODO: Add more test cases to verify the expected UI elements and behaviors
// Verify that the logout button triggers the expected navigation
    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpAndSettle();
    // expect(find.byType(const LoginPageUI()), findsOneWidget);

// Verify that the total balance is displayed correctly
    expect(find.text('\$500'), findsOneWidget);

// Verify that the transaction history title is displayed
    expect(find.text('Transaction History'), findsOneWidget);

// Verify that a specific transaction item is displayed correctly
    expect(find.text('Debit Card'), findsOneWidget);
    expect(find.text('Transaction explanation'), findsOneWidget);
    expect(find.text('\$50.00'), findsOneWidget);

    // Dispose the bloc to clean up
    userHomeBloc.close();
  });
}

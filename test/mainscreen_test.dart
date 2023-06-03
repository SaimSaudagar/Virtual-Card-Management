import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:project/main.dart';

void main() {
  testWidgets('Main Screen Renders All The Required Widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyHomePage()));

    final applogo = find.byKey(const ValueKey("applogo"));
    final catchline1 = find.byKey(const ValueKey("catchline1"));
    final catchline2 = find.byKey(const ValueKey("catchline2"));
    final appname = find.byKey(const ValueKey("appname"));
    final getstartbtn = find.byKey(const ValueKey("getstartbutton"));

    expect(applogo, findsOneWidget);
    expect(appname, findsOneWidget);
    expect(catchline1, findsOneWidget);
    expect(catchline2, findsOneWidget);
    expect(getstartbtn, findsOneWidget);
  });
}

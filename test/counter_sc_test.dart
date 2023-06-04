import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:project/main.dart';

void main() async {
  testGoldens('DeviceBuilder - multiple scenarios - with onCreate',
      (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
        Device.tabletPortrait,
        Device.tabletLandscape,
      ])
      ..addScenario(
        widget: MyApp(),
        name: 'sc page',
      );

    // ..addScenario(
    //   widget: App(),
    //   name: 'tap once',
    //   onCreate: (scenarioWidgetKey) async {
    //     final finder = find.descendant(
    //       of: find.byKey(scenarioWidgetKey),
    //       matching: find.byIcon(Icons.add),
    //     );
    //     expect(finder, findsOneWidget);
    //     await tester.tap(finder);
    //   },
    // )
    // ..addScenario(
    //   widget: App(),
    //   name: 'tap five times',
    //   onCreate: (scenarioWidgetKey) async {
    //     final finder = find.descendant(
    //       of: find.byKey(scenarioWidgetKey),
    //       matching: find.byIcon(Icons.add),
    //     );
    //     expect(finder, findsOneWidget);

    //     await tester.tap(finder);
    //     await tester.tap(finder);
    //     await tester.tap(finder);
    //     await tester.tap(finder);
    //     await tester.tap(finder);
    //   },
    // );

    await tester.pumpDeviceBuilder(
      builder,
      wrapper: materialAppWrapper(
        theme: ThemeData.light(),
        platform: TargetPlatform.android,
      ),
    );

    await screenMatchesGolden(tester, 'course_list_2');
  });
}

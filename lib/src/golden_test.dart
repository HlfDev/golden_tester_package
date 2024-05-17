import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_tester/golden_tester.dart';
import 'package:golden_tester/src/helper/extensions.dart';
import 'package:golden_tester/src/helper/responsive_test_widget.dart';

typedef GoldenWidgetBuilder = Widget Function();

void testGolden(
  String description,
  GoldenWidgetBuilder builder, {
  GoldenTestConfig config = const GoldenTestConfig(),
}) {
  for (var deviceSize in config.devices) {
    _addGoldenTest(description, builder, deviceSize, config);
  }
}

void _addGoldenTest(
  String description,
  GoldenWidgetBuilder builder,
  Device device,
  GoldenTestConfig config,
) {
  testWidgets('$description (${device.name})', (WidgetTester tester) async {
    final String getKeyName = '${description}_${device.name}';
    final widgetKey = Key(getKeyName);

    tester.binding.platformDispatcher.textScaleFactorTestValue =
        device.textScale;

    await tester.pumpWidget(
      ResponsiveTestWidget(
        child: builder(),
        device: device,
        key: widgetKey,
      ),
    );

    await tester.binding.setSurfaceSize(
      Size(
        device.width,
        device.height,
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(widgetKey),
      matchesGoldenFile(
        '${config.path}${getKeyName.toSnakeCase()}.png',
      ),
    );
  });
}

import 'dart:io';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import 'device_size.dart';
import 'golden_test_config.dart';

typedef GoldenWidgetBuilder = Widget Function();

Future<void> testGolden(
  String description,
  GoldenWidgetBuilder builder, {
  GoldenTestConfig config = const GoldenTestConfig(),
}) async {
  for (var deviceSize in config.deviceSizes) {
    await _testGolden(description, builder, deviceSize, config);
  }
}

Future<void> _testGolden(
  String description,
  GoldenWidgetBuilder builder,
  DeviceSize deviceSize,
  GoldenTestConfig config,
) async {
  testWidgets('$description (${deviceSize.name})', (
    WidgetTester tester,
  ) async {
    tester.binding.platformDispatcher.textScaleFactorTestValue =
        config.textScaleFactor;

    await tester.pumpWidget(builder());

    await tester.binding.setSurfaceSize(
      Size(
        deviceSize.width,
        deviceSize.height,
      ),
    );

    await tester.pumpAndSettle();

    final Directory tempDir = await getTemporaryDirectory();
    final String goldenPath =
        '${tempDir.path}/${description}_${deviceSize.name}.png';
    final File goldenFile = File(goldenPath);
    await _takeScreenshot(tester, goldenFile);

    final File expectedFile = File(
      'goldens/${description}_${deviceSize.name}.png',
    );

    if (!await _compareImages(
      goldenFile,
      expectedFile,
    )) {
      throw Exception(
        'Golden test failed: $goldenPath differs from expected image. See diff at ${tempDir.path}/diff_${goldenFile.uri.pathSegments.last}',
      );
    }
  });
}

Future<void> _takeScreenshot(WidgetTester tester, File file) async {
  final renderView = RendererBinding.instance.renderViews.first;

  final renderRepaintBoundary = renderView.child as RenderRepaintBoundary?;
  if (renderRepaintBoundary == null) {
    throw Exception(
      'Failed to capture screenshot: root render object is not a RenderRepaintBoundary',
    );
  }

  final image = await renderRepaintBoundary.toImage(pixelRatio: 1.0);
  final byteData = await image.toByteData(format: ImageByteFormat.png);
  await file.writeAsBytes(byteData!.buffer.asUint8List());
}

Future<void> _generateDiffReport(
    File image1, File image2, File diffFile) async {
  final img1 = img.decodeImage(await image1.readAsBytes());
  final img2 = img.decodeImage(await image2.readAsBytes());

  if (img1 == null || img2 == null) {
    throw Exception('Failed to decode images for comparison');
  }

  final diff = img.Image(img1.width, img1.height);
  final tolerance = 5;

  for (var y = 0; y < img1.height; y++) {
    for (var x = 0; x < img1.width; x++) {
      final color1 = img1.getPixel(x, y);
      final color2 = img2.getPixel(x, y);

      if (!_colorsAreClose(color1, color2, tolerance)) {
        diff.setPixel(x, y, img.getColor(255, 0, 0));
      } else {
        diff.setPixel(x, y, color1);
      }
    }
  }

  final diffBytes = img.encodePng(diff);
  await diffFile.writeAsBytes(diffBytes);
}

bool _colorsAreClose(int color1, int color2, int tolerance) {
  final r1 = img.getRed(color1);
  final g1 = img.getGreen(color1);
  final b1 = img.getBlue(color1);

  final r2 = img.getRed(color2);
  final g2 = img.getGreen(color2);
  final b2 = img.getBlue(color2);

  return (r1 - r2).abs() <= tolerance &&
      (g1 - g2).abs() <= tolerance &&
      (b1 - b2).abs() <= tolerance;
}

Future<bool> _compareImages(File image1, File image2) async {
  if (!await image2.exists()) {
    return false;
  }

  final img1 = img.decodeImage(await image1.readAsBytes());
  final img2 = img.decodeImage(await image2.readAsBytes());

  if (img1 == null || img2 == null) {
    throw Exception('Failed to decode images for comparison');
  }

  if (img1.width != img2.width || img1.height != img2.height) {
    return false;
  }

  final Directory tempDir = await getTemporaryDirectory();
  final diffFile = File('${tempDir.path}/diff_${image1.uri.pathSegments.last}');

  await _generateDiffReport(image1, image2, diffFile);

  return const DeepCollectionEquality().equals(img1.data, img2.data);
}

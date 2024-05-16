import 'device_size.dart';

class GoldenTestConfig {
  final List<DeviceSize> deviceSizes;
  final double textScaleFactor;

  const GoldenTestConfig({
    this.deviceSizes = DeviceSize.defaultSizes,
    this.textScaleFactor = 1.0,
  });

  GoldenTestConfig copyWith({
    List<DeviceSize>? deviceSizes,
    double? textScaleFactor,
    bool? boldText,
  }) {
    return GoldenTestConfig(
      deviceSizes: deviceSizes ?? this.deviceSizes,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
    );
  }
}

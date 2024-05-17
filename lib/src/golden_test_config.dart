import 'entities/device.dart';

class GoldenTestConfig {
  final List<Device> devices;
  final String path;

  const GoldenTestConfig({
    this.devices = Device.defaultSizes,
    this.path = "goldens/",
  });

  GoldenTestConfig copyWith({
    List<Device>? devices,
    double? textScaleFactor,
    bool? boldText,
    String? path,
  }) {
    return GoldenTestConfig(
      devices: devices ?? this.devices,
      path: path ?? this.path,
    );
  }
}

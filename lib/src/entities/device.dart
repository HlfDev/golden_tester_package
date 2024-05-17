class Device {
  final String name;
  final double width;
  final double height;
  final double textScale;
  final double devicePixelRatio;

  const Device({
    required this.name,
    required this.width,
    required this.height,
    required this.textScale,
    required this.devicePixelRatio,
  });

  static const List<Device> defaultSizes = [
    iphoneSE,
    iphone12ProMax,
    pixel4a,
    galaxyS21Ultra
  ];

  static const iphoneSE = Device(
    name: 'iPhone SE',
    width: 375,
    height: 667,
    textScale: 1.0,
    devicePixelRatio: 2.0,
  );

  static const iphone12ProMax = Device(
    name: 'iPhone 12 Pro Max',
    width: 428,
    height: 926,
    textScale: 1.0,
    devicePixelRatio: 3.0,
  );

  static const pixel4a = Device(
    name: 'Google Pixel 4a',
    width: 411,
    height: 731,
    textScale: 1.15,
    devicePixelRatio: 2.75,
  );

  static const galaxyS21Ultra = Device(
    name: 'Samsung Galaxy S21 Ultra',
    width: 480,
    height: 1013,
    textScale: 1.1,
    devicePixelRatio: 3.5,
  );
}

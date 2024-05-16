class DeviceSize {
  final String name;
  final double width;
  final double height;

  const DeviceSize({
    required this.name,
    required this.width,
    required this.height,
  });

  static const small = DeviceSize(name: 'small', width: 320, height: 480);
  static const medium = DeviceSize(name: 'medium', width: 768, height: 1024);
  static const large = DeviceSize(name: 'large', width: 1440, height: 2560);

  static const defaultSizes = [small, medium, large];
}

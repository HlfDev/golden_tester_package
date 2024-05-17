import 'package:flutter/material.dart';
import 'package:golden_tester/src/entities/device.dart';

class ResponsiveTestWidget extends StatelessWidget {
  final Widget child;
  final Device device;

  const ResponsiveTestWidget({
    required this.child,
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: device.width,
          height: device.height,
          child: MediaQuery(
            data: MediaQueryData(
              size: Size(device.width, device.height),
              devicePixelRatio: device.devicePixelRatio,
              textScaler: TextScaler.linear(device.textScale),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

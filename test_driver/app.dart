import 'package:flutter_qr_decoder/main.dart' as app;
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter/services.dart';
void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  const MethodChannel channel =
  MethodChannel('plugins.flutter.io/image_picker');

  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    final path = "/data/user/0/com.example.flutter_qr_decoder/cache/test.png";
    return path;
  });

  app.main();
}
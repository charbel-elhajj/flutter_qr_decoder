import 'dart:io';


void main(List<String> args) async {
  // The values needed for the test can be set this way
  final generator = 'http://127.0.0.1:56431/wqsuuFHLpTc=/';
  final decoder = 'http://127.0.0.1:49592/xmX7CC8qFR4=/';
  final decodingEmulator = 'emulator-5554';
  final text = "Tadaa!";

  // Or passed through parameter when executing the command
  // final generator = args[0];
  // final decoder = args[1];
  // final decodingEmulator = args[2];
  // final text = args[3];

  // Execute qr code generation test in first app
  final generationTest = await Process.run('dart', ['../flutter_qr_generator/test_driver/app_test.dart', generator, text]);
  print(generationTest.stdout);

  // Sending qr code screenshot to the decoding emulator's sd card through 'adb push'
  final toSdcard = await Process.run('adb', ['-s', decodingEmulator, 'push', '../test.png', '/sdcard/Pictures/test.png']);
  print(toSdcard.stdout);

  // Copying qr code from sd card to cache through 'adb shell' (with su)
  final toCache = await Process.run('adb', ['-s', decodingEmulator, 'shell', 'su 0 cp /sdcard/Pictures/test.png /data/user/0/com.example.flutter_qr_decoder/cache/test.png']);
  print(toCache.stdout);

  // Execute qr code scanning test in second app
  final decodingTest = await Process.run('dart', ['test_driver/app_test.dart', decoder, text]);
  print(decodingTest.stdout);

}

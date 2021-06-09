import 'dart:io';

import 'package:test/test.dart';

void main(List<String> args) async {
  group("QR code successful generation/decoding", (){
  // The values needed for the test can be set this way

    // final generator = 'http://127.0.0.1:57647/19cmjuMbggM=/';
    // final decoder = 'http://127.0.0.1:52943/XdA7tqC5gdo=/';
    // final decodingEmulator = 'emulator-5554';
    // final text = "Tadaa!";

    // Or passed through parameter when executing the command
    final generator = args[0];
    final decoder = args[1];
    final decodingEmulator = args[2];
    final text = args[3];

    setUpAll(() {
    });


    tearDownAll(() {
    });

    test(("QR code generation"), () async {
    // Execute qr code generation test in first app
      final generationTest = await Process.run('dart', ['../flutter_qr_generator/test_driver/app_test.dart', generator, text]);
      expect(generationTest.exitCode, 0);
    });

    test(("screenshot transfer"), () async{
    // Sending qr code screenshot to the decoding emulator's sd card through 'adb push'
    final toSdcard = await Process.run('adb', ['-s', decodingEmulator, 'push', '../test.png', '/sdcard/Pictures/test.png']);

    // Copying qr code from sd card to cache through 'adb shell' (with su)
    final toCache = await Process.run('adb', ['-s', decodingEmulator, 'shell', 'su 0 cp /sdcard/Pictures/test.png /data/user/0/com.example.flutter_qr_decoder/cache/test.png']);
    expect(toCache.exitCode, 0);
    });

    test(("QR code decoding"), () async {
    // Execute qr code scanning test in second app
      final decodingTest = await Process.run('dart', ['test_driver/app_test.dart', decoder, text]);
      expect(decodingTest.exitCode, 0);
    });

  });

}

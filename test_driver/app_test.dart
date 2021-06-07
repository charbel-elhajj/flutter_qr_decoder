// Imports the Flutter Driver API.
// import 'dart:convert';
// import 'dart:io';

import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';




void main(List<String> args) {

  group('QR Decoder App', () {


    final btnFinder = find.byType('FloatingActionButton');
    final scanResultFinder = find.byValueKey('scan_result');
    final text = args.length>=2?args[args.length-1]:'Success';

    print(args);

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect(dartVmServiceUrl:args.length>=1?args[args.length-2]:null);
    });
    

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });


    test('generate qr', () async {

      await driver.tap(btnFinder);


      // final List<int> pixels = await driver.screenshot();
      // final File file = File('./../test.png');
      // await file.writeAsBytes(pixels);
      sleep(Duration(seconds: 2));
      expect(await driver.getText(scanResultFinder), text);
    });
  });
}

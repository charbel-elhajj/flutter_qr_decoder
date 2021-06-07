import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_tools/qr_code_tools.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter QR Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter QR Scanner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _scannedText = 'Nothing (yet)';
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String qrCodeResult;
  final picker = ImagePicker();

  // Update scanned text
  void setScannedText(scannedText){
    setState(() {
      _scannedText = scannedText;
    });
  }

  Future getImage() async {
    // Pick image through image picker (when testing, this will be mocked and a path to a preset image will be returns)
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    // Decode qr code
    final data = await QrCodeToolsPlugin.decodeFrom(pickedFile.path);
    // Update scanned text
    setScannedText(data);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Wanna scan? I know it\'s tempting',
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children:[
                  Text("Scanned text:"),
                  Text(
                    _scannedText,
                    key: Key('scan_result'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Scan',
        child: Icon(Icons.qr_code_scanner),
      ),
    );
  }

}

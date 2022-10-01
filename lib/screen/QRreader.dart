import 'package:earnily/pages/home_page_kid.dart';
import 'package:earnily/screen/qrCreateScreen.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:earnily/pages/home_page.dart';
import 'package:earnily/screen/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../reuasblewidgets.dart';
import '../widgets/new_button.dart';

class QRreader extends StatefulWidget {
  const QRreader({Key? key, required this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;

  @override
  State<QRreader> createState() => _QRreaderState();
}

class _QRreaderState extends State<QRreader> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.resumeCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : const Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;

        (QrCreateScreenState.qrData == result)
            ? (MaterialPageRoute(builder: (context) => HomePage()))
            : const Text('Sorry an error accured');
      });
    }*/

      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.01, 20, 0),
            child: Column(
              children: <Widget>[
                //     imgWidget("assets/images/mlogo.png", 200, 400),
                imgWidget("assets/images/EarnilyLogo.png", 150, 250),
                //SizedBox(height: 30),
                Text(
                  'تسجيل الدخول',
                ),
                reuasbleTextField(
                    "child name", Icons.child_care, false, _nameController),

                NewButton(
                    text: 'تسجيل',
                    width: MediaQuery.of(context).size.width,
                    height: 110,
                    onClick: () async {
                      if (_nameController.text.isEmpty) {
                      } else
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePageKid()));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

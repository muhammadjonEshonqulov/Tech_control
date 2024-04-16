import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tech_control/app/router.dart';

import '../data/database/cache.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  // Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Base64Codec base64 = const Base64Codec();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: Card(
            elevation: 2.0, // cardElevation
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Container(
              height: kToolbarHeight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Tech Control',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await cache.clear();
                        router.go(Routes.login);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(Icons.logout_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(flex: 4, child: _buildQrView(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(borderColor: Colors.red, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      var id = '';
      var resultText = '';
      var simpleQr = false;

      try {
        id = utf8.decode(base64.decode(scanData.code ?? "")).split("%")[1].split("?")[0];
        id = utf8.decode(base64.decode(id));
        resultText = utf8.decode(base64.decode(utf8.decode(base64.decode(scanData.code ?? "")).split("%")[0] ?? ""));
        simpleQr = false;
      } catch (e) {
        simpleQr = true;
        resultText = scanData.code ?? "";
      }

      if (simpleQr) {
        try {
          var split = resultText.split('http');
          resultText = split.first;
          id = split.last.split('see/').last;
        } catch (e) {}
      }
      setState(() {
        // result = scanData;
        controller.pauseCamera();
        showResultDialog(id, resultText);
      });
    });
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'logout_title'.tr(),
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                children: [
                  Text(
                    'logout_message'.tr(),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        controller?.resumeCamera();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'cancel'.tr(),
                          style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w500, fontSize: 14.0, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    InkWell(
                      onTap: () async {
                        await cache.clear();
                        context.setLocale(Locale('uz'));
                        Navigator.pop(context);
                        router.go(Routes.login);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'logout'.tr(),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: Colors.red, // Change color as needed
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void showResultDialog(String id, String resultText) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'QR-Scanner natijasi',
          style: TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
        ),
        content: Text(resultText, style: TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w400)),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const Text('Batafsil', style: TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w400, color: Color(0xFF00A65A))),
                onPressed: () {
                  Navigator.of(context).pop();
                  // controller?.resumeCamera();
                  router.go(Routes.additional, extra: {'id': id});
                },
              ),
              Card(
                color: Color(0xFF00A65A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    controller?.resumeCamera();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Yana scanner qilish', style: TextStyle(fontSize: 13, fontFamily: 'Montserrat', fontWeight: FontWeight.w400, color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

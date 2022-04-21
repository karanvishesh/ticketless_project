import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ticketless_project/model/monument.dart';
import 'package:ticketless_project/screens/bookingScreen/booking_screen.dart';
import 'package:ticketless_project/screens/bookingScreen/booking_screen_via_qr.dart';
import 'package:ticketless_project/screens/sharedWidgets/landingpage.dart';

class QrScanner extends StatefulWidget {
  QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => QrScannerState();
}

class QrScannerState extends State<QrScanner> {
  Barcode? result;
  QRViewController? controller;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

   fetch_monument(String id) async {
    var doc = FirebaseFirestore.instance.collection('monuments').doc(id);
    var document = await doc.get();
    if (!document.exists) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid QR Code')));
      Get.to(LandingPage());
    } else {
      doc.get().then((value) {
        print(
          value.data()!["price"],
        );
        print(
          value.data()!["name"],
        );
                ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Ticket Scanned Successfully")));
        Get.to(BookingScreenViaQr(
            monument: Monument(
                id: value.id,
                imageUrl: value.data()!["imgUrl"],
                price: value.data()!["price"],
                location: value.data()!["location"],
                stars: value.data()!["stars"],
                desc: value.data()!["desc"],
                name: value.data()!["name"],
                timeSlot: value.data()!["time"])));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: _buildQrView(context)));
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200
        : 300;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea.toDouble()),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        scanData.code != null ? controller.stopCamera() : null;
        if(result!.code.toString().length != 20){
               ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid QR Code')));
      Get.offAll(LandingPage());
        }
        else{

        fetch_monument(result!.code.toString());
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please grant camera permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

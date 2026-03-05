import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/utils/platform_utils.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:smarthealth_hcp/Features/ValidateVoucher/view/QRCodeScreen/border_paint.dart';

class QRCodeScanScreen extends StatefulWidget {
  static String route = "/QRCodeScanScreen";
  const QRCodeScanScreen({Key? key}) : super(key: key);

  @override
  QRCodeScanScreenState createState() => QRCodeScanScreenState();
}

class QRCodeScanScreenState extends State<QRCodeScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isScanned = false;

  @override
  void reassemble() {
    super.reassemble();
    if (PlatformUtils.isAndroid) {
      controller!.pauseCamera();
    } else if (PlatformUtils.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // foregroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              foregroundPainter: BorderPainter(),
              child: Container(
                padding: const EdgeInsets.all(0.0),
                height: MediaQuery.sizeOf(context).height * 0.35,
                width: MediaQuery.sizeOf(context).width * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                    onPermissionSet: (ctrl, p) =>
                        onPermissionSet(context, ctrl, p),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
          ],
        ),
      ),

      // SizedBox(
      //   child: QRView(
      //     key: qrKey,
      //     onQRViewCreated: _onQRViewCreated,
      //   ),
      // ),
      // QRCodeDartScanView(
      //   controller: controller,
      //   onCapture: _onQRViewCreated,
      // ),
    );
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    debugPrint('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('no Permission')));
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      debugPrint("SCANNED BARCODE NUMBER > ${scanData.code}");
      setState(() {
        result = scanData;
        debugPrint("RESULT -> ${result!.code}");
        if (result!.code!.isNotEmpty) {
          if (PlatformUtils.isAndroid) {
            controller.pauseCamera();
          } else if (PlatformUtils.isIOS) {
            controller.resumeCamera();
          }
          if (!isScanned) {
            isScanned = true;

            if (PlatformUtils.isAndroid) {
              controller.pauseCamera();
            } else if (PlatformUtils.isIOS) {
              controller.resumeCamera();
            }
            debugPrint("RETURN FROM IMAGES LIST");
            isScanned = false;
            Navigator.pop(context, result!.code);
          }
          return;
        }
      });
    });
  }

  // final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // Barcode? result;
  // QRViewController? controller;

  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (PlatformUtils.isAndroid) {
  //     controller!.pauseCamera();
  //   } else if (PlatformUtils.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.resumeCamera();
  //   controller.scannedDataStream.listen((scanData) {
  //     result = scanData;
  //     debugPrint("Scan data--> ${result?.code}");
  //     // Navigator.pop(context, scanData.code);
  //   });
  // }

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }

  // _onQRViewCreated(Result result) {
  //   log("QRCODE_RESULT--> $result");
  //   Navigator.pop(context, result);
  // }
}

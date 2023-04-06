import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QR with ChangeNotifier {
  Barcode? result;
  QRViewController? controller;
}

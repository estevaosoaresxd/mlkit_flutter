import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:ml_kit_project/pages/barcode_scanner/painter/barcode_scanner_painter.dart';

class BarcodeScannerController extends ChangeNotifier {
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  final List<String> scanneds = [];

  bool _canProcess = true;
  bool _isBusy = false;

  CameraLensDirection cameraLensDirection = CameraLensDirection.back;

  CustomPaint? customPaint;

  void onDispose() {
    _canProcess = false;
    _barcodeScanner.close();
  }

  void changeCamera(CameraLensDirection value) {
    cameraLensDirection = value;

    notifyListeners();
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;

    final barcodes = await _barcodeScanner.processImage(inputImage);

    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = BarcodeDetectorPainter(
        scanneds,
        barcodes,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        cameraLensDirection,
      );

      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }

    _isBusy = false;

    notifyListeners();
  }
}

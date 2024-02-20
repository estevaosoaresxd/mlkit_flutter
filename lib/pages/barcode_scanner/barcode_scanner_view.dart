import 'package:flutter/material.dart';
import 'package:ml_kit_project/pages/barcode_scanner/controller/barcode_scanner_controller.dart';
import 'package:ml_kit_project/pages/detector_view.dart';

class BarcodeScannerView extends StatefulWidget {
  const BarcodeScannerView({super.key});

  @override
  State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  final _controller = BarcodeScannerController();

  @override
  void dispose() {
    _controller.onDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (_, __) => DetectorView(
        title: 'Barcode Scanner',
        customPaint: _controller.customPaint,
        onImage: _controller.processImage,
        initialCameraLensDirection: _controller.cameraLensDirection,
        onCameraLensDirectionChanged: _controller.changeCamera,
      ),
    );
  }
}

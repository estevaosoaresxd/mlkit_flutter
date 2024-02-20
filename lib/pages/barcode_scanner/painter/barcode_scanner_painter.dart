import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:ml_kit_project/painters/camera_translator.dart';

class BarcodeDetectorPainter extends CustomPainter {
  BarcodeDetectorPainter(
    this.scanneds,
    this.barcodes,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  final List<String> scanneds;
  final List<Barcode> barcodes;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.white;

    // final Paint background = Paint()..color = const Color(0x99000000);

    for (final Barcode barcode in barcodes) {
      final haveColor = scanneds.contains(barcode.displayValue);
      paint.color = haveColor ? Colors.green : Colors.red;

      final left = translateX(
        barcode.boundingBox.left,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final top = translateY(
        barcode.boundingBox.top,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final right = translateX(
        barcode.boundingBox.right,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final bottom = translateY(
        barcode.boundingBox.bottom,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );

      canvas.drawRect(
        Rect.fromLTRB(left, top, right, bottom),
        paint,
      );

      if (barcode.displayValue != null) {
        scanneds.add(barcode.displayValue!);
      }

      // final ParagraphBuilder builder = ParagraphBuilder(
      //   ParagraphStyle(
      //     textAlign: TextAlign.center,
      //     fontSize: 12,
      //     textDirection: TextDirection.ltr,
      //   ),
      // );

      // builder.pushStyle(
      //   ui.TextStyle(
      //     color: haveColor ? Colors.lightGreenAccent : Colors.red,
      //     background: background,
      //   ),
      // );

      // builder.addText('${barcode.displayValue}');
      // builder.pop();

      // final List<Offset> cornerPoints = <Offset>[];

      // for (final point in barcode.cornerPoints) {
      //   final double x = translateX(
      //     point.x.toDouble(),
      //     size,
      //     imageSize,
      //     rotation,
      //     cameraLensDirection,
      //   );
      //   final double y = translateY(
      //     point.y.toDouble(),
      //     size,
      //     imageSize,
      //     rotation,
      //     cameraLensDirection,
      //   );

      //   cornerPoints.add(Offset(x, y));
      // }

      // cornerPoints.add(cornerPoints.first);

      // canvas.drawPoints(PointMode.lines, cornerPoints, paint);

      // canvas.drawParagraph(
      //   builder.build()
      //     ..layout(
      //       ParagraphConstraints(
      //         width: (right - left).abs(),
      //       ),
      //     ),
      //   Offset(
      //       Platform.isAndroid &&
      //               cameraLensDirection == CameraLensDirection.front
      //           ? right
      //           : left,
      //       top),
      // );
    }
  }

  @override
  bool shouldRepaint(BarcodeDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize ||
        oldDelegate.barcodes != barcodes;
  }
}

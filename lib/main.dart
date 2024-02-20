import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ml_kit_project/firebase_options.dart';
import 'package:ml_kit_project/pages/barcode_scanner/barcode_scanner_view.dart';
import 'package:ml_kit_project/pages/face_detection/face_detector_view.dart';
import 'package:ml_kit_project/pages/selfie_segmatation/self_segmenter_view.dart';
import 'package:ml_kit_project/pages/text_recognition/text_detector_view.dart';
import 'package:ml_kit_project/pages/translator/language_translator.dart';

import 'pages/object_detection/object_detection_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google ML Kit Demo App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: const SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ExpansionTile(
                    title: Text('Vision APIs'),
                    children: [
                      CustomCard('Barcode Scanning', BarcodeScannerView()),
                      CustomCard('Face Detection', FaceDetectorView()),
                      CustomCard('Text Recognition', TextRecognizerView()),
                      CustomCard('Object Detection', ObjectDetectorView()),
                      CustomCard('Selfie Segmentation', SelfieSegmenterView()),
                      CustomCard('Translator', LanguageTranslatorView()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String _label;
  final Widget _viewPage;
  final bool featureCompleted;

  const CustomCard(this._label, this._viewPage,
      {super.key, this.featureCompleted = true});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: Theme.of(context).primaryColor,
        title: Text(
          _label,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          if (!featureCompleted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('This feature has not been implemented yet')));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => _viewPage));
          }
        },
      ),
    );
  }
}

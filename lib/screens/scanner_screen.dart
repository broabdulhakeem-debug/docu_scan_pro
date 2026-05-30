import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  XFile? capturedImage;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    controller = CameraController(
      cameras!.first,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await controller!.initialize();
    setState(() {});
  }

  Future<void> takePicture() async {
    if (!controller!.value.isInitialized) return;

    final image = await controller!.takePicture();
    setState(() {
      capturedImage = image;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Document')),
      body: controller == null || !controller!.value.isInitialized
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: capturedImage == null
                      ? CameraPreview(controller!)
                      : Image.file(File(capturedImage!.path)),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: takePicture,
                        child: const Text('Capture'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            capturedImage = null;
                          });
                        },
                        child: const Text('Retake'),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
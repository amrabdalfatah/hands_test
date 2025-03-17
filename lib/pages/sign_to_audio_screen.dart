import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

import '../model/sign_to_audio_model.dart';

class SignToAudioScreen extends StatefulWidget {
  const SignToAudioScreen({super.key});

  @override
  State<SignToAudioScreen> createState() => _SignToAudioScreenState();
}

class _SignToAudioScreenState extends State<SignToAudioScreen> {
  CameraController? _cameraController;
  late Future<void> _initializeControllerFuture;
  final SignToAudioModel _model = SignToAudioModel();
  String _result = '';

  @override
  void initState() {
    super.initState();
    _initCamera();
    _model.loadModel();
  }

  // Initialize the camera
  Future<void> _initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      print("No cameras available");
      return;
    }

    _cameraController = CameraController(
      cameras[0], // Use the first available camera
      ResolutionPreset.medium,
      enableAudio: false,
    );

    _initializeControllerFuture = _cameraController!.initialize();

    _cameraController!.startImageStream((CameraImage image) {
      _runModelOnFrame(image);
    });
  }

  // Process the camera frame and run inference
  Future<void> _runModelOnFrame(CameraImage image) async {
    if (!_cameraController!.value.isStreamingImages) return;

    // Convert CameraImage to img.Image
    img.Image convertedImage = _convertCameraImage(image);

    // Run inference
    String result = _model.runInference(convertedImage);

    // Update the result in the UI
    setState(() {
      _result = result;
    });
  }

  // Convert CameraImage (YUV) to image.Image (RGB)
  img.Image _convertCameraImage(CameraImage image) {
    final int width = image.width;
    final int height = image.height;

    // Create an empty RGB image
    img.Image imgConverted = img.Image(width: width, height: height);

    // Get planes from YUV format
    final yPlane = image.planes[0].bytes;
    final uPlane = image.planes[1].bytes;
    final vPlane = image.planes[2].bytes;

    int uvIndex = 0;
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int yValue = yPlane[y * width + x] & 0xFF;
        final int uValue = uPlane[uvIndex] & 0xFF;
        final int vValue = vPlane[uvIndex] & 0xFF;

        // Convert YUV to RGB
        int r = (yValue + 1.402 * (vValue - 128)).toInt().clamp(0, 255);
        int g = (yValue - 0.344136 * (uValue - 128) - 0.714136 * (vValue - 128))
            .toInt()
            .clamp(0, 255);
        int b = (yValue + 1.772 * (uValue - 128)).toInt().clamp(0, 255);

        // Set pixel in image
        imgConverted.setPixelRgba(x, y, r, g, b, 255);

        if (x % 2 == 0) uvIndex++;
      }
    }

    return imgConverted;
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController!);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Text(
              _result,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

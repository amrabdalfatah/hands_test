import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;

import '../../model/sign_to_audio_model.dart';

class StudentViewModel extends GetxController {
  RxBool action = false.obs;
  // ValueNotifier<int> screenIndex = ValueNotifier(0);
  ValueNotifier<bool> loaded = ValueNotifier(true);
  CameraController? cameraController;
  Future<void>? initializeControllerFuture;
  final SignToAudioModel model = SignToAudioModel();
  ValueNotifier<String> result = ValueNotifier('');

  @override
  void onClose() {
    cameraController!.dispose();
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    await _initCamera();
    await model.loadModel();
    print('data loaded success start building screen');
  }

  // Initialize the camera
  Future<void> _initCamera() async {
    loaded.value = false;
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await cameraInitialize();
    loaded.value = true;
    update();
  }

  Future<void> cameraInitialize() async {
    initializeControllerFuture = cameraController!.initialize();
    cameraController!.startImageStream((CameraImage image) {
      _runModelOnFrame(image);
    });
  }

  // Process the camera frame and run inference
  Future<void> _runModelOnFrame(CameraImage image) async {
    if (!cameraController!.value.isStreamingImages) return;

    // Convert CameraImage to img.Image
    img.Image convertedImage = _convertCameraImage(image);

    // Run inference
    String finalResult = model.runInference(convertedImage);
    // result.value = finalResult;
    result.value = "amr";
    update();
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

  // void changeScreen(int selected) {
  //   screenIndex.value = selected;
  //   update();
  // }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    // final box = GetStorage();
    // box.remove('userid');
    // box.remove('usertype');
    // Get.offAll(() => Controller().mainScreen);
  }
}

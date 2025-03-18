import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/view_model/student_viewmodel.dart';

class SignToAudioScreen extends StatelessWidget {
  const SignToAudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentViewModel>(
      init: StudentViewModel(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              FutureBuilder<void>(
                future: controller.initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(controller.cameraController!);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              Positioned(
                top: 40,
                left: 20,
                right: 20,
                child: Text(
                  controller.result.value,
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
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  late final FirebaseAuth _auth;
  late RxBool shownPassword;
  late RxBool action;
  String email = '', password = '';

  @override
  void onInit() {
    super.onInit();
    _auth = FirebaseAuth.instance;
    shownPassword = true.obs;
    action = false.obs;
  }

  void changeShownPassword() {
    shownPassword.value = !shownPassword.value;
  }

  void signInWithEmailAndPassword() async {
    action.value = true;
    try {
      await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        // final box = GetStorage();
        // box.write('userid', value.user!.uid);
      });
    } catch (e) {
      action.value = false;
      Get.snackbar(
        'Error Login',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
      );
    }
  }
}

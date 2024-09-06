import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToastUtils{


  static success({required String title, Duration? duration}){
    return Get.rawSnackbar(
      message: title,
      isDismissible: false,
      duration: duration ?? const Duration(seconds: 3),
      backgroundColor: Colors.green.shade500,
      icon: const Icon(Icons.done, size: 35, color: Colors.white),
      margin: EdgeInsets.zero,
      snackStyle: SnackStyle.GROUNDED,
    );
  }

  static danger({required String title, Duration? duration}){
    return Get.rawSnackbar(
      message: title,
      isDismissible: false,
      duration: duration ?? const Duration(seconds: 3),
      backgroundColor: Colors.red.shade500,
      icon: const Icon(Icons.done, size: 35, color: Colors.white),
      margin: EdgeInsets.zero,
      snackStyle: SnackStyle.GROUNDED,
    );
  }


}
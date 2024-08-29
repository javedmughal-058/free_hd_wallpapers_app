import 'package:flutter/material.dart';
import 'package:free_hd_wallpapers/view/home_page.dart';
import 'package:get/get.dart';

class AppController extends GetxController{

  late TextEditingController userInput;



  @override
  void onInit() {
    super.onInit();
    userInput = TextEditingController();
    _navigateToHome();
  }

  @override
  void dispose() {
    userInput.dispose();
    super.dispose();
  }


  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Get.off(() => const HomePage());

  }



}
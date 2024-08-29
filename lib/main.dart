import 'package:flutter/material.dart';
import 'package:free_hd_wallpapers/view/splash_screen.dart';
import 'package:get/get.dart';

import 'controllers/bindings/app_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Free HD Wallpaper',
      theme: ThemeData(
        primaryColor: const Color(0xFF679897),
        secondaryHeaderColor: const Color(0xFFF17A21),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      initialBinding: AppBinding(),
    );
  }
}


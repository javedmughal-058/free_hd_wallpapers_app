import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController{


  Connectivity connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }


  void _updateConnectionStatus(ConnectivityResult connectivityResult){
    log("connection $connectivityResult");
    if(connectivityResult == ConnectivityResult.none){
      Get.rawSnackbar(
        message: 'PLEASE CONNECT TO THE INTERNET',
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: Colors.red.shade500,
        icon: const Icon(Icons.wifi_off, size: 35, color: Colors.white),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );
    }else{
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
    }
  }



}
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:free_hd_wallpapers/constant/utils/toast_utils.dart';
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
      ToastUtils.danger(title: 'PLEASE CONNECT TO THE INTERNET', duration: const Duration(days: 1));
    }else{
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
    }
  }



}
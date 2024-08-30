import 'package:free_hd_wallpapers/controllers/network_controller.dart';
import 'package:get/get.dart';

class NetworkDependencyInjection{
  static void init(){
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
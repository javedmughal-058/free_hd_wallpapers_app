import 'package:free_hd_wallpapers/controllers/app_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings{
  @override
  void dependencies() {
   Get.put(AppController());
  }


}
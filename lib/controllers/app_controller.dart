import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:free_hd_wallpapers/constant/helper.dart';
import 'package:free_hd_wallpapers/constant/utils/toast_utils.dart';
import 'package:free_hd_wallpapers/model/pexels_image_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:free_hd_wallpapers/view/home_page.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';

class AppController extends GetxController{

  late Rx<TextEditingController> userInput;
  RxBool isTextNotEmpty = false.obs;
  var recommendedList = ["Trending", "Nature", "Beauty", "Tree", "HD Wallpapers", "Road", "Forest",  "Flowers", "Travel", "River"].obs;

  RxList categoryList = [
    {'title' : 'Nature',          'active' : RxBool(false)},
    {'title' : 'Beauty',          'active' : RxBool(false)},
    {'title' : 'HD Wallpapers',   'active' : RxBool(false)},
    {'title' : 'Road',            'active' : RxBool(false)},
    {'title' : 'Forest',          'active' : RxBool(false)},
    {'title' : 'Flowers',         'active' : RxBool(false)},
    {'title' : 'Travel',          'active' : RxBool(false)},
    {'title' : 'River',           'active' : RxBool(false)},
  ].obs;

  var trendingImages = <ImageModel>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var page = 1.obs;
  final random = Random();
  var hoveredIndex = (-1).obs;

  var searchImages = <ImageModel>[].obs;
  var isLoadingSecond = false.obs;
  var searchPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    userInput = TextEditingController().obs;
    userInput.value.addListener(() {
      isTextNotEmpty.value = userInput.value.text.isNotEmpty;
    });
    _navigateToHome();
    page.value = random.nextInt(10) + 1;
    fetchTrendingImages();
  }

  @override
  void dispose() {
    userInput.value.dispose();
    super.dispose();
  }


  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Get.off(() => const HomePage());

  }

  Future<void> fetchTrendingImages() async{
    debugPrint('calling..... func');
    if (isLoading.value || !hasMore.value) return;
    isLoading.value = true;

    try{
      final response = await http.get(
        Uri.parse('https://api.pexels.com/v1/curated?page=${page.value}&per_page=10'),
        headers: {'Authorization': apiKey},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> imagesJson = data['photos'];
        if (imagesJson.isEmpty) {
          hasMore.value = false;
        } else {
          trendingImages.addAll(imagesJson.map((json) => ImageModel.fromJson(json)).toList());
          debugPrint("page $page");
          debugPrint("length ${trendingImages.length}");
          page.value++;
        }
      }
      else {
        throw Exception('Failed to load images');
      }
    }catch(e){
      debugPrint("fetchTrendingImages $e");
    }finally {
      isLoading.value = false;
    }
  }


  Future<void> downloadImage(context, {required String url}) async{

    // var imageId = await ImageDownloader.downloadImage(url);
    // if(imageId == null){
    //   return;
    // }

    var response = await http.get(Uri.parse(url));
    final result = await ImageGallerySaverPlus.saveImage(Uint8List.fromList(response.bodyBytes), quality: 100);
    debugPrint(result.toString());

    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Image Downloaded Successfully')));
    ToastUtils.success(title: 'IMAGE DOWNLOADED SUCCESSFULLY');

  }

  Future<void> setWallpaper(context, {required String url}) async{
    try{
      File cachedImage = await DefaultCacheManager().getSingleFile(url);  //image file
      int location = WallpaperManagerPlus.homeScreen;  //Choose screen type
      WallpaperManagerPlus().setWallpaper(cachedImage, location);
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Wallpaper Applied Successfully')));
      ToastUtils.success(title: 'WALLPAPER APPLIED SUCCESSFULLY');

    }catch(e){
      debugPrint("setWallpaper $e");
    }

  }



  void changeCategoryStatus(){
    for (var element in categoryList) {
      element["active"] = false;
    }
    var data = categoryList.firstWhereOrNull((element) => element["title"] == userInput.value.text);
    if (data != null) {
      data["active"] = true;  // Update the value of the RxBool
    }
    categoryList.refresh();
  }


  Future<void> searchWallpapers() async{
    debugPrint('calling..... search');
    if (isLoadingSecond.value || !hasMore.value) return;
    isLoadingSecond.value = true;

    try{
      final response = await http.get(
        Uri.parse('https://api.pexels.com/v1/search?query=${userInput.value.text}&per_page=10&page=$searchPage'),
        headers: {'Authorization': apiKey},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> imagesJson = data['photos'];
        if (imagesJson.isEmpty) {
          hasMore.value = false;
        } else {
          searchImages.addAll(imagesJson.map((json) => ImageModel.fromJson(json)).toList());
          debugPrint("search $searchPage");
          debugPrint("search ${searchImages.length}");
          searchPage++;
        }
      }
      else {
        throw Exception('Failed to load images');
      }
    }catch(e){
      debugPrint("searchWallpapers $e");
    }finally {
      isLoadingSecond.value = false;
    }
  }



}
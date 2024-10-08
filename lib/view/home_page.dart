import 'package:flutter/material.dart';
import 'package:free_hd_wallpapers/constant/helper.dart';
import 'package:free_hd_wallpapers/controllers/app_controller.dart';
import 'package:free_hd_wallpapers/view/search_page.dart';
import 'package:free_hd_wallpapers/view/widgets/custom_app_bar.dart';
import 'package:free_hd_wallpapers/view/widgets/custom_hover_image_widget.dart';
import 'package:free_hd_wallpapers/view/widgets/shimmer/shimmer_loading_utils.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.find();
    final size = MediaQuery.sizeOf(context);

    Future<void> refresh() async{
      appController.page.value = appController.random.nextInt(10) + 1;
      appController.trendingImages.clear();
      appController.fetchTrendingImages();
    }

    return Scaffold(
      appBar: buildAppBar(context, leading: false),
      body: Padding(
        padding: EdgeInsets.all(kPadding),
        child: Column(
          children: [
            Obx(()=> TextFormField(
              controller: appController.userInput.value,
              decoration: InputDecoration(
                focusColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.grey,
                hintText: "Search Wallpapers",
                prefixIcon: appController.isTextNotEmpty.value
                    ? IconButton(
                      onPressed: (){
                        if(appController.userInput.value.text.isNotEmpty){
                          appController.userInput.value.clear();
                        }
                      },
                      icon: appController.userInput.value.text.isNotEmpty
                          ? Icon(Icons.clear, color: Theme.of(context).secondaryHeaderColor)
                          : const SizedBox(),
                    )
                    : const SizedBox(),
                suffixIcon: IconButton(
                  onPressed: (){
                    if(appController.userInput.value.text.isNotEmpty){
                      appController.searchImages.clear();
                      appController.searchPage.value = 1;
                      appController.searchWallpapers();
                      Get.to(()=> const SearchPage(), transition: Transition.fadeIn);
                    }
                  },
                  icon: Icon(Icons.search, color: Theme.of(context).secondaryHeaderColor),
                ),
                hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),
              ),
            )),
            SizedBox(
              height: size.height * 0.08,
              child: Obx(()=> ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(appController.recommendedList.length, (index) {
                  return GestureDetector(
                    onTap: (){
                      appController.userInput.value.text = appController.recommendedList[index];
                      appController.changeCategoryStatus();
                      appController.searchWallpapers();
                      Get.to(()=> const SearchPage(), transition: Transition.fadeIn);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: kPadding / 2, horizontal: kPadding / 4),
                      padding: EdgeInsets.symmetric(vertical: kPadding / 4, horizontal: kPadding / 2),
                      decoration: BoxDecoration(
                        color: index == 0 ? Theme.of(context).primaryColor : null,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Theme.of(context).primaryColor),
                      ),
                      child: Text(appController.recommendedList[index], style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: index == 0 ? Colors.white : null
                      )),
                    ),
                  );
                }),
              )),
            ),
            Expanded(
              child: Obx(() {
                if (appController.isLoading.value && appController.trendingImages.isEmpty) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: size.height * 0.35,
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemCount: 8,
                      itemBuilder: (context, index){
                        return ShimmerLoadingUtils.imageWidgetLoading(context, size: size);
                      });
                }
                 return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !appController.isLoading.value) {
                      appController.fetchTrendingImages();
                    }
                    return false;
                  },
                  child: Stack(
                    children: [
                      RefreshIndicator(
                        onRefresh: refresh,
                        backgroundColor: Theme.of(context).primaryColor,
                        color: Colors.white,
                        child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: size.height * 0.35,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                            itemCount: appController.trendingImages.length + (appController.isLoading.value ? 1 : 0),
                            itemBuilder: (context, index){
                              if (index == appController.trendingImages.length) {
                                return const SizedBox.shrink(); // Placeholder, the indicator will be in the center
                              }
                                return CustomImageWidgetWithOverlay(path: appController.trendingImages[index].imageUrl!, isNetwork: true, index: index);
                            }),
                      ),
                      if (appController.isLoading.value)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CircularProgressIndicator(
                              backgroundColor: Theme.of(context).secondaryHeaderColor,
                              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor), strokeWidth: 4),
                        ),
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

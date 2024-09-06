import 'package:flutter/material.dart';
import 'package:free_hd_wallpapers/constant/helper.dart';
import 'package:free_hd_wallpapers/controllers/app_controller.dart';
import 'package:free_hd_wallpapers/view/widgets/custom_app_bar.dart';
import 'package:get/get.dart';

import 'widgets/custom_hover_image_widget.dart';
import 'widgets/shimmer/shimmer_loading_utils.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final AppController appController = Get.find();

    return Scaffold(
      appBar: buildAppBar(context),
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
                    appController.searchImages.clear();
                    appController.searchPage.value = 1;
                    appController.searchWallpapers();
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
                children: List.generate(appController.categoryList.length, (index) {
                  return GestureDetector(
                    onTap: (){
                      appController.userInput.value.text = appController.categoryList[index]["title"];
                      appController.changeCategoryStatus();
                      appController.searchImages.clear();
                      appController.searchPage.value = 1;
                      appController.searchWallpapers();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: kPadding / 2, horizontal: kPadding / 4),
                      padding: EdgeInsets.symmetric(vertical: kPadding / 4, horizontal: kPadding / 2),
                      decoration: BoxDecoration(
                        color: appController.categoryList[index]["active"] == true ? Theme.of(context).primaryColor : null,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Theme.of(context).primaryColor),
                      ),
                      child: Text(appController.categoryList[index]["title"], style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: appController.categoryList[index]["active"] == true ? Colors.white : null
                      )),
                    ),
                  );
                }),
              )),
            ),
            Expanded(
              child: Obx(() {
                if (appController.isLoadingSecond.value && appController.searchImages.isEmpty) {
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
                    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !appController.isLoadingSecond.value) {
                      appController.searchWallpapers();
                    }
                    return false;
                  },
                  child: Stack(
                    children: [
                      GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: size.height * 0.35,
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                          itemCount: appController.searchImages.length + (appController.isLoadingSecond.value ? 1 : 0),
                          itemBuilder: (context, index){
                            if (index == appController.searchImages.length) {
                              return const SizedBox.shrink(); // Placeholder, the indicator will be in the center
                            }
                            return CustomImageWidgetWithOverlay(path: appController.searchImages[index].imageUrl!, isNetwork: true, index: index);
                          }),
                      if (appController.isLoadingSecond.value)
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

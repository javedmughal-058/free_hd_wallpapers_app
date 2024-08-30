import 'package:flutter/material.dart';
import 'package:free_hd_wallpapers/constant/helper.dart';
import 'package:free_hd_wallpapers/controllers/app_controller.dart';
import 'package:free_hd_wallpapers/view/widgets/custom_hover_image_widget.dart';
import 'package:free_hd_wallpapers/view/widgets/custom_image_widget.dart';
import 'package:free_hd_wallpapers/view/widgets/shimmer/shimmer_loading_utils.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.find();
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'Free ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).primaryColor, fontSize: 20)),
              TextSpan(text: 'HD ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).secondaryHeaderColor, fontSize: 20)),
              TextSpan(text: 'Wallpapers ', style: Theme.of(context).textTheme.titleMedium),
            ]
          )),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(kPadding),
        child: Column(
          children: [
            TextFormField(
              controller: appController.userInput,
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
                suffixIcon: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.search, color: Theme.of(context).secondaryHeaderColor),
                ),
                hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),
              ),
            ),
            SizedBox(
              height: size.height * 0.08,
              child: Obx(()=> ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(appController.recommendedList.length, (index) {
                  return Container(
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
                      GridView.builder(
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

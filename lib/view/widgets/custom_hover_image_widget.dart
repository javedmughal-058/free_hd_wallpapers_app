import 'package:flutter/material.dart';
import 'package:free_hd_wallpapers/controllers/app_controller.dart';
import 'package:free_hd_wallpapers/view/attachment_view.dart';
import 'package:get/get.dart';

import 'custom_image_widget.dart';

class CustomImageWidgetWithOverlay extends StatefulWidget {
  final String path;
  final bool isNetwork;
  final int index;
  const CustomImageWidgetWithOverlay({Key? key, required this.path, required this.isNetwork, required this.index,}) : super(key: key);

  @override
  State<CustomImageWidgetWithOverlay> createState() => _CustomImageWidgetWithOverlayState();
}

class _CustomImageWidgetWithOverlayState extends State<CustomImageWidgetWithOverlay> {
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        appController.hoveredIndex.value = widget.index;
      },
      child: Obx(()=> Stack(
        children: [
          CustomImageWidget(
            path: widget.path,
            isNetwork: widget.isNetwork,
          ),
          if (appController.hoveredIndex.value == widget.index)
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.black.withOpacity(0.5), // Semi-transparent black overlay
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Set Wallpaper',
                      icon: const Icon(Icons.wallpaper, color: Colors.white),
                      onPressed: () {
                        // Handle favorite button press
                        appController.setWallpaper(context, url: widget.path);
                      },
                    ),
                    const SizedBox(height: 10),
                    IconButton(
                      tooltip: 'Download Wallpaper',
                      icon: const Icon(Icons.download, color: Colors.white),
                      onPressed: () {
                        appController.downloadImage(context, url: widget.path);
                      },
                    ),
                    IconButton(
                      tooltip: 'View Wallpaper',
                      icon: const Icon(Icons.remove_red_eye, color: Colors.white),
                      onPressed: () {
                        Get.to(()=> AttachmentView(isNetwork: true, imagePath: widget.path));
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      )),
    );
  }
}

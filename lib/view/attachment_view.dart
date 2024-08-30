import 'package:flutter/material.dart';
import 'package:free_hd_wallpapers/controllers/app_controller.dart';
import 'package:get/get.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/custom_image_widget.dart';

class AttachmentView extends StatelessWidget {
  final String imagePath;
  final bool isNetwork;
  final bool isLocal;

  const AttachmentView({Key? key, required this.imagePath, this.isNetwork = false, this.isLocal = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final AppController appController = Get.find();

    return Scaffold(
      appBar: buildAppBar(context,title: "Image Viewer"),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          InteractiveViewer(
              child: CustomImageWidget(
                path: imagePath,
                radius: 0,
                height: size.height,
                isLocal: isLocal,
                isNetwork: isNetwork,
                boxFit: BoxFit.cover)
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: (){
                    appController.setWallpaper(context, url: imagePath);
                  },
                  icon: Icon(Icons.wallpaper, size: 20, color: Theme.of(context).secondaryHeaderColor),
                  label: Text('Applied', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).secondaryHeaderColor))),
                ElevatedButton.icon(
                    onPressed: (){
                      appController.downloadImage(context, url: imagePath);
                    },
                    icon: Icon(Icons.download, size: 20, color: Theme.of(context).primaryColor),
                    label: Text('Download', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor))),
              ],
            ),
          )
        ],
      ),
    );
  }
}

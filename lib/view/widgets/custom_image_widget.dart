import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:free_hd_wallpapers/constant/utils/image_utils.dart';

class CustomImageWidget extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final double? radius;
  final Color? color;
  final BoxFit? boxFit;
  final double? padding;
  final bool isNetwork;
  final bool isLocal;
  final void Function()? onTap;

  const CustomImageWidget({super.key,
    required this.path, this.height, this.width, this.radius,
    this.color, this.boxFit, this.padding, this.onTap,
    this.isNetwork = false, this.isLocal = false});

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (isNetwork) {
      imageWidget = CachedNetworkImage(
        imageUrl: path,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: boxFit ?? BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => Image.asset(ImageUtils.loadingImage, fit: boxFit ?? BoxFit.cover),
        errorWidget: (context, url, error) => Image.asset(ImageUtils.noImage, fit: boxFit ?? BoxFit.cover),
      );
    }
    else if (isLocal) {
      imageWidget = Image.file(File(path), fit: boxFit ?? BoxFit.cover);
    } else {
      imageWidget = Image.asset(path, fit: boxFit ?? BoxFit.cover);
    }

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 8.0),
        child: Container(
          height: height,
          width: width,
          color: color,
          child: imageWidget,
        ),
      ),
    );
  }
}

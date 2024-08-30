import 'package:flutter/material.dart';
import 'package:free_hd_wallpapers/constant/helper.dart';
import 'package:shimmer/shimmer.dart';
import 'shimmer_effect.dart';

class ShimmerLoadingUtils{

  static Widget imageWidgetLoading(context, {required Size size}) => ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).dividerColor,
        highlightColor: Theme.of(context).dividerColor.withOpacity(0.2),
        child: ShimmerLoadingEffect(height: size.height * 0.35),
      ));

  static Widget singleItemLoading(context, {required Size size, double? height, double? width}){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kPadding / 8, horizontal: kPadding / 4),
      child: Shimmer.fromColors(
        baseColor:  Theme.of(context).dividerColor,
        highlightColor:  Theme.of(context).dividerColor.withOpacity(0.2),
        child: ShimmerLoadingEffect(height: height ?? size.width * 0.125, width: width ?? size.width * 0.125),
      ),
    );
  }
  static Widget itemCardLoading(context, {required Size size, double? height, double? width}){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kPadding / 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor:  Theme.of(context).dividerColor,
            highlightColor:  Theme.of(context).dividerColor.withOpacity(0.2),
            child: ShimmerLoadingEffect(height: height ?? size.height * 0.025, width: width ?? size.width * 0.25),
          ),
          Shimmer.fromColors(
            baseColor:  Theme.of(context).dividerColor,
            highlightColor:  Theme.of(context).dividerColor.withOpacity(0.2),
            child: ShimmerLoadingEffect(height: height ?? size.height * 0.025, width: width ?? size.width * 0.25),
          ),
        ],
      ),
    );
  }
}
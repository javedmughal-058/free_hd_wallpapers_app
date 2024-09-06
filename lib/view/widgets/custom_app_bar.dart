import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar buildAppBar(BuildContext context, {String? title, List<Widget>? actions, Color? bgColor, Color? iconColor, bool leading = true}) {

  return AppBar(
    backgroundColor: bgColor,
    leading: leading
        ? GestureDetector(
          onTap: ()=> Get.back(),
          child: Icon(Icons.arrow_back_ios, size: 24, color: iconColor ?? Theme.of(context).primaryColor),
        )
        : const SizedBox(),
    title: title == null
        ? RichText(
        text: TextSpan(
            children: [
              TextSpan(text: 'Free ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).primaryColor, fontSize: 20)),
              TextSpan(text: 'HD ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).secondaryHeaderColor, fontSize: 20)),
              TextSpan(text: 'Wallpapers ', style: Theme.of(context).textTheme.titleMedium),
            ]
        ))
        : Text(title, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).primaryColor)),
    centerTitle: true,
    actions: actions ?? [],
  );
}
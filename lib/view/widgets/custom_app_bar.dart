import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar buildAppBar(BuildContext context, {required String title, List<Widget>? actions, Color? bgColor, Color? iconColor}) {

  return AppBar(
    backgroundColor: bgColor,
    leading: GestureDetector(
      onTap: ()=> Get.back(),
      child: Icon(Icons.arrow_back_ios, size: 24, color: iconColor ?? Theme.of(context).primaryColor),
    ),
    title: Text(title, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: iconColor ?? Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
    actions: actions ?? [],
  );
}
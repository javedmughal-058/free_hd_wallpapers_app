import 'package:flutter/material.dart';
import 'package:free_hd_wallpapers/constant/helper.dart';
import 'package:free_hd_wallpapers/controllers/app_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.find();
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
      body: SingleChildScrollView(
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
          ],
        ),
      ),
    );
  }
}

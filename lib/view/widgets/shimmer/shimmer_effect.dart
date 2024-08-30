import 'package:flutter/material.dart';

class ShimmerLoadingEffect extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  const ShimmerLoadingEffect({Key? key, this.height, this.width, this.radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Container(
      alignment: Alignment.center,
      height: height ?? size.height * 0.15,
      width: width ?? size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 2),
          color: Theme.of(context).dividerColor.withOpacity(0.3)
      ),
    );
  }
}
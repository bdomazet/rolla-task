import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/svg_assets.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({this.imagePath, super.key});
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/userinfopage');
      },
      child: imagePath == null
          ? Image.asset(
              imagePlaceholder,
              width: 50.w,
              height: 50.h,
              fit: BoxFit.contain,
            )
          : Image.network(
              imagePath!,
              width: 50.w,
              height: 50.h,
              fit: BoxFit.contain,
            ),
    );
  }
}

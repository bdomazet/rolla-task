import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey.shade500,
        strokeWidth: 3.w,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}

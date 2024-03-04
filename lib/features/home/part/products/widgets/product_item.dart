import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/models/products.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    required this.item,
    super.key,
  });

  final Products item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            '${item.id}',
            style: TextStyle(
              color: Colors.grey[900],
            ),
          ),
          Text(
            '${item.title}',
            style: TextStyle(
              color: Colors.grey[800],
            ),
          ),
          Text(
            '${item.brand}',
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

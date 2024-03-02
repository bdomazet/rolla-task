import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatelessWidget {
  const NavBar(
      {required this.onPressedProductsTab,
      required this.onPressedLogTab,
      super.key});

  final Function? onPressedProductsTab;
  final Function? onPressedLogTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade700,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
        child: GNav(
          backgroundColor: Colors.grey.shade700,
          color: Colors.grey.shade300,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey,
          gap: 8,
          padding: const EdgeInsets.all(16),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          tabs: <GButton>[
            GButton(
              icon: Icons.shop,
              text: 'Products',
              onPressed: onPressedProductsTab,
            ),
            GButton(
              icon: Icons.list,
              text: 'Log',
              onPressed: onPressedLogTab,
            ),
          ],
        ),
      ),
    );
  }
}

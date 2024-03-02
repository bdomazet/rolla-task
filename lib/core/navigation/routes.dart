import 'package:flutter/material.dart';

import '../../features/auth/presentation/login_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/user_info/presentation/user_info_page.dart';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/loginpage': (BuildContext context) => const LoginPage(),
  '/homepage': (BuildContext context) => const HomePage(),
  '/userinfopage': (BuildContext context) => const UserInfoPage()
};

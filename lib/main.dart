import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/navigation/routes.dart';
import 'features/auth/bloc/login_page_bloc.dart';
import 'features/auth/presentation/login_page.dart';
import 'injection_container.dart';

void main() {
  configureDependencies();
  runApp(const RollaTask());
}

class RollaTask extends StatelessWidget {
  const RollaTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<LoginPageBloc>(
          create: (BuildContext context) => LoginPageBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 640),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const LoginPage(),
          routes: routes,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theme/svg_assets.dart';
import '../../../core/widgets/my_button.dart';
import '../../../core/widgets/my_snack_bar.dart';
import '../../../core/widgets/my_text_field.dart';
import '../bloc/login_page_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameController.text = 'kminchelle';
    passwordController.text = '0lelplR';
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: BlocConsumer<LoginPageBloc, LoginPageState>(
            listener: (BuildContext context, LoginPageState state) {
              if (state is LogInSuccessfulState) {
                Navigator.pushNamed(context, '/homepage');
              }
              if (state is LogInUnsuccessfulState) {
                displaySnackBar(context, message: 'Something went wrong');
              }
            },
            builder: (BuildContext context, LoginPageState state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      rollaLogo,
                      width: 255.w,
                    ),
                    SizedBox(height: 40.h),
                    MyTextField(
                      controller: usernameController,
                      hintText: 'Username',
                    ),
                    SizedBox(height: 20.h),
                    MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true),
                    SizedBox(height: 20.h),
                    MyButton(
                      buttonText: 'Sign in',
                      onTap: () {
                        BlocProvider.of<LoginPageBloc>(context)
                            .add(LogMeInEvent(
                          username: usernameController.text,
                          password: passwordController.text,
                          expiresInMins: '10',
                        ));
                        // Navigator.pushNamed(context, '/homepage');
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

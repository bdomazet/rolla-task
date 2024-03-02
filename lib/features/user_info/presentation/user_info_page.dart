import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/services/network_service.dart';
import '../../../core/widgets/image_placeholder.dart';
import '../../../core/widgets/my_button.dart';
import '../../../injection_container.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info Page'),
        elevation: 0,
        backgroundColor: Colors.grey[100],
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20.h),
                      // display user avatar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ImagePlaceholder(
                            imagePath:
                                getIt<NetworkService>().currentUser?.image,
                          ),
                        ],
                      ),
                      SizedBox(height: 50.h),
                      // display first and last name
                      Text(
                          '${getIt<NetworkService>().currentUser?.firstName} ${getIt<NetworkService>().currentUser?.lastName}'),

                      // age
                      Text(getIt<NetworkService>().currentUser?.gender ?? ''),

                      // email address
                      Text(getIt<NetworkService>().currentUser?.email ?? ''),

                      // at a bottom, Sign Out button
                    ],
                  ),
                ),
              ),
              MyButton(
                  buttonText: 'SignOut',
                  onTap: () {
                    Navigator.pushNamed(context, '/loginpage');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

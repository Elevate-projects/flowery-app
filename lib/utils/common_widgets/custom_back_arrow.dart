import 'package:flowery_app/presentation/auth/login/views/login_view.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackArrow extends StatelessWidget {
  const CustomBackArrow({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final isLoggedIn = FloweryMethodHelper.currentUserToken != null;
        if (isLoggedIn) {
          Navigator.pop(context);
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
                (route) => false,
          );
        }
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
        size: 26.r,
      ),
    );
  }
}

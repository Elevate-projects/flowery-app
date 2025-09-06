import 'package:flowery_app/core/constants/app_images.dart';
import 'package:flowery_app/presentation/edit_profile/views/widget/edit_profile_app_bar.dart';
import 'package:flowery_app/presentation/edit_profile/views/widget/edit_profile_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: RPadding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            EditProfileAppBar(),
            RSizedBox(height: 27),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    EditProfileDetails()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


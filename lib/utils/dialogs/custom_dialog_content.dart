import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialogContent extends StatelessWidget {
  const CustomDialogContent({super.key, this.actions, this.content});
  final List<Widget>? actions;
  final Widget? content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: REdgeInsets.symmetric(vertical: 40, horizontal: 22),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10.r),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      content: content,
      actions: actions,
    );
  }
}

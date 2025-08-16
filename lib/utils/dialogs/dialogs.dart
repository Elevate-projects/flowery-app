import 'package:flowery_app/utils/dialogs/custom_dialog_content.dart';
import 'package:flutter/material.dart';

abstract class Dialogs {
  static customDialog({
    required BuildContext context,
    List<Widget>? actions,
    Widget? content,
  }) {
    return showDialog(
      context: context,
      builder: (context) =>
          CustomDialogContent(content: content, actions: actions),
    );
  }
}

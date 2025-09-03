import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsAddToCartButton extends StatelessWidget {
  const ProductDetailsAddToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomElevatedButton(
        onPressed: () {},
        buttonTitle: AppText.addToCart,
      ),
    );
  }
}

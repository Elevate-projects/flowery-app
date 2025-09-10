import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/domain/entities/requests/add_to_cart_request/add_to_cart_request_entity.dart';
import 'package:flowery_app/utils/common_cubits/add_product_to_cart/add_product_to_cart_cubit.dart';
import 'package:flowery_app/utils/common_cubits/add_product_to_cart/add_product_to_cart_intent.dart';
import 'package:flowery_app/utils/common_cubits/add_product_to_cart/add_product_to_cart_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_app/utils/common_widgets/loading_button.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final addToCartCubit = BlocProvider.of<AddProductToCartCubit>(context);
    return BlocConsumer<AddProductToCartCubit, AddProductToCartState>(
      listener: (context, state) {
        if (state.addToCartStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.addToCartStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.addToCartStatus.isSuccess &&
            state.currentProductId == productId) {
          Loaders.showSuccessMessage(
            message: AppText.addProductToCartSuccessMessage.tr(),
            context: context,
          );
        }
      },
      builder: (context, state) =>
          (state.addToCartStatus.isLoading &&
              state.currentProductId == productId)
          ? LoadingButton(height: 30.h)
          : CustomElevatedButton(
              onPressed: () async {
                addToCartCubit.doIntent(
                  intent: ChangeSelectedProductId(productId: productId),
                );
                await addToCartCubit.doIntent(
                  intent: AddToCartIntent(
                    request: AddToCartRequestEntity(productId: productId),
                  ),
                );
              },
              buttonTitle: AppText.addToCart,
              height: 30.h,
              isText: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.cart, fit: BoxFit.scaleDown),
                  const RSizedBox(width: 8),
                  Text(
                    AppText.addToCart.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

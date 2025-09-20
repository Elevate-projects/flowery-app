import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/checkout/views/widgets/custom_add_address.dart';
import 'package:flowery_app/presentation/checkout/views_model/address_cubit/address_cubit.dart';
import 'package:flowery_app/presentation/checkout/views_model/address_cubit/address_state.dart';
import 'package:flowery_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDeliveryAddress extends StatelessWidget {
  const CustomDeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            AppText.deliveryAddress.tr(),
            style: theme.textTheme.headlineSmall,
          ),
        ),
        BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            if (state is FetchAddressSuccessState ||
                FloweryMethodHelper.userData != null) {
              return Visibility(
                visible:
                    (FloweryMethodHelper.userData?.addresses?.isNotEmpty ??
                    false),
                child: ListView.builder(
                  itemCount: FloweryMethodHelper.userData!.addresses!.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CustomAddAddress(
                      index: index,
                      address: FloweryMethodHelper.userData!.addresses![index],
                      isSelected:
                          context.read<AddressCubit>().selectedIndex == index,
                      onSelect: () =>
                          context.read<AddressCubit>().selectAddress(index),
                    );
                  },
                ),
              );
            } else {
              return RPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ShimmerEffect(
                  height: 120.h,
                  width: ScreenUtil().screenWidth,
                  radius: 8.r,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

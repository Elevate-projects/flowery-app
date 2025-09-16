import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/checkout_page/view_model/adress_cubit/adress_cubit.dart';
import 'package:flowery_app/utils/common_widgets/custom_add_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CustomDeliveryAddress extends StatelessWidget {
  const CustomDeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10), // أو REdgeInsets
          child: Text(
            AppText.deliveryAddress.tr(),
            style: theme.textTheme.headlineSmall,
          ),
        ),
        BlocBuilder<AddressCubit, int?>(
          builder: (context, selectedIndex) {
            return ListView.builder(
              itemCount: 2,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return CustomAddAddress(
                  index: index,
                  isSelected: selectedIndex == index,
                  onSelect: () => context.read<AddressCubit>().selectAddress(index),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

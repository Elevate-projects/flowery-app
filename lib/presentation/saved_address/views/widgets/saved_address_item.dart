import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';
import 'package:flowery_app/presentation/saved_address/views/widgets/remove_address_content.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_cubit.dart';
import 'package:flowery_app/utils/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SavedAddressItem extends StatelessWidget {
  const SavedAddressItem({super.key, required this.addressData});
  final AddressEntity addressData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final savedAddressCubit = BlocProvider.of<SavedAddressCubit>(context);
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.25),
            blurRadius: 4.r,
            blurStyle: BlurStyle.outer,
          ),
        ],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(AppIcons.location2, fit: BoxFit.contain),
              const RSizedBox(width: 4),
              Expanded(
                child: Text(
                  addressData.city ?? "",
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await Dialogs.customDialog(
                    isBarrierDismissible: false,
                    context: context,
                    content: BlocProvider.value(
                      value: savedAddressCubit,
                      child: RemoveAddressContent(
                        addressId: addressData.id ?? "",
                      ),
                    ),
                  );
                },
                child: SvgPicture.asset(AppIcons.delete, fit: BoxFit.contain),
              ),
              const RSizedBox(width: 4),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(AppIcons.edit2, fit: BoxFit.contain),
              ),
            ],
          ),
          const RSizedBox(height: 16),
          Text(
            addressData.street ?? "",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.shadow,
            ),
          ),
        ],
      ),
    );
  }
}

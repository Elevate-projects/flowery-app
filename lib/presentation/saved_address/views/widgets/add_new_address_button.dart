import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/domain/entities/arguments/address_argument_entity.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_cubit.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewAddressButton extends StatelessWidget {
  const AddNewAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    final savedAddressCubit = BlocProvider.of<SavedAddressCubit>(context);
    return SliverToBoxAdapter(
      child: RPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              RouteNames.addressDetails,
              arguments: AddressArgumentEntity(
                isAddedFromCheckout: false,
                savedAddressCubit: savedAddressCubit,
              ),
            );
          },
          buttonTitle: AppText.addNewAddress.tr(),
          height: 50.h,
        ),
      ),
    );
  }
}

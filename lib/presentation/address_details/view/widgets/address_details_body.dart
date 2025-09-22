import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/arguments/address_argument_entity.dart';
import 'package:flowery_app/presentation/address_details/view/widgets/address_details_form.dart';
import 'package:flowery_app/presentation/address_details/view/widgets/map_section.dart';
import 'package:flowery_app/presentation/address_details/view_model/add_address_cubit.dart';
import 'package:flowery_app/presentation/address_details/view_model/add_address_state.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_intent.dart';
import 'package:flowery_app/utils/common_widgets/loading_dialog.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressDetailsBody extends StatelessWidget {
  const AddressDetailsBody({super.key, required this.addressArgumentEntity});
  final AddressArgumentEntity addressArgumentEntity;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddAddressCubit, AddAddressState>(
      listener: (context, state) {
        switch (state.addAddressStatus.status) {
          case Status.initial:
            break;
          case Status.loading:
            showLoadingDialog(
              context,
              color: Theme.of(context).colorScheme.primary,
            );
            break;
          case Status.success:
            if (addressArgumentEntity.isAddedFromCheckout) {
              addressArgumentEntity.addressCubit!.updateAddress();
            } else {
              addressArgumentEntity.savedAddressCubit!.doIntent(
                intent: AddNewAddressIntent(),
              );
              Navigator.pop(context);
            }
            Navigator.pop(context);
            Navigator.pop(context);
            Loaders.showSuccessMessage(
              message: AppText.addressSavedSuccessfully.tr(),
              context: context,
            );
            break;
          case Status.failure:
            Navigator.pop(context);
            Loaders.showErrorMessage(
              message: state.addAddressStatus.error?.message ?? AppText.error,
              context: context,
            );
            break;
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.all(16),
          child: const Column(
            children: [
              MapSection(),
              RSizedBox(height: 25),
              AddressDetailsForm(),
            ],
          ),
        ),
      ),
    );
  }
}

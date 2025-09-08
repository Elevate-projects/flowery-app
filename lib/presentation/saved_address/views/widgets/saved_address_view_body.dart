import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/saved_address/views/widgets/add_new_address_button.dart';
import 'package:flowery_app/presentation/saved_address/views/widgets/addresses_sliver_list.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_cubit.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_state.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedAddressViewBody extends StatelessWidget {
  const SavedAddressViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SavedAddressCubit, SavedAddressState>(
      listener: (context, state) {
        if (state.removeAddressStatus.isFailure) {
          Navigator.of(context).pop();
          Loaders.showErrorMessage(
            message: state.removeAddressStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.removeAddressStatus.isSuccess) {
          Navigator.of(context).pop();
          Loaders.showSuccessMessage(
            message: AppText.deleteAddressSuccessMessage.tr(),
            context: context,
          );
        }
      },
      child: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: RSizedBox(height: 24)),
          AddressesSliverList(),
          SliverToBoxAdapter(child: RSizedBox(height: 48)),
          AddNewAddressButton(),
        ],
      ),
    );
  }
}

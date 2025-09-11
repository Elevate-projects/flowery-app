import 'package:flowery_app/core/constants/app_animations.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/saved_address/views/widgets/saved_address_item.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_cubit.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_state.dart';
import 'package:flowery_app/utils/loaders/animation_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressesSliverList extends StatelessWidget {
  const AddressesSliverList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedAddressCubit, SavedAddressState>(
      builder: (context, state) => state.addresses.isEmpty
          ? const SliverToBoxAdapter(
              child: RPadding(
                padding: EdgeInsets.only(top: 62),
                child: AnimationLoaderWidget(
                  text: AppText.emptyAddressesMessage,
                  animation: AppAnimations.emptyFile,
                ),
              ),
            )
          : SliverPadding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList.separated(
                itemBuilder: (_, index) =>
                    SavedAddressItem(addressData: state.addresses[index]),
                separatorBuilder: (_, __) => const RSizedBox(height: 16),
                itemCount: state.addresses.length,
              ),
            ),
    );
  }
}

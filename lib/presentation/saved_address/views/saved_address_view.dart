import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';
import 'package:flowery_app/presentation/saved_address/views/widgets/saved_address_app_bar.dart';
import 'package:flowery_app/presentation/saved_address/views/widgets/saved_address_view_body.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_cubit.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedAddressView extends StatelessWidget {
  const SavedAddressView({super.key, required this.addresses});
  final List<AddressEntity> addresses;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SavedAddressCubit>(
      create: (context) => getIt.get<SavedAddressCubit>()
        ..doIntent(
          intent: SavedAddressInitializationIntent(addresses: addresses),
        ),
      child: const Scaffold(
        appBar: SavedAddressAppBar(),
        body: SavedAddressViewBody(),
      ),
    );
  }
}

import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/domain/entities/arguments/address_argument_entity.dart';
import 'package:flowery_app/presentation/address_details/view/widgets/address_details_app_bar.dart';
import 'package:flowery_app/presentation/address_details/view/widgets/address_details_body.dart';
import 'package:flowery_app/presentation/address_details/view_model/add_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({super.key, required this.addressArgumentEntity});
  final AddressArgumentEntity addressArgumentEntity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddAddressCubit>(
      create: (context) => getIt.get<AddAddressCubit>(),
      child: Scaffold(
        appBar: const AddressDetailsAppBar(),
        body: AddressDetailsBody(addressArgumentEntity: addressArgumentEntity),
      ),
    );
  }
}

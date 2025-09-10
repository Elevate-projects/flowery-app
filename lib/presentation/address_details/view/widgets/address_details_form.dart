import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/address/add_address_request_entity.dart';
import 'package:flowery_app/presentation/address_details/view_model/add_address_cubit.dart';
import 'package:flowery_app/presentation/address_details/view_model/add_address_intent.dart';
import 'package:flowery_app/presentation/address_details/view_model/add_address_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressDetailsForm extends StatefulWidget {
  const AddressDetailsForm({super.key});

  @override
  State<AddressDetailsForm> createState() => _AddressDetailsFormState();
}

class _AddressDetailsFormState extends State<AddressDetailsForm> {
  late GlobalKey<FormState> formKey;
  late TextEditingController phoneNumberController;
  late TextEditingController addressController;
  late TextEditingController recipientNameController;
  late SingleValueDropDownController cityDropDownController;
  late SingleValueDropDownController areaDropDownController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    phoneNumberController = TextEditingController();
    addressController = TextEditingController();
    recipientNameController = TextEditingController();
    cityDropDownController = SingleValueDropDownController();
    areaDropDownController = SingleValueDropDownController();
    context.read<AddAddressCubit>().doIntent(LoadCitiesAndAreasIntent());
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    addressController.dispose();
    recipientNameController.dispose();
    cityDropDownController.dispose();
    areaDropDownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAddressCubit, AddAddressState>(
      builder: (context, state) {
        switch (state.loadCitiesAndAreasStatus.status) {
          case Status.initial:
            return const SizedBox.shrink();
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
          case Status.success:
            return Form(
              key: formKey,
              autovalidateMode: state.autoValidateMode,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: addressController,
                    label: AppText.addressWord,
                    hintText: AppText.addressHint,
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) => Validations.validateEmptyText(value),
                  ),
                  const RSizedBox(height: 25),
                  CustomTextFormField(
                    controller: phoneNumberController,
                    label: AppText.phoneNumber,
                    hintText: AppText.phoneNumberHint,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                        Validations.phoneValidation(phoneNumber: value),
                  ),
                  const RSizedBox(height: 25),
                  CustomTextFormField(
                    controller: recipientNameController,
                    label: AppText.recipientName,
                    hintText: AppText.recipientNameHint,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) => Validations.validateEmptyText(value),
                  ),
                  const RSizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: DropDownTextField(
                          controller: cityDropDownController,
                          textStyle: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary,
                              ),
                          textFieldDecoration: InputDecoration(
                            labelStyle: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSecondary,
                                ),
                            labelText: AppText.city,
                            hintText: state.cities.isNotEmpty
                                ? state.cities.first
                                : AppText.city,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: const OutlineInputBorder(),
                          ),
                          listTextStyle: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary,
                              ),
                          dropDownItemCount: 5,
                          dropDownList: state.cities
                              .map(
                                (city) =>
                                    DropDownValueModel(name: city, value: city),
                              )
                              .toList(),
                          validator: (value) =>
                              Validations.validateEmptyText(value),
                          onChanged: (val) {
                            if (val is DropDownValueModel) {
                              context.read<AddAddressCubit>().doIntent(
                                SelectCityIntent(val.value),
                              );
                            }
                          },
                        ),
                      ),
                      const RSizedBox(width: 17),
                      Expanded(
                        child: DropDownTextField(
                          controller: areaDropDownController,
                          textStyle: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary,
                              ),
                          textFieldDecoration: InputDecoration(
                            labelStyle: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSecondary,
                                ),
                            labelText: AppText.area,
                            hintText: state.areas.isNotEmpty
                                ? state.areas.first
                                : AppText.area,
                            border: const OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          dropDownList: state.areas
                              .map(
                                (area) =>
                                    DropDownValueModel(name: area, value: area),
                              )
                              .toList(),
                          listTextStyle: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary,
                              ),
                          dropDownItemCount: 5,
                          validator: (value) =>
                              Validations.validateEmptyText(value),
                          onChanged: (val) {
                            if (val is DropDownValueModel) {
                              context.read<AddAddressCubit>().doIntent(
                                SelectAreaIntent(val.value),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const RSizedBox(height: 25),
                  CustomElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final cubit = context.read<AddAddressCubit>();
                        final state = cubit.state;
                        cubit.doIntent(
                          OnAddAddressInitializationIntent(
                            AddAddressRequestEntity(
                              phone: phoneNumberController.text,
                              city: state.selectedCity ?? '',
                              lat: state.selectedLocation.latitude.toString(),
                              long: state.selectedLocation.longitude.toString(),
                              street: addressController.text,
                              username: recipientNameController.text,
                            ),
                          ),
                        );
                        cubit.doIntent(DisableAutoValidateIntent());
                      } else {
                        context.read<AddAddressCubit>().doIntent(
                          EnableAutoValidateIntent(),
                        );
                      }
                    },
                    buttonTitle: AppText.saveAddress,
                  ),
                ],
              ),
            );
          case Status.failure:
            return Center(
              child: Text(
                state.loadCitiesAndAreasStatus.error?.message ?? AppText.error,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            );
        }
      },
    );
  }
}

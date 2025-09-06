import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = BlocProvider.of<EditProfileCubit>(context);
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      buildWhen: (previous, current) => current.editProfileState.isLoading ||
          current.editProfileState.isFailure,
      builder: (context, state) {
        return Form(
          key: controller.editFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: controller.firstNameController,
                      label: AppText.firstName,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: controller.firstNameController.text,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          Validations.validateEmptyText(value),
                    ),
                  ),
                  const RSizedBox(width: 17),
                  Expanded(
                    child: CustomTextFormField(
                      label: AppText.lastName,
                      controller: controller.lastNameController,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: controller.lastNameController.text,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          Validations.validateEmptyText(value),
                    ),
                  ),
                ],
              ),
              const RSizedBox(height: 24),
              CustomTextFormField(
                controller: controller.emailController,
                label: AppText.email,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: controller.emailController.text,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) => Validations.emailValidation(email: value),
              ),
              const RSizedBox(height: 24),
              CustomTextFormField(
                controller: controller.phoneNumberController,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                label: AppText.phoneNumber,
                hintText: controller.phoneNumberController.text,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    Validations.phoneValidation(phoneNumber: value),
              ),
              const RSizedBox(height: 24),
              Stack(
                children: [
                  IgnorePointer(
                    child: CustomTextFormField(
                      label: AppText.password,
                      hintText: "★★★★★★",
                      hintStyle: theme.textTheme.labelLarge?.copyWith(
                      color: AppColors.black,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    isReadOnly: true,
                    obscureText: true,
                    obscuringCharacter: '★',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                 PositionedDirectional(
                  end: 8,
                  top: 20,
                  child: GestureDetector(
                    onTap: () {
                      //navigate to reset password screen
                    },
                    child: Text(AppText.changePassword,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.pink,
                      fontWeight: FontWeight.w600
                    ),),
                  ))
                ]
              ),
            ],
          ),
        );
      },
    );
  }
}

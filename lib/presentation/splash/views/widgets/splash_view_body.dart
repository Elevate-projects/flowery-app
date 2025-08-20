import 'package:flowery_app/core/constants/app_images.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/presentation/splash/views_model/splash_cubit.dart';
import 'package:flowery_app/presentation/splash/views_model/splash_intent.dart';
import 'package:flowery_app/presentation/splash/views_model/splash_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<SplashCubit>(context);
    return BlocListener<SplashCubit, SplashState>(
      listenWhen: (previous, current) =>
          current is FetchUserDataFailureState ||
          current is FetchUserDataSuccessState ||
          current is LoginNavigationState,
      listener: (BuildContext context, SplashState state) {
        if (state is FetchUserDataFailureState) {
          Loaders.showErrorMessage(
            message: state.errorData.message,
            context: context,
          );
        } else if (state is FetchUserDataSuccessState) {
          // Navigator.of(
          //   context,
          // ).pushReplacementNamed(home screen);
          Loaders.showSuccessMessage(
            message:
                "User Name is ${FloweryMethodHelper.userData?.firstName} ${FloweryMethodHelper.userData?.lastName}",
            context: context,
          );
        } else if (state is LoginNavigationState) {
          Navigator.of(context).pushReplacementNamed(RouteNames.login);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AppImages.floweryLogo,
              height: 180.r,
              width: 180.r,
            ),
          ),
          const RSizedBox(height: 52),
          BlocBuilder<SplashCubit, SplashState>(
            buildWhen: (previous, current) =>
                current is FetchUserDataLoadingState ||
                current is FetchUserDataFailureState,
            builder: (context, state) {
              if (state is FetchUserDataLoadingState) {
                return Center(
                  child: SizedBox(
                    width: 30.r,
                    height: 30.r,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                );
              } else if (state is FetchUserDataFailureState) {
                return RPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      CustomElevatedButton(
                        onPressed: () async {
                          await controller.doIntent(
                            intent: GetUserDataIntent(),
                          );
                        },
                        buttonTitle: AppText.tryAgain,
                      ),
                      const RSizedBox(height: 16),
                      CustomElevatedButton(
                        onPressed: () {
                          controller.doIntent(
                            intent: NavigateToLoginViewIntent(),
                          );
                        },
                        buttonTitle: AppText.reLogin,
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: SizedBox(
                    width: 30.r,
                    height: 30.r,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

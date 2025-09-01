import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/flowery_bottom_navigation/view_model/flowery_bottom_navigation_cubit.dart';
import 'package:flowery_app/presentation/flowery_bottom_navigation/view_model/flowery_bottom_navigation_intent.dart';
import 'package:flowery_app/presentation/flowery_bottom_navigation/view_model/flowery_bottom_navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FloweryBottomNavigation extends StatelessWidget {
  const FloweryBottomNavigation({super.key});
  @override
  Widget build(BuildContext context) {
    final pages = context.read<FloweryBottomNavigationCubit>().pages;
    final theme = Theme.of(context);
    return BlocBuilder<
      FloweryBottomNavigationCubit,
      FloweryBottomNavigationState
    >(
      builder: (context, state) {
        return Scaffold(
          body: pages[state.currentIndex],
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(height: 1, thickness: 1, color: AppColors.white[60]),
              BottomNavigationBar(
                backgroundColor: theme.colorScheme.secondary,
                type: BottomNavigationBarType.fixed,
                currentIndex: state.currentIndex,
                onTap: (index) {
                  context.read<FloweryBottomNavigationCubit>().doIntent(
                    intent: ChangeIndexIntent(index: index),
                  );
                },
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppIcons.activeHome,
                      colorFilter: ColorFilter.mode(
                        state.currentIndex == 0
                            ? theme.colorScheme.primary
                            : AppColors.white[80]!,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: AppText.home,
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppIcons.activeCategories,
                      colorFilter: ColorFilter.mode(
                        state.currentIndex == 1
                            ? theme.colorScheme.primary
                            : AppColors.white[80]!,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: AppText.categories,
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppIcons.activeCart,
                      colorFilter: ColorFilter.mode(
                        state.currentIndex == 2
                            ? theme.colorScheme.primary
                            : AppColors.white[80]!,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: AppText.cart,
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppIcons.activeProfile,
                      colorFilter: ColorFilter.mode(
                        state.currentIndex == 3
                            ? theme.colorScheme.primary
                            : AppColors.white[80]!,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: AppText.profile,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

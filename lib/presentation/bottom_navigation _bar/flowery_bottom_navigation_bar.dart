import 'package:flowery_app/presentation/bottom_navigation%20_bar/view_model/bottom_cubit.dart';
import 'package:flowery_app/presentation/bottom_navigation%20_bar/view_model/bottom_intent.dart';
import 'package:flowery_app/presentation/bottom_navigation%20_bar/view_model/bottom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_text.dart';
class FloweryBottomNavigationBar extends StatelessWidget {
   const FloweryBottomNavigationBar({super.key});
  @override
  Widget build(BuildContext context) {
    final pages = context.read<BottomCubit>().pages;
    final theme = Theme.of(context);
    return BlocBuilder<BottomCubit, BottomState>(builder: (context, state){
      return Scaffold(
          body: pages[state.currentIndex],
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            Divider(
            height: 1,
            thickness: 1,
            color: theme.colorScheme.shadow,
          ),
          BottomNavigationBar(
            backgroundColor: theme.colorScheme.secondary,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: theme.colorScheme.shadow,
            selectedItemColor: theme.primaryColor,
            currentIndex: state.currentIndex,
            onTap: (index) {
              context.read<BottomCubit>().doIntent(ChangeIntent(index));
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.activeHome,
                  colorFilter: ColorFilter.mode(
                    state.currentIndex == 0 ? Colors.pinkAccent : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: AppText.home,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.activeCategories,
                  colorFilter: ColorFilter.mode(
                    state.currentIndex == 1 ? Colors.pinkAccent : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.activeCart,
                  colorFilter: ColorFilter.mode(
                    state.currentIndex == 2 ? Colors.pinkAccent : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.activeProfile,
                  colorFilter: ColorFilter.mode(
                    state.currentIndex == 3 ? Colors.pinkAccent : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
      ])
      );
    },
    );
  }
}

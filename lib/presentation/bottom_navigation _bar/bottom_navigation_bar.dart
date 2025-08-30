import 'package:flowery_app/presentation/bottom_navigation%20_bar/view_model/bottom_cubit.dart';
import 'package:flowery_app/presentation/bottom_navigation%20_bar/view_model/bottom_intent.dart';
import 'package:flowery_app/presentation/bottom_navigation%20_bar/view_model/bottom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../pages/cart_page.dart';
import '../pages/categories_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';
class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}
class _MyBottomNavBarState extends State<MyBottomNavBar> {
  final List<Widget> _pages = [
    const HomePage(),
    const CategoriesPage(),
    const CartPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => BottomCubit(),
      child: BlocBuilder<BottomCubit, BottomState>(builder: (context, state){
        return Scaffold(
          body: _pages[state.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey,
            currentIndex: state.currentIndex,
            onTap: (index){
              context.read<BottomCubit>().onIntent(ChangeIntent(index));
            },
            items:  [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/active_home.svg',
                  colorFilter: ColorFilter.mode(
                    state.currentIndex == 0 ? Colors.pinkAccent : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/active_categories.svg',
                  colorFilter: ColorFilter.mode(
                    state.currentIndex == 1 ? Colors.pinkAccent : Colors.grey
                  , BlendMode.srcIn),
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                    'assets/icons/active_cart.svg',
                  colorFilter: ColorFilter.mode(
                    state.currentIndex == 2 ? Colors.pinkAccent : Colors.grey
                  , BlendMode.srcIn),
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/active_profile.svg',
                  colorFilter: ColorFilter.mode(
                    state.currentIndex == 3 ? Colors.pinkAccent : Colors.grey
                  , BlendMode.srcIn),
                ),
                label: 'Profile',
              ),
            ],
          )
        );
      },
      ),
    );
  }
}

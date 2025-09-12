import 'package:flowery_app/presentation/categories/views_model/categories_cubit.dart';
import 'package:flowery_app/presentation/categories/views_model/categories_state.dart';
import 'package:flowery_app/utils/common_widgets/product_card_item/product_card_item.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesTabBarView extends StatelessWidget {
  const CategoriesTabBarView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) => TabBarView(
        physics: const BouncingScrollPhysics(),
        children: state.categoriesProductsList
            .map(
              (productsList) => GridView.builder(
                padding: REdgeInsets.symmetric(horizontal: 16),
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 17.r,
                  mainAxisSpacing: 17.r,
                  childAspectRatio: FloweryMethodHelper.currentUserToken != null
                      ? 1 / 1.44
                      : 1 / 1.28,
                ),
                itemBuilder: (_, index) =>
                    ProductCardItem(productCardData: productsList[index]),
                itemCount: productsList.length,
              ),
            )
            .toList(),
      ),
    );
  }
}

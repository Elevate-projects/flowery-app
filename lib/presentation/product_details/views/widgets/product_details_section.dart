import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/presentation/product_details/views_model/product_details_cubit.dart';
import 'package:flowery_app/presentation/product_details/views_model/product_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsSection extends StatelessWidget {
  const ProductDetailsSection({super.key, required this.productCardData});
  final ProductCardEntity productCardData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 6,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "${AppText.egp} ${productCardData.priceAfterDiscount.toString()}",
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const RSizedBox(width: 8),
              Flexible(
                flex: 3,
                child: Row(
                  children: [
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          AppText.status,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child:
                            BlocBuilder<
                              ProductDetailsCubit,
                              ProductDetailsState
                            >(
                              builder: (context, state) => Text(
                                state.isInStock!
                                    ? AppText.inStock
                                    : AppText.outStock,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.colorScheme.onSecondary,
                                ),
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const RSizedBox(height: 4),
          Text(
            AppText.taxIncludedMessage,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.shadow,
            ),
          ),
          Visibility(
            visible: productCardData.title != null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RSizedBox(height: 8),
                Text(
                  productCardData.title ?? "",
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RSizedBox(height: 24),
              Text(
                AppText.description,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
              ),
              const RSizedBox(height: 8),
              Visibility(
                visible: productCardData.description != null,
                child: Text(
                  productCardData.description ?? "",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

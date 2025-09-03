import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/presentation/product_details/views/widgets/product_details_view_body.dart';
import 'package:flowery_app/presentation/product_details/views_model/product_details_cubit.dart';
import 'package:flowery_app/presentation/product_details/views_model/product_details_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.productCardData});
  final ProductCardEntity productCardData;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailsCubit>(
      create: (context) => getIt.get<ProductDetailsCubit>()
        ..doIntent(
          intent: InitializeProductDetailsIntent(
            productCardData: productCardData,
          ),
        ),
      child: Scaffold(
        body: ProductDetailsViewBody(productCardData: productCardData),
      ),
    );
  }
}

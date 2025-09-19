import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/presentation/search/search/view/widgets/search_app_bar.dart';
import 'package:flowery_app/presentation/search/search/view/widgets/search_body.dart';
import 'package:flowery_app/presentation/search/search/view_model/search_view_model.dart';
import 'package:flowery_app/utils/common_cubits/add_product_to_cart/add_product_to_cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<SearchViewModel>()),
        BlocProvider(create: (context) => getIt.get<AddProductToCartCubit>()),
      ],
      child: const Scaffold(appBar: SearchAppBar(), body: SearchBody()),
    );
  }
}

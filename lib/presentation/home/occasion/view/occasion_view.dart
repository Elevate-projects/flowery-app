import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/presentation/home/occasion/view_model/occasion_cubit.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/product_card/product_card_entity.dart';
import '../view_model/occasion_intent.dart';
 import '../widgets/product_cart.dart';

class OccasionView extends StatelessWidget {
  OccasionView({super.key});

  final List<String> tabList = [
    "Wedding",
    "Graduation",
    "Birthday",
    "Katb Ketab",
  ];

  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
        create: (BuildContext context) =>
    OccasionsViewModel()..doIntent(LoadOccasionProducts(tabList[0])),
          child: DefaultTabController(
            length: tabList.length,
        child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: AppColors.black),
          title: const Text('Occasion'),
          bottom: TabBar(tabs: tabList.map((e) => Tab(text: e)).toList(),
              onTap: (index) {
                context.read<OccasionsViewModel>().doIntent(LoadOccasionProducts("Wedding"));

              },
            labelColor: Colors.pinkAccent,
            isScrollable: true,
          ),),

        body: TabBarView(
        children: tabList.map((e) {
          return   BlocBuilder<OccasionsViewModel,
              StateStatus<List<ProductCardEntity>>>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.isSuccess) {
                final products = state.data!;
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    final product = products[0];
                    return ProductCard(product: product);
                  },
                );
              } else if (state.isFailure) {
                return Center(
                    child: Text("${AppText.error}${state.error}"));
              }
              return const SizedBox.shrink();
            },
          );
        }).toList(),
        ),
        ),
          ),
      );
  }

}


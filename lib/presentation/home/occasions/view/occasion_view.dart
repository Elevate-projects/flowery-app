import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/arguments/occasion_arguments_entity.dart';
import 'package:flowery_app/presentation/home/occasions/view_model/occasion_view_model.dart';
import 'package:flowery_app/utils/common_widgets/product_card_item/product_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flowery_app/presentation/home/occasions/view_model/occasion_intent.dart';

class OccasionView extends StatelessWidget {
  const OccasionView({super.key, required this.occasionArguments});

  final OccasionArgumentsEntity occasionArguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          getIt<OccasionsViewModel>()
            ..doIntent(LoadOccasionProducts(occasionArguments.occasion.name!)),
      child:
          BlocBuilder<
            OccasionsViewModel,
            StateStatus<List<OccasionArgumentsEntity>>
          >(
            builder: (context, state) {
              switch (state.status) {
                case Status.initial:
                  return const Scaffold(body: SizedBox.shrink());
                case Status.loading:
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                case Status.success:
                  final data = state.data ?? [];
                  if (data.isEmpty) {
                    return const Scaffold(
                      body: Center(child: Text(AppText.noProductsFound)),
                    );
                  }
                  return DefaultTabController(
                    length: data.length,
                    child: Scaffold(
                      appBar: AppBar(
                        titleSpacing: 0,
                        leadingWidth: 35,
                        toolbarHeight: 80,
                        leading: IconButton(
                          padding: const EdgeInsets.only(left: 12, bottom: 4),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.black,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                AppText.occasion,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 3),

                              Text(
                                AppText.titleBar,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        bottom: TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          padding: EdgeInsets.zero,
                          dividerHeight: 0,
                          indicatorPadding: REdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          physics: const BouncingScrollPhysics(),
                          tabs: data
                              .map((o) => Tab(text: o.occasion.name))
                              .toList(),

                          labelColor: Colors.pinkAccent,
                          tabAlignment: TabAlignment.start,
                          labelStyle: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          isScrollable: true,
                        ),
                      ),

                      body: TabBarView(
                        children: data.map((occasionData) {
                          return GridView.builder(
                            padding: const EdgeInsets.all(12),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 17.r,
                                  mainAxisSpacing: 17.r,
                                  childAspectRatio: 1 / 1.44,
                                ),
                            itemCount: occasionData.listOfProducts.length,
                            itemBuilder: (context, index) {
                              return ProductCardItem(
                                productCardData:
                                    occasionData.listOfProducts[index],
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  );
                case Status.failure:
                  return Scaffold(
                    body: Center(
                      child: Text(
                        state.error?.message ?? AppText.unexpectedError,
                      ),
                    ),
                  );
              }
            },
          ),
    );
  }
}

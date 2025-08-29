import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/arguments/occasion_arguments_entitiy.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
 import 'package:flowery_app/presentation/home/occasion/view_model/occasion_cubit.dart';
import 'package:flowery_app/presentation/home/occasion/widgets/product_cart.dart';
import 'package:flowery_app/utils/common_widgets/product_card_item/product_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 import '../view_model/occasion_intent.dart';

class OccasionView extends StatelessWidget {
  final OccasionArgumentsEntity occasionArguments;

  OccasionView({super.key, required this.occasionArguments});



  @override
  Widget build(BuildContext context) {
   final tabList = occasionArguments.listOfOccasions.map((e) => e.name!).toList();

    return BlocProvider(
      create: (BuildContext context) => OccasionsViewModel()
        ..doIntent(
          LoadOccasionProducts(occasionArguments.listOfOccasions[0].id!),
        ),
      child: DefaultTabController(
        length: tabList.length,
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            leadingWidth: 35,
            toolbarHeight: 85,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: AppColors.black),
              onPressed: () => Navigator.pop(context),
            ),

            title: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    AppText.occasion,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),

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
              tabs: occasionArguments.listOfOccasions
                  .map((e) => Tab(text: e.name))
                  .toList(),
              onTap: (index) {
                context.read<OccasionsViewModel>().doIntent(
                  LoadOccasionProducts(
                    occasionArguments.listOfOccasions[index].id!,
                  ),
                );
              },
              labelColor: Colors.pinkAccent,
              isScrollable: true,
            ),
          ),

          body: TabBarView(
            children: tabList.map((e) {
              return BlocBuilder<
                OccasionsViewModel,
                StateStatus<List<ProductCardEntity>>>(
                builder: (context, state) {
                  if(state.isLoading) {
                  return  Center(child:CircularProgressIndicator(),);

                  }else if(state.isSuccess){
                    final products = state.data;

                    return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.44,
                          mainAxisSpacing: 17,
                          crossAxisSpacing: 17,
                        ),
                    itemCount: products?.length,
                    itemBuilder: (context, index) {
                      return ProductCardItem(productCardData: occasionArguments.listOfProducts[index]);
                    },
                  );}else if (state.isFailure) {
                    return Center(child: Text(state.error as String  ));
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

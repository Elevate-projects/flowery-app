import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../categories/categories_view_model/categories_cubit.dart';
import '../categories/categories_view_model/cubit_intent.dart';
import '../categories/categories_view_model/cubit_status.dart';
import '../categories/widget/custom_bottom.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoriesCubit(),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          final categories = state.categories;
          return DefaultTabController(
            length: categories.length,
            child: Scaffold(
              body: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                          child: CustomFormField(
                        hintText: 'Search',
                        prefixIcon: Icons.search,
                      )),
                      Expanded(child: CustomFormField(
                        hintText: 'Filter',
                        prefixIcon: Icons.filter_list,
                      ))
                    ],
                  ),
                  TabBar(
                    padding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    tabs: categories.map((c) => Tab(text: c.name)).toList(),
                    onTap: (index) {
                      context.read<CategoriesCubit>().onIntent(
                        CategoriesType(categories[index].name),
                      );
                    },
                  ),
                  Expanded(
                    child: TabBarView(
                      children: categories.map((c) {
                        return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          childAspectRatio: 0.9,
                          children: List.generate(state.categories.length, (index) {
                            return Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                      child: Image.network(
                                        c.imageUrl,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      c.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // action
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        elevation: 0,
                                        minimumSize: const Size(double.infinity, 40),
                                      ),
                                      child: const Text(
                                        'Add to Cart',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

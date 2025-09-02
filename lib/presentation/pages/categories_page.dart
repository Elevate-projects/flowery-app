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
    final theme = Theme.of(context);
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
                  const Row(
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
                    indicatorColor: theme.primaryColor,
                    labelColor: theme.primaryColor,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: theme.textTheme.bodyLarge,
                    unselectedLabelStyle: theme.textTheme.bodyLarge,
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
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          children: const [
                            ProductCard(
                              name: "Red roses",
                              imageUrl: "https://media.istockphoto.com/id/2216481617/photo/ai-coding-assistant-interface-with-vibe-coding-aesthetics.jpg?s=1024x1024&w=is&k=20&c=Ep6IzWap247shXrMuCxeNIgSf27jrDTEkJY7b7ABL70=",
                              price: 600,
                              oldPrice: 800,
                              discount: 20,
                            ),
                          ],
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
class ProductCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double price;
  final double oldPrice;
  final int discount;

  const ProductCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.oldPrice,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Container(
                color: const Color(0xFFFFF0F5),
                child: Image.network(
                  imageUrl,
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              name,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                Text(
                  "EGP $price",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  "$oldPrice",
                  style: const TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 3),
                Text(
                  "$discount%",
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart_outlined, size: 18, color: Colors.white,),
                label: const Text("Add to cart", style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/presentation/search/search/view/widgets/search_app_bar.dart';
import 'package:flowery_app/presentation/search/search/view/widgets/search_body.dart';
import 'package:flowery_app/presentation/search/search/view_model/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchViewModel>(
      create: (context) => getIt.get<SearchViewModel>(),
      child: const Scaffold(appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SearchAppBar(),
        ), body: SearchBody(),
      ),
    );
  }
}

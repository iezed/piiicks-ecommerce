import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/categories_bloc/category_bloc.dart';
import '../../configs/configs.dart';
import '../widgets/rectangular_category_item.dart';
import '../widgets/top_row.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.only(top: AppDimensions.normalize(22)),
          child: Padding(
            padding: Space.h1!,
            child: Column(
              children: [
                TopRow(isFromHome: false),
                Space.yf(.2),
                 Expanded(
                   child: BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (context, state) {
                       return ListView.builder(
                         itemCount: (state is CategoryLoading)
                             ? 7
                             : state.categories.length,
                         physics: const ClampingScrollPhysics(),
                         itemBuilder: (context, index) =>
                         (state is CategoryLoading)
                             ? const RectangularCategoryItem()
                             : RectangularCategoryItem(
                           category: state.categories[index],
                         ),
                       );
                     },
                   ),
                 ),
              ],
            ),
          ),
        ),
    );
  }
}

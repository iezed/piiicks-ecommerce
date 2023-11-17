import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/products_bloc/product_bloc.dart';
import '../../data/models/product/filter_params_model.dart';
import '../di/di.dart' as di;

import '../../application/categories_bloc/category_bloc.dart';
import '../router/app_router.dart';
import '../constant/colors.dart';
import '../constant/strings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              di.sl<CategoryBloc>()..add(const GetCategories()),
        ),
        BlocProvider(
          create: (context) => di.sl<ProductBloc>()
            ..add(const GetProducts(FilterProductParams())),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        onGenerateRoute: AppRouter.onGenerateRoute,
        theme: ThemeData.light().copyWith(
            canvasColor: AppColors.CommonBlue,
            appBarTheme: AppBarTheme(
                color: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                toolbarHeight: 56,
                centerTitle: true,
                iconTheme:
                    IconThemeData(color: AppColors.CommonBlue, size: 30)),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.CommonBlue),
              minimumSize: MaterialStateProperty.all(const Size(170, 50)),
            )),
            iconTheme:
                const IconThemeData(color: AppColors.CommonBlue, size: 30)),
        initialRoute: AppRouter.splash,
      ),
    );
  }
}

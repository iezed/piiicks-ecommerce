import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piiicks/configs/app.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/presentation/widgets/top_row.dart';
import 'package:piiicks/shared/constant/assets.dart';
import 'package:piiicks/shared/constant/colors.dart';

import '../../application/categories_bloc/category_bloc.dart';
import '../widgets/square_category_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 1;
  PageController _pageController = PageController();

  @override
  void initState() {
    _pageController = PageController(initialPage: currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: AppDimensions.normalize(22)),
        child: Padding(
          padding: Space.h1!,
          child: Column(
            children: [
             TopRow(isFromHome: true),
              Space.yf(.2),
               Expanded(
                 child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppDimensions.normalize(110),
                        child: Stack(
                          children: [
                            PageView.builder(
                                controller: _pageController,
                                onPageChanged: (pos) {
                                  setState(() {
                                    currentPage = pos;
                                  });
                                },
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return SvgPicture.asset(
                                    Assets.PiiicksIcon,
                                    fit: BoxFit.cover,
                                  );
                                }),
                            Positioned(
                              bottom: AppDimensions.normalize(2),
                              left: 0,
                              right: 0,
                              child: _dotsindicator(
                                _pageController.hasClients
                                    ? _pageController.page?.round()
                                    : 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: AppDimensions.normalize(15),bottom: AppDimensions.normalize(7)),
                        child: Text(
                          "FEATURED CATEGORIES",
                          style:
                              AppText.h2b?.copyWith(color: AppColors.CommonBlue),
                        ),
                      ),
                      BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                          return SizedBox(
                            height: AppDimensions.normalize(100),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  (state is CategoryLoading)
                                      ? const SquareCategoryItem()
                                      : SquareCategoryItem(
                                          category: state.categories[index],
                                        ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
              ),
               ),
            ],
          ),
        ),
      ),
    );
  }

  _dotsindicator(int? dotsindex) {
    return DotsIndicator(
      dotsCount: 3,
      position: dotsindex!,
      decorator: DotsDecorator(
          color: Colors.white,
          activeColor: Colors.black,
          size: Size.fromRadius(
            AppDimensions.normalize(2.5),
          ),
          activeSize: Size.fromRadius(AppDimensions.normalize(2.5))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:klontong_app/features/product/presentation/pages/add_product_page.dart';
import '../../../../core/components/search_input.dart';

import 'detail_product_page.dart';

import '../../../../core/components/spaces.dart';
import '../bloc/product_bloc.dart';
import '../../../../core/constants/color_manager.dart';
import '../../../../core/constants/font_manager.dart';
import '../../../../core/constants/style_manager.dart';
import '../widgets/card_item.dart';
import '../widgets/card_total.dart';
import '../widgets/custom_clippath.dart';

class ListProductPage extends StatefulWidget {
  const ListProductPage({super.key});

  @override
  State<ListProductPage> createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<ProductBloc>().add(GetAllProductEvents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget headerContent() {
      return Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  width: double.infinity,
                  height: (ScreenUtil().orientation == Orientation.portrait)
                      ? size.height * 0.18
                      : size.width * 0.18,
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                  ),
                ),
              ),
              Positioned(
                top: -15,
                left: size.width - 140,
                child: Container(
                  width: 130.h,
                  height: 130.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.blackC.withOpacity(0.05),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    22,
                    (ScreenUtil().orientation == Orientation.portrait
                        ? size.height * 0.05
                        : size.width * 0.05),
                    22,
                    0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: BlocBuilder<ProductBloc, ProductState>(
                            builder: (context, state) {
                              return CardTotal(
                                svgUrl: "assets/svg/shipping.svg",
                                description: "Total Products",
                                quantity: (state is ProductsLoadedState)
                                    ? ('${state.totalProduct}')
                                    : '0',
                                colorTop: ColorManager.primaryLight,
                                colorBottom: ColorManager.primary,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SpaceHeight(15.h),
                    SearchInput(
                      controller: searchController,
                      onChanged: (query) {
                        context
                            .read<ProductBloc>()
                            .add(SearchProductEvent(query));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }

    Widget itemEmpty(String description) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpaceHeight(size.height * 0.15),
            SvgPicture.asset(
              "assets/svg/empty.svg",
              width: 80,
              fit: BoxFit.cover,
            ),
            const SpaceHeight(13),
            Text(
              description,
              textAlign: TextAlign.center,
              style: getTextStyle(
                FontSizeManager.f13,
                FontFamilyConstant.fontFamily,
                FontWeightManager.semiBold,
                ColorManager.greyC,
              ),
            ),
          ],
        ),
      );
    }

    Widget itemContent() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpaceHeight(15.h),
            Text(
              "Products",
              style: getTextStyle(
                FontSizeManager.f15,
                FontFamilyConstant.fontFamily,
                FontWeightManager.semiBold,
                ColorManager.greyC,
              ),
            ),
            BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is ProductErrorState) {
                  if (state.type == ErrorType.all) {
                    SnackBar snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        state.error,
                        style: getTextStyle(
                          FontSizeManager.f14,
                          FontFamilyConstant.fontFamily,
                          FontWeightManager.regular,
                          ColorManager.whiteC,
                        ),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              },
              builder: (context, state) {
                if (state is ProductsLoadedState) {
                  if (state.products.isNotEmpty) {
                    return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                          context
                              .read<ProductBloc>()
                              .add(LoadMoreProductEvent());
                        }
                        return false;
                      },
                      child: Column(
                        children: [
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            crossAxisCount: (ScreenUtil().orientation ==
                                    Orientation.portrait
                                ? 2
                                : 4),
                            children: state.products.map((product) {
                              return CardItem(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailProductPage(
                                        idPrimary: product.idPrimary ?? '',
                                      ),
                                    ),
                                  );
                                },
                                product: product,
                              );
                            }).toList(),
                          ),
                          if (state.products.length == 12)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  color: ColorManager.primary,
                                ),
                              ),
                            ),
                          const SpaceHeight(20),
                        ],
                      ),
                    );
                  } else {
                    return itemEmpty("Empty Data.\nGo Add Some Product Here");
                  }
                } else if (state is ProductLoadingState) {
                  if (state.type == LoadingType.all) {
                    return Column(
                      children: [
                        SpaceHeight(170.h),
                        Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.primary,
                          ),
                        ),
                      ],
                    );
                  }
                } else if (state is ProductErrorState) {
                  if (state.type == ErrorType.search) {
                    return itemEmpty('Product Not Found');
                  }
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      );
    }

    Widget floatingButtonCustom() {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage(),
            ),
          );
        },
        backgroundColor: ColorManager.primary,
        child: Icon(
          Icons.add,
          color: ColorManager.whiteC,
        ),
      );
    }

    return Scaffold(
      floatingActionButton: floatingButtonCustom(),
      body: RefreshIndicator(
        color: ColorManager.primary,
        onRefresh: () async {
          context.read<ProductBloc>().add(GetAllProductEvents());
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              context.read<ProductBloc>().add(LoadMoreProductEvent());
            }
            return false;
          },
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              headerContent(),
              itemContent(),
            ],
          ),
        ),
      ),
    );
  }
}

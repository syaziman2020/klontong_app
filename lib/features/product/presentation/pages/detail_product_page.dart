import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../../core/components/spaces.dart';
import 'list_product_page.dart';
import 'success_page.dart';
import 'update_product_page.dart';
import '../../../../core/constants/color_manager.dart';
import '../../../../core/constants/font_manager.dart';
import '../../../../core/constants/style_manager.dart';

import '../bloc/product_bloc.dart';

class DetailProductPage extends StatefulWidget {
  final String idPrimary;
  const DetailProductPage({super.key, required this.idPrimary});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  @override
  void initState() {
    context.read<ProductBloc>().add(GetProductEvent(widget.idPrimary));
    super.initState();
  }

  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        iconTheme: IconThemeData(
          color: ColorManager.greyC,
        ),
        elevation: 0,
        backgroundColor: ColorManager.whiteC,
        title: const Text("Detail Product"),
        titleTextStyle: getTextStyle(
          FontSizeManager.f13,
          FontFamilyConstant.fontFamily,
          FontWeightManager.semiBold,
          ColorManager.greyDarkC,
        ),
        centerTitle: true,
      );
    }

    void showDeleteBottomSheet(
        BuildContext context, String idPrimary, String name) {
      showModalBottomSheet(
        backgroundColor: ColorManager.whiteC,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delete Product",
                  style: getTextStyle(
                    FontSizeManager.f18,
                    FontFamilyConstant.fontFamily,
                    FontWeightManager.bold,
                    ColorManager.blackC,
                  ),
                ),
                const SpaceHeight(10),
                Text(
                  "Are you sure you want to delete Product $name?",
                  style: getTextStyle(
                    FontSizeManager.f14,
                    FontFamilyConstant.fontFamily,
                    FontWeightManager.regular,
                    ColorManager.blackC,
                  ),
                ),
                const SpaceHeight(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Jika user memilih cancel, hanya menutup bottom sheet
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: getTextStyle(
                          FontSizeManager.f16,
                          FontFamilyConstant.fontFamily,
                          FontWeightManager.regular,
                          ColorManager.greyC,
                        ),
                      ),
                    ),
                    BlocConsumer<ProductBloc, ProductState>(
                      listener: (context, state) {
                        if (state is ProductErrorState) {
                          if (state.type == ErrorType.delete) {
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } else if (state is ProductDeleteState) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SuccessPage(
                                  title: 'Product Success Deleted',
                                  nextPage: ListProductPage(),
                                ),
                              ),
                              (route) => false);
                        }
                      },
                      builder: (context, state) {
                        if (state is ProductLoadingState) {
                          if (state.type == LoadingType.delete) {
                            return CircularProgressIndicator(
                              color: ColorManager.primary,
                            );
                          }
                        }
                        return ElevatedButton(
                          onPressed: () {
                            context
                                .read<ProductBloc>()
                                .add(DeleteProductEvent(idPrimary));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          child: Text(
                            "Delete",
                            style: getTextStyle(
                              FontSizeManager.f16,
                              FontFamilyConstant.fontFamily,
                              FontWeightManager.regular,
                              ColorManager.whiteC,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }

    Widget editItem() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductSingleState) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateProductPage(
                              product: state.product,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ColorManager.whiteC,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff9E9E9E).withOpacity(0.1),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/edt.svg",
                              width: 20,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Update",
                              style: getTextStyle(
                                FontSizeManager.f13,
                                FontFamilyConstant.fontFamily,
                                FontWeightManager.semiBold,
                                ColorManager.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SpaceWidth(14),
                    GestureDetector(
                      onTap: () {
                        showDeleteBottomSheet(
                            context, widget.idPrimary, state.product.name);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ColorManager.whiteC,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff9E9E9E).withOpacity(0.1),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/delete.svg",
                              width: 20,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Delete",
                              style: getTextStyle(
                                FontSizeManager.f13,
                                FontFamilyConstant.fontFamily,
                                FontWeightManager.semiBold,
                                Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is ProductLoadingState) {
                if (state.type == LoadingType.single) {
                  return const SizedBox.shrink();
                }
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      );
    }

    Widget pictureContent() {
      return BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductSingleState) {
            return Container(
              margin: const EdgeInsets.only(top: 10, bottom: 45),
              width: double.maxFinite,
              height: 183,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(state.product.image),
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );
    }

    Widget information() {
      return BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductSingleState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.product.name,
                  style: getTextStyle(
                    FontSizeManager.f18,
                    FontFamilyConstant.fontFamily,
                    FontWeightManager.semiBold,
                    ColorManager.greyC,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorManager.primary.withOpacity(0.4),
                  ),
                  child: Text(
                    state.product.category,
                    style: getTextStyle(
                      FontSizeManager.f12,
                      FontFamilyConstant.fontFamily,
                      FontWeight.normal,
                      ColorManager.blackC,
                    ),
                  ),
                ),
                const SpaceHeight(10),
                Text(
                  state.product.sku,
                  style: getTextStyle(
                    FontSizeManager.f13,
                    FontFamilyConstant.fontFamily,
                    FontWeightManager.regular,
                    ColorManager.greyC,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Length: ${state.product.length}',
                  style: getTextStyle(
                    FontSizeManager.f12,
                    FontFamilyConstant.fontFamily,
                    FontWeightManager.regular,
                    ColorManager.greyC,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Width: ${state.product.width}',
                  style: getTextStyle(
                    FontSizeManager.f12,
                    FontFamilyConstant.fontFamily,
                    FontWeightManager.regular,
                    ColorManager.greyC,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Weight: ${state.product.weight}',
                  style: getTextStyle(
                    FontSizeManager.f12,
                    FontFamilyConstant.fontFamily,
                    FontWeightManager.regular,
                    ColorManager.greyC,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Price: ${formatter.format(state.product.price)}',
                  style: getTextStyle(
                    FontSizeManager.f12,
                    FontFamilyConstant.fontFamily,
                    FontWeightManager.regular,
                    ColorManager.greyC,
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Text(
                  "Description",
                  style: getTextStyle(
                    FontSizeManager.f13,
                    FontFamilyConstant.fontFamily,
                    FontWeightManager.regular,
                    ColorManager.blackC,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  state.product.description,
                  textAlign: TextAlign.justify,
                  style: getTextStyle(
                    FontSizeManager.f13,
                    FontFamilyConstant.fontFamily,
                    FontWeightManager.regular,
                    ColorManager.greyC,
                  ),
                ),
              ],
            );
          } else if (state is ProductLoadingState) {
            if (state.type == LoadingType.single) {
              return SizedBox(
                height: 400.h,
                child: Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.primary,
                  ),
                ),
              );
            }
          } else if (state is ProductErrorState) {
            if (state.type == ErrorType.single) {
              return Text(
                "Error product",
                style: getTextStyle(
                  FontSizeManager.f15,
                  FontFamilyConstant.fontFamily,
                  FontWeightManager.bold,
                  Colors.red,
                ),
              );
            }
          }
          return const SizedBox.shrink();
        },
      );
    }

    return PopScope(
      onPopInvoked: (didPop) {
        context.read<ProductBloc>().add(GetAllProductEvents());
      },
      child: Scaffold(
        backgroundColor: ColorManager.whiteC,
        appBar: appBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: RefreshIndicator(
            onRefresh: () async {
              context
                  .read<ProductBloc>()
                  .add(GetProductEvent(widget.idPrimary));
            },
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                return ListView(
                  children: [
                    editItem(),
                    pictureContent(),
                    information(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

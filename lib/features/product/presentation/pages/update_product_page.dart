import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/custom_textfield.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/color_manager.dart';
import '../../../../core/constants/font_manager.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import 'list_product_page.dart';

import '../../../../core/constants/style_manager.dart';
import 'success_page.dart';

class UpdateProductPage extends StatefulWidget {
  final Product product;

  const UpdateProductPage({super.key, required this.product});

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final TextEditingController nameC = TextEditingController();

  final TextEditingController imageC = TextEditingController();

  final TextEditingController skuC = TextEditingController();

  final TextEditingController lengthC = TextEditingController();

  final TextEditingController heigthC = TextEditingController();

  final TextEditingController widthC = TextEditingController();

  final TextEditingController weightC = TextEditingController();

  final TextEditingController priceC = TextEditingController();

  final TextEditingController categoryC = TextEditingController();

  final TextEditingController descC = TextEditingController();

  @override
  void initState() {
    nameC.text = widget.product.name;
    imageC.text = widget.product.image;
    skuC.text = widget.product.sku;
    lengthC.text = widget.product.length.toString();
    heigthC.text = widget.product.height.toString();
    widthC.text = widget.product.width.toString();
    weightC.text = widget.product.weight.toString();
    priceC.text = widget.product.price.toString();
    categoryC.text = widget.product.category;
    descC.text = widget.product.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        iconTheme: IconThemeData(
          color: ColorManager.greyC,
        ),
        elevation: 0,
        backgroundColor: ColorManager.whiteC,
        title: const Text("Update Product"),
        titleTextStyle: getTextStyle(
          FontSizeManager.f13,
          FontFamilyConstant.fontFamily,
          FontWeightManager.semiBold,
          ColorManager.greyDarkC,
        ),
        centerTitle: true,
      );
    }

    return Scaffold(
      backgroundColor: ColorManager.whiteC,
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            CustomTextField(controller: nameC, label: 'Name'),
            CustomTextField(controller: imageC, label: 'Image URL'),
            CustomTextField(controller: categoryC, label: 'Category'),
            CustomTextField(controller: skuC, label: 'SKU'),
            CustomTextField(
              controller: weightC,
              label: 'Weight',
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              controller: lengthC,
              label: 'Length',
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
                controller: heigthC,
                label: 'Height',
                keyboardType: TextInputType.number),
            CustomTextField(
                controller: widthC,
                label: 'Width',
                keyboardType: TextInputType.number),
            CustomTextField(
                controller: priceC,
                label: 'Price (Rp)',
                keyboardType: TextInputType.number),
            CustomTextField(controller: descC, label: 'Description'),
            const SpaceHeight(30),
            BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is ProductErrorState) {
                  if (state.type == ErrorType.update) {
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
                } else if (state is ProductUpdateState) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SuccessPage(
                          title: 'Product Success Update',
                          nextPage: ListProductPage(),
                        ),
                      ),
                      (route) => false);
                }
              },
              builder: (context, state) {
                if (state is ProductLoadingState) {
                  if (state.type == LoadingType.update) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primary,
                      ),
                    );
                  }
                }
                return Button.filled(
                  onPressed: () {
                    Product product = Product(
                      idPrimary: widget.product.idPrimary,
                      category: categoryC.text,
                      name: nameC.text,
                      price: int.parse(
                        priceC.text,
                      ),
                      id: Random().nextInt(1000),
                      description: descC.text,
                      sku: skuC.text,
                      weight: int.parse(weightC.text),
                      width: int.parse(widthC.text),
                      height: int.parse(heigthC.text),
                      length: int.parse(lengthC.text),
                      image: imageC.text,
                    );
                    context
                        .read<ProductBloc>()
                        .add(UpdateProductEvent(product));
                  },
                  label: 'Update Product',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

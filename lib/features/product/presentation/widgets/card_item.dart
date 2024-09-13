import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/color_manager.dart';
import '../../../../core/constants/font_manager.dart';
import '../../../../core/constants/style_manager.dart';
import '../../domain/entities/product.dart';
import 'package:intl/intl.dart';

class CardItem extends StatelessWidget {
  final Product product;

  final Function() onTap;
  CardItem({super.key, required this.product, required this.onTap});
  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff9E9E9E).withOpacity(0.4),
              offset: const Offset(0, 15),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            SpaceWidth(16.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: getTextStyle(
                    FontSizeManager.f14,
                    FontFamilyConstant.fontFamily,
                    FontWeight.bold,
                    ColorManager.blackC,
                  ),
                ),
                Container(
                  // ignore: prefer_const_constructors
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorManager.primary.withOpacity(0.4),
                  ),
                  child: Text(
                    product.category,
                    style: getTextStyle(
                      FontSizeManager.f12,
                      FontFamilyConstant.fontFamily,
                      FontWeight.normal,
                      ColorManager.blackC,
                    ),
                  ),
                ),
                Text(
                  formatter.format(product.price),
                  style: getTextStyle(
                    FontSizeManager.f14,
                    FontFamilyConstant.fontFamily,
                    FontWeight.normal,
                    ColorManager.blackC,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/color_manager.dart';

import '../../../../core/constants/font_manager.dart';
import '../../../../core/constants/style_manager.dart';

class CardTotal extends StatelessWidget {
  final String svgUrl;
  final String description;
  final String quantity;
  final Color colorTop;

  final Color colorBottom;

  const CardTotal({
    super.key,
    required this.svgUrl,
    required this.description,
    required this.colorTop,
    required this.colorBottom,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorTop,
            colorBottom,
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                svgUrl,
                fit: BoxFit.cover,
                width: 32,
              ),
              const SpaceWidth(6),
              Text(
                quantity,
                style: getTextStyle(
                  FontSizeManager.f20,
                  FontFamilyConstant.fontFamily,
                  FontWeightManager.semiBold,
                  ColorManager.whiteC,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 17,
          ),
          Text(
            description,
            style: getTextStyle(
              FontSizeManager.f16,
              FontFamilyConstant.fontFamily,
              FontWeightManager.semiBold,
              ColorManager.whiteC,
            ),
          ),
        ],
      ),
    );
  }
}

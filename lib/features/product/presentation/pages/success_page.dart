import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/spaces.dart';
import '../bloc/product_bloc.dart';

import '../../../../core/components/buttons.dart';
import '../../../../core/constants/color_manager.dart';
import '../../../../core/constants/font_manager.dart';
import '../../../../core/constants/style_manager.dart';

class SuccessPage extends StatelessWidget {
  final String title;
  final Widget nextPage;
  const SuccessPage({super.key, required this.title, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/success.png'),
            const SpaceHeight(20),
            Text(
              title,
              style: getTextStyle(
                FontSizeManager.f18,
                FontFamilyConstant.fontFamily,
                FontWeightManager.semiBold,
                ColorManager.greyC,
              ),
            ),
            const SpaceHeight(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Button.filled(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => nextPage),
                      (route) => false);
                  context.read<ProductBloc>().add(GetAllProductEvents());
                },
                label: 'Back',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

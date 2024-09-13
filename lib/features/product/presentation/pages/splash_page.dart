import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'list_product_page.dart';
import '../../../../core/constants/color_manager.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteC,
      body: FutureBuilder(
          future: Future.delayed(
            const Duration(seconds: 2),
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // Navigate to the next page after 2 seconds
              Future.microtask(
                () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListProductPage(),
                  ), // Replace NextPage with your page
                ),
              );
            }
            return Center(
              child: Image.asset(
                'assets/images/klontong_logo.png',
                width:
                    (MediaQuery.of(context).orientation == Orientation.portrait)
                        ? 200.w
                        : 200.h,
              ),
            );
          }),
    );
  }
}

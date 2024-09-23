import 'package:flutter/material.dart';
import 'package:tikar/utils/app_asset.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/utils/app_navigator.dart';
import 'package:tikar/views/desktop/auth/auth.dart';
import 'package:tikar/utils/local_cache_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DesktopBoarding extends StatefulWidget {
  const DesktopBoarding({Key? key}) : super(key: key);

  @override
  State<DesktopBoarding> createState() => _DesktopBoardingState();
}

class _DesktopBoardingState extends State<DesktopBoarding> {
  int _currentPage = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade700,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              PageView(
                onPageChanged: (value) => setState(() => _currentPage = value),
                controller: _pageController,
                children: [
                  landingPage(constraints, AppImage.onboard1,
                      AppStrings.boarding1[0], AppStrings.boarding1[1]),
                  landingPage(constraints, AppImage.onboard2,
                      AppStrings.boarding2[0], AppStrings.boarding2[1]),
                  landingPage(constraints, AppImage.onboard3,
                      AppStrings.boarding3[0], AppStrings.boarding3[1],
                      button: button(context, constraints)),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: constraints.maxHeight * 0.05),
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    onDotClicked: (index) => _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                  ),
                ),
              ),
              if (_currentPage > 0)
                Positioned(
                  left: 20,
                  top: constraints.maxHeight / 2,
                  child: IconButton(
                    icon: const Icon(Icons.chevron_left, color: Colors.white),
                    iconSize: 48,
                    onPressed: () => _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    ),
                  ),
                ),
              if (_currentPage < 2)
                Positioned(
                  right: 20,
                  top: constraints.maxHeight / 2,
                  child: IconButton(
                    icon: const Icon(Icons.chevron_right, color: Colors.white),
                    iconSize: 48,
                    onPressed: () => _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget landingPage(
      BoxConstraints constraints, String asset, String title, String text,
      {Widget? button}) {
    double contentWidth = constraints.maxWidth * 0.8;
    double imageSize = constraints.maxHeight * 0.4;

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: constraints.maxHeight * 0.05),
              SizedBox(
                height: imageSize * 0.5,
                child: Image.asset(AppImage.tikar, fit: BoxFit.contain),
              ),
              SizedBox(
                height: imageSize,
                child: Image.asset(asset, fit: BoxFit.contain),
              ),
              SizedBox(height: constraints.maxHeight * 0.05),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  fontSize: constraints.maxWidth * 0.02,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: constraints.maxHeight * 0.02),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontSize: constraints.maxWidth * 0.015,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: constraints.maxHeight * 0.05),
              if (button != null) button,
              SizedBox(height: constraints.maxHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Widget button(BuildContext context, BoxConstraints constraints) {
    return ElevatedButton(
      onPressed: () {
        LocalCacheManager.setFlag(name: "onboarding_finished", value: true);
        AppNavigator.push(context, destination: const Auth());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blue,
        minimumSize: Size(
          constraints.maxWidth * 0.2,
          constraints.maxHeight * 0.06,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        'Commencer',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: constraints.maxWidth * 0.015,
        ),
      ),
    );
  }
}

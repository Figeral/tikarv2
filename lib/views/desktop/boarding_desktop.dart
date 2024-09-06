import 'package:flutter/material.dart';
import 'package:tikar/utils/app_asset.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/utils/app_navigator.dart';
import 'package:tikar/views/desktop/auth/auth.dart';
import 'package:tikar/utils/local_cache_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DesktopBoarding extends StatefulWidget {
  const DesktopBoarding({super.key});

  @override
  State<DesktopBoarding> createState() => _DesktopBoardingState();
}

class _DesktopBoardingState extends State<DesktopBoarding> {
  int _currentpage = 0;
  final _pageController = PageController();
  bool leftTap = false;
  bool rightTap = true;
  @override
  Widget build(BuildContext context) {
    final sWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.purple.shade700,
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) => setState(() => _currentpage = value),
            controller: _pageController,
            children: [
              landingPages(AppImage.onboard1, AppStrings.boarding1[0],
                  AppStrings.boarding1[1]),
              landingPages(AppImage.onboard2, AppStrings.boarding2[0],
                  AppStrings.boarding2[1]),
              landingPages(AppImage.onboard3, AppStrings.boarding3[0],
                  AppStrings.boarding3[1],
                  button: button(context, sWidth))
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.80),
            child: SmoothPageIndicator(
              controller: _pageController, count: 3,
              onDotClicked: (int toPageIndex) {
                if (toPageIndex.toInt() == 1) {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                } else {
                  _pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                }
              },
              // axisDirection:,
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: _currentpage > 0 ? true : false,
                      child: Container(
                        alignment: const Alignment(-1, -0.0),
                        child: IconButton(
                            iconSize: 200,
                            onPressed: () {
                              setState(() {
                                _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                                // leftTap = false;
                                // rightTap = true;
                              });
                            },
                            icon: const Icon(
                              Icons.keyboard_double_arrow_left_outlined,
                              color: Colors.black38,
                            )),
                      ),
                    ),
                    SizedBox(width: sWidth * 0.75),
                    Visibility(
                      visible: _currentpage < 2 ? true : false,
                      child: Container(
                        alignment: const Alignment(1, -0.0),
                        child: IconButton(
                          iconSize: 200,
                          onPressed: () {
                            setState(() {
                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            });
                          },
                          icon: const Icon(
                            Icons.keyboard_double_arrow_right,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

ElevatedButton button(BuildContext context, double sWidth) {
  return ElevatedButton(
    onPressed: () {
      LocalCacheManager.setFlag(name: "onboarding_finished", value: true);
      AppNavigator.push(context, destination: const Auth());
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.blue,
      minimumSize: Size(
        sWidth * 0.25,
        60.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    child: const Text(
      'Commencer',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20,
      ),
    ),
  );
}

Widget landingPages(String asset, String title, String text,
    {ElevatedButton? button, double? width}) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Container(
          alignment: const Alignment(0, -1),
          child: const SizedBox(
            height: 290,
            width: 400,
            child: Image(
              image: AssetImage(AppImage.tikar),
            ),
          ),
        ),
        Container(
          alignment: const Alignment(0, -0.0),
          child: SizedBox(
            height: 400,
            width: 400,
            child: Image(
              image: AssetImage(asset),
            ),
          ),
        ),
        Container(
          alignment: const Alignment(0, 0.5),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                    fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                text,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    fontSize: 19),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        button ?? const SizedBox(),
      ],
    ),
  );
}

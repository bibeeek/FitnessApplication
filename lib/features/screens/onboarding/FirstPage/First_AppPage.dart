import 'package:flutter/material.dart'
    '';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';

import '../../../controllers_onboarding/onboarding_controller.dart';
import '../../widget/onboarding_dot_navigation.dart';
import '../../widget/onboarding_next.dart';
import '../../widget/onboarding_page.dart';
import '../../widget/onboarding_skip.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: "assets/try2.png",
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),

              OnBoardingPage(
                image: "assets/girlboy.png",
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),

              OnBoardingPage(
                image: "assets/girl.png",
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          // Skip Button
          const OnBoardingSkip(),

          // Dot Navigation SmotthPageIndicator
          const OnBoardingDotNavigation(),

          // Circular Button
          OnBoardingNext(),
        ],
      ),
    );
  }
}

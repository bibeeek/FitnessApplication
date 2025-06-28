import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

import '../../../utils/device/device_utility.dart';
import '../../controllers_onboarding/onboarding_controller.dart';

class OnBoardingNext extends StatelessWidget {
  const OnBoardingNext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),

      child: ElevatedButton(
        onPressed: ()=> OnboardingController.instance.nextPage(),

        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
          backgroundColor:  Color.fromRGBO(0, 130, 83, 1.0),),
        child: const Icon(Iconsax.arrow_right_3,color: Colors.white),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../LoginRegs/LoginPage.dart';

class OnboardingController extends GetxController{
  static OnboardingController get instance => Get.find();

// Variable
  final pageController = PageController();
   Rx<int> currentPageIndex = 0.obs;

// Update Current Index when Page Scroll
  void updatePageIndicator(index)=> currentPageIndex.value = index;

  // Jump to specific dot selected page.
  void dotNavigationClick(index){
    currentPageIndex.value =index;
    pageController.jumpToPage(index);
  }

  // Update Current Index and jump to next page
  void nextPage() {

    if (currentPageIndex.value == 2) {
      Get.to(LoginPage());
    }else{
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
      pageController.animateToPage(
        page,
        duration:
        const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  // Update Current Index and jump to previous page

  void skipPage(){
    currentPageIndex.value = 1;
    pageController.jumpToPage(2);
  }

}
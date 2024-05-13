import 'package:flutter/cupertino.dart';

class MyAnimation {
  static bool isAnimating = false;
  static AnimationController? animationcontroller;

  static void startAnimation() {
    if (!isAnimating) {
      isAnimating = true;
      animationcontroller!.forward(from: 0);
    }
  }

  static void stopAnimation() {
    if (isAnimating) {
      animationcontroller!.stop();
      isAnimating = false;
    }
  }
}

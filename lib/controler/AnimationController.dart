import 'package:get/get.dart';
class AnimationControl extends GetxController {
  // Observable boolean for animation
  var isAnimated = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Delaying the animation trigger
    Future.delayed(Duration(milliseconds: 500), () {
      isAnimated.value = true;
    });
  }
}


import 'package:get/get.dart';


class HomePageController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxBool isExpanded = false.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}

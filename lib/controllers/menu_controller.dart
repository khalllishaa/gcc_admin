import 'package:get/get.dart';

class MainMenuController extends GetxController{
  var selectedIndex = 0.obs;
  var username = Rxn<String>(); // Allows null-safe Rx value

  var selectedDate = DateTime.now().obs;

  void updateIndex(int index) {
    if (index != selectedIndex.value) {
      selectedIndex.value = index;
    }
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

}
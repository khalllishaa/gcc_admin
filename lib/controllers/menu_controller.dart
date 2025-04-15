import 'package:get/get.dart';

class MainMenuController extends GetxController{
  var selectedIndex = 0.obs;
  var username = Rxn<String>(); // Allows null-safe Rx value

  var selectedDate = DateTime.now().obs;

  void updateIndex(int index) {
    if (index != selectedIndex.value) {
      selectedIndex.value = index; // Update only if the index changes
    }
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  // Future<void> fetchSharedData() async {
  //   final sharedPreferences = await SharedPreferences.getInstance();
  //   print("shared data "+sharedPreferences.getString('username').toString());
  //   username.value = sharedPreferences.getString('username')!;
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

}
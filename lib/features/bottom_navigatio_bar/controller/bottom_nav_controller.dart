import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../fav_list_screen/fav_list_screen.dart';
import '../../to_do_screen/to_do_screen.dart';

class BottomNavController extends GetxController {
  RxInt currentIndex = 0.obs;

  List<Widget> get screen => _screen;

  final List<Widget> _screen = [ToDoScreen(), FavListScreen()];

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  void nextScreen() {
    if (currentIndex.value <= _screen.length - 1) {}
    currentIndex++;
  }

  void previousScreen() {
    if (currentIndex.value > 0) {
      currentIndex--;
    }
  }
}

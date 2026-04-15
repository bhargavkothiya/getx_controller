import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/todo_item.dart';

class ToDoController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  RxDouble opacity = 0.0.obs;
  RxList<TodoItem> itemList = <TodoItem>[].obs;

  List<TodoItem> get favList => itemList.where((e) => e.isFav.value).toList();

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  void setOpticity(double value) {
    opacity.value = value;
  }

  void onDeleteItem(TodoItem item) {
    itemList.remove(item);
    Get.snackbar(item.title, "$item deleted from the list");
  }

  void addToList(String item) {
    final text = item.trim();
    if (text.isEmpty) return;

    if (itemList.any((e) => e.title == text)) {
      Get.snackbar(
        "Error",
        "Already Exist in list",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      itemList.add(TodoItem(text));
    }
    nameController.clear();
  }

  void toggleItem(TodoItem item) {
    item.isFav.toggle();
  }
}

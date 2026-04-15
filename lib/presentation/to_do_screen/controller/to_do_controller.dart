import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/todo_item.dart';

class ToDoController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  RxDouble opacity = 0.0.obs;
  RxList<TodoItem> itemList = <TodoItem>[].obs;

  List<TodoItem> get favList => itemList.where((e) => e.isFav == true).toList();

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
    Get.snackbar(item.title!, "$item deleted from the list");
  }

  void addToList(String item) {
    final text = item.trim();
    if (text.isEmpty) return;

    if (itemList.any((e) => e.title == text)) {
      Get.snackbar(
        "Error",
        "Already Exist in the list",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      itemList.add(TodoItem(title: text));
    }
    nameController.clear();
  }

  void toggleItem(TodoItem item) {
    item.isFav = !item.isFav!;
    itemList.refresh();
    print(itemList.where((p0) => p0.isFav == true));
  }
}

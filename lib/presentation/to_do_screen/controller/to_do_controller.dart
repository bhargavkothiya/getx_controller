import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/model/todo_item.dart';

class ToDoController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  RxString searchQuery = "".obs;
  RxDouble opacity = 0.0.obs;
  RxList<ToDoItem> itemList = <ToDoItem>[].obs;

  List<ToDoItem> get favList => itemList.where((e) => e.isFav == true).toList();

  @override
  void onClose() {
    nameController.dispose();
    searchController.dispose();
    super.onClose();
  }

  List<ToDoItem> get filteredList {
    if (searchQuery.isEmpty) {
      return itemList;
    }
    return itemList
        .where(
          (e) => (e.title ?? "").toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ),
        )
        .toList();
  }

  void setOpticity(double value) {
    opacity.value = value;
  }

  void updateItem(ToDoItem item, String newTitle) {
    final index = itemList.indexOf(item);
    if (index != -1) {
      itemList[index].title = newTitle;
      itemList.refresh();
    }
  }

  void onDeleteItem(ToDoItem item) {
    itemList.remove(item);
    Get.snackbar(item.title ?? "", "$item deleted from the list");
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
      itemList.add(ToDoItem(title: text));
    }
    nameController.clear();
  }

  void toggleItem(ToDoItem item) {
    item.isFav = !(item.isFav ?? false);
    itemList.refresh();
    print(itemList.where((p0) => p0.isFav == true));
  }
}

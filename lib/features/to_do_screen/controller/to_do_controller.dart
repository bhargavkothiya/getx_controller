import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../data/model/todo_item.dart';

enum TaskFilter { all, active, completed }

class ToDoController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  RxString searchQuery = "".obs;
  RxDouble opacity = 0.0.obs;
  RxList<ToDoItem> itemList = <ToDoItem>[].obs;
  Rx<TaskFilter> currentFilter = TaskFilter.all.obs;
  final Box<ToDoItem> todoBox = Hive.box<ToDoItem>('todo_box');

  List<ToDoItem> get favList => itemList.where((e) => e.isFav == true).toList();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadTasks();
  }

  void loadTasks() {
    itemList.assignAll(todoBox.values.toList());
  }

  @override
  void onClose() {
    nameController.dispose();
    searchController.dispose();
    super.onClose();
  }

  void isDoneToggle(ToDoItem item) {
    item.isDone = !(item.isDone ?? false);
    item.save();
    itemList.refresh();
  }

  List<ToDoItem> get filteredList {
    var listAfterSearch = itemList.where((e) {
      return e.title!.toLowerCase().contains(searchQuery.value.toLowerCase());
    }).toList();

    switch (currentFilter.value) {
      case TaskFilter.active:
        return listAfterSearch.where((e) => e.isDone == false).toList();
      case TaskFilter.completed:
        return listAfterSearch.where((e) => e.isDone == true).toList();
      case TaskFilter.all:
      default:
        return listAfterSearch;
    }
  }

  void setOpticity(double value) {
    opacity.value = value;
  }

  void updateItem(ToDoItem item, String newTitle) {
    final index = itemList.indexOf(item);
    if (index != -1) {
      itemList[index].title = newTitle;
      item.save();
      itemList.refresh();
    }
  }

  void onDeleteItem(ToDoItem item) {
    itemList.remove(item);
    // Get.snackbar(item.title ?? "", "$item deleted from the list");
    item.delete();
  }

  void addToList(String name) {
    final text = name.trim();
    if (text.isEmpty) return;

    if (itemList.any((e) => e.title == text)) {
      Get.snackbar(
        text,
        "Already Exist in the list",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      final newItem = ToDoItem(title: name);
      itemList.add(newItem);
      todoBox.add(newItem);
      Get.snackbar(
        text,
        "Added to the list",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    nameController.clear();
  }

  void toggleFav(ToDoItem item) {
    item.isFav = !(item.isFav ?? false);
    item.save();
    itemList.refresh();
    print(itemList.where((p0) => p0.isFav == true));
  }
}

import 'package:demo_project/data/model/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/to_do_controller.dart';

void showEditDialog(BuildContext context, ToDoItem item) {
  final ToDoController toDoController = Get.find();
  final TextEditingController editController = TextEditingController(
    text: item.title,
  );

  Get.defaultDialog(
    title: "Edit Task",
    content: TextField(
      controller: editController,
      decoration: InputDecoration(hintText: "Enter new title"),
    ),
    textConfirm: "Update",
    onCancel: () {
      Get.back();
      FocusManager.instance.primaryFocus?.unfocus();
    },
    textCancel: "Cancel",
    onConfirm: () {
      if (editController.text.trim().isNotEmpty) {
        toDoController.updateItem(item, editController.text.trim());
        Get.back();
        FocusManager.instance.primaryFocus?.unfocus();
      }
    },
  );
}

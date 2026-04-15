import 'package:demo_project/presentation/to_do_screen/controller/to_do_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget searchField({required ToDoController controller}) {
  return Obx(
    () => TextField(
      controller: controller.searchController,
      decoration: InputDecoration(
        suffixIcon: controller.searchQuery.value.isEmpty
            ? null
            : IconButton(
                onPressed: () {
                  controller.searchQuery.value = "";
                  controller.searchController.clear();
                },
                icon: Icon(Icons.close),
              ),
        hintText: "Search Your task...",
        focusedBorder: UnderlineInputBorder(),
      ),
      onChanged: (value) {
        controller.searchQuery.value = value;
      },
    ),
  );
}

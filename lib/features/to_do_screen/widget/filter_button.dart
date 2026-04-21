import 'package:demo_project/features/to_do_screen/controller/to_do_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget filterButtons({required ToDoController controller}) {
  return Obx(
    () => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // All Button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: controller.currentFilter.value == TaskFilter.all
                ? Colors.blue
                : Colors.grey[300],
          ),
          onPressed: () => controller.currentFilter.value = TaskFilter.all,
          child: const Text("All"),
        ),

        // Completed Button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                controller.currentFilter.value == TaskFilter.completed
                ? Colors.blue
                : Colors.grey[300],
          ),
          onPressed: () =>
              controller.currentFilter.value = TaskFilter.completed,
          child: const Text("Completed"),
        ),

        // Active Button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: controller.currentFilter.value == TaskFilter.active
                ? Colors.blue
                : Colors.grey[300],
          ),
          onPressed: () => controller.currentFilter.value = TaskFilter.active,
          child: const Text("Active"),
        ),
      ],
    ),
  );
}

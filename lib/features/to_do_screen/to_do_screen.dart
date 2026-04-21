import 'package:demo_project/features/to_do_screen/controller/to_do_controller.dart';
import 'package:demo_project/features/to_do_screen/widget/add_item_field.dart';
import 'package:demo_project/features/to_do_screen/widget/edit_box_dialog_box.dart';
import 'package:demo_project/features/to_do_screen/widget/filter_button.dart';
import 'package:demo_project/features/to_do_screen/widget/search_field.dart';
import 'package:demo_project/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToDoScreen extends StatelessWidget {
  ToDoScreen({super.key});

  final ToDoController toDoController = Get.put(ToDoController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("To DO APP"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(AppRoutes.favScreen),
              icon: Icon(Icons.list_alt),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              searchField(controller: toDoController),
              SizedBox(height: Get.height * 0.05),
              filterButtons(controller: toDoController),
              SizedBox(height: Get.height * 0.05),
              addItemField(toDoController: toDoController),
              SizedBox(height: 5),
              Expanded(
                child: Obx(() {
                  print("Delete Item in fav list");
                  final items = toDoController.filteredList;
                  return items.isEmpty
                      ? Center(child: Text("Your List is Empty"))
                      : ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return Dismissible(
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              confirmDismiss: (direction) async {
                                return await Get.dialog<bool>(
                                      AlertDialog(
                                        title: const Text("Are you sure?"),
                                        content: const Text(
                                          "Do you really want to delete this task?",
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Get.back(result: false),
                                            // Swipe cancel karein
                                            child: const Text("No"),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Get.back(result: true),
                                            // Swipe allow karein
                                            child: const Text("Yes"),
                                          ),
                                        ],
                                      ),
                                    ) ??
                                    false;
                              },
                              onDismissed: (direction) {
                                toDoController.onDeleteItem(item);
                              },

                              key: ValueKey(item),
                              child: ListTile(
                                key: ValueKey(item),
                                leading: Checkbox(
                                  value: item.isDone ?? false,
                                  onChanged: (value) {
                                    toDoController.isDoneToggle(item);
                                  },
                                ),
                                title: Text(item.title ?? ""),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        toDoController.toggleFav(item);
                                      },
                                      icon: Icon(Icons.favorite_rounded),
                                      color: item.isFav ?? false
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showEditDialog(context, item);
                                      },
                                      icon: Icon(Icons.edit),
                                      color: Colors.black87,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:demo_project/presentation/to_do_screen/controller/to_do_controller.dart';
import 'package:demo_project/presentation/to_do_screen/widget/add_item_field.dart';
import 'package:demo_project/presentation/to_do_screen/widget/search_field.dart';
import 'package:demo_project/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToDoScreen extends StatelessWidget {
  ToDoScreen({super.key});

  final ToDoController toDoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Obx(() => searchField(controller: toDoController)),
            SizedBox(height: Get.height * 0.05),
            addItemField(toDoController: toDoController),
            SizedBox(height: 5),
            Expanded(
              child: Obx(() {
                print("Delete Item in fav list");
                final items = toDoController.filteredList;
                return items.length == 0
                    ? Center(child: Text("Your List is Empty"))
                    : ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return ListTile(
                            key: ValueKey(item),
                            leading: Text("${index + 1}"),
                            title: Text(item.title ?? ""),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    toDoController.toggleItem(item);
                                  },
                                  icon: Icon(Icons.favorite_rounded),
                                  color: item.isFav ?? false
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () =>
                                      toDoController.onDeleteItem(item),
                                  child: Icon(Icons.delete, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        },
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

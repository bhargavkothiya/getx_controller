import 'package:demo_project/presentation/to_do_screen/controller/to_do_controller.dart';
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
            TextField(
              controller: toDoController.nameController,
              decoration: InputDecoration(
                focusColor: Colors.transparent,
                contentPadding: EdgeInsets.only(left: 20),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final item = toDoController.nameController.text.trim();
                if (item.isNotEmpty) {
                  toDoController.addToList(item);
                }
              },
              child: Text("Add to list"),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Obx(() {
                print("Delete Item in fav list");
                final items = toDoController.itemList;
                return items.length == 0
                    ? Center(child: Text("Your List is Empty"))
                    : ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return ListTile(
                            key: ValueKey(item),
                            leading: Text("${index + 1}"),
                            title: Text(item.title),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(() {
                                  print("Add Item in fav list");
                                  return IconButton(
                                    onPressed: () {
                                      toDoController.toggleItem(item);
                                    },
                                    icon: Icon(Icons.favorite_rounded),
                                    color: item.isFav.value
                                        ? Colors.red
                                        : Colors.grey,
                                  );
                                }),
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

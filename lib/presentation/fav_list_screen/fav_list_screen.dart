import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../to_do_screen/controller/to_do_controller.dart';

class FavListScreen extends StatelessWidget {
  const FavListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ToDoController toDoController = Get.find();
    return Scaffold(
      appBar: AppBar(title: Text("Favourite List")),
      body: Obx(() {
        final favList = toDoController.favList.toList();
        return ListView.builder(
          itemCount: favList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final item = favList[index];
            return ListTile(
              leading: Text("${index + 1}"),
              title: Text(item.title),
            );
          },
        );
      }),
    );
  }
}

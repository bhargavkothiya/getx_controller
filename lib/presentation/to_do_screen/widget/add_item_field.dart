import 'package:demo_project/presentation/to_do_screen/controller/to_do_controller.dart';
import 'package:flutter/material.dart';

Widget addItemField({required ToDoController toDoController}) {
  return Row(
    children: [
      Flexible(
        flex: 4,
        child: TextField(
          controller: toDoController.nameController,
          decoration: InputDecoration(
            focusColor: Colors.transparent,
            contentPadding: EdgeInsets.only(left: 20),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
      ),
      SizedBox(width: 5),
      Flexible(
        flex: 2,
        child: ElevatedButton(
          onPressed: () {
            final item = toDoController.nameController.text.trim();
            if (item.isNotEmpty) {
              toDoController.addToList(item);
            }
          },
          child: Text("Add to list"),
        ),
      ),
    ],
  );
}

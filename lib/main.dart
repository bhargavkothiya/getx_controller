import 'package:demo_project/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/model/todo_item.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoItemAdapter());
  await Hive.openBox<ToDoItem>("todo_box");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.bottomNav,
      getPages: AppRoutes.routes,
      title: 'Flutter Demo',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black38),
      ),
    );
  }
}

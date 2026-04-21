import 'package:demo_project/features/auth/controller/auth_controller.dart';
import 'package:demo_project/routes/app_routes.dart';
import 'package:demo_project/service/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/model/todo_item.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.initialize();
  Get.put(AuthController());
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
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.routes,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black38),
      ),
    );
  }
}

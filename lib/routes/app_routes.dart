import 'package:demo_project/presentation/fav_list_screen/fav_list_screen.dart';
import 'package:get/get.dart';

import '../presentation/Bindings/bindings.dart';
import '../presentation/to_do_screen/to_do_screen.dart';

class AppRoutes {
  static const String toDoScreen = '/toDoScreen';
  static const String favScreen = '/fav';

  static final List<GetPage<dynamic>> routes = [
    GetPage(name: toDoScreen, page: () => ToDoScreen(), binding: ToDoBinding()),
    GetPage(name: favScreen, page: () => FavListScreen()),
  ];
}

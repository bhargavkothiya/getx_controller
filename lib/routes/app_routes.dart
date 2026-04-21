import 'package:demo_project/features/auth/presentation/login_screen.dart';
import 'package:demo_project/features/bottom_navigatio_bar/presentation/bottom_nav_screen.dart';
import 'package:demo_project/features/fav_list_screen/fav_list_screen.dart';
import 'package:demo_project/features/to_do_screen/to_do_screen.dart';
import 'package:get/get.dart';

import '../presentation/Bindings/bindings.dart';

class AppRoutes {
  static const String toDoScreen = '/toDoScreen';
  static const String favScreen = '/fav';
  static const String bottomNavScreen = '/bottomNavScreen';
  static const String login = '/loginScreen';

  static final List<GetPage<dynamic>> routes = [
    GetPage(name: toDoScreen, page: () => ToDoScreen(), binding: ToDoBinding()),
    GetPage(name: favScreen, page: () => FavListScreen()),
    GetPage(name: bottomNavScreen, page: () => BottomNavScreen()),
    GetPage(name: login, page: () => LoginScreen()),
  ];
}

import 'package:get/get.dart';

class TodoItem {
  final String title;
  RxBool isFav = false.obs;

  TodoItem(this.title);
}

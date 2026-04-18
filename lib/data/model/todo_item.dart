import 'package:hive/hive.dart';

part 'todo_item.g.dart';

@HiveType(typeId: 0)
class ToDoItem extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  bool? isFav;
  @HiveField(2)
  bool? isDone;

  ToDoItem({this.title, this.isFav = false, this.isDone = false});

  @override
  String toString() {
    return title ?? "";
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "isFav": isFav ?? false, "isDone": isDone ?? false};
  }

  factory ToDoItem.fromJson(Map<String, dynamic> json) {
    return ToDoItem(title: json["title"], isFav: json["isFav"]);
  }
}

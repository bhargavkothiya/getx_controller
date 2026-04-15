class ToDoItem {
  String? title;
  bool? isFav;
  bool? isDone;

  ToDoItem({this.title, this.isFav, this.isDone});

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

class ToDoItem {
  String? title;
  bool? isFav;

  ToDoItem({this.title, this.isFav});

  @override
  String toString() {
    return title ?? "";
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "isFav": isFav};
  }

  factory ToDoItem.fromJson(Map<String, dynamic> json) {
    return ToDoItem(title: json["title"], isFav: json["isFav"]);
  }
}

class TodoItem {
  String? title;
  bool? isFav;

  TodoItem({this.title, this.isFav});

  @override
  String toString() {
    return title ?? "";
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "isFav": isFav};
  }

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(title: json["title"], isFav: json["isFav"]);
  }
}

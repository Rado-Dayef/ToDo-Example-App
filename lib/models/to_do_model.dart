class ToDoModel {
  int id;
  bool isDone;
  String title;
  String description;

  ToDoModel(
    this.id, {
    required this.title,
    required this.isDone,
    required this.description,
  });

  String get asString => "ToDoModel(id: $id, title: $title, isDone: $isDone, description: $description)";

  void updateToDo({
    required bool isDone,
    required String title,
    required String description,
  }) {
    this.title = title;
    this.isDone = isDone;
    this.description = description;
  }

  static ToDoModel asToDo(Map<String, dynamic> map) {
    return ToDoModel(
      map["id"],
      title: map["title"],
      description: map["description"],
      isDone: map["isDone"] == 0 ? false : true,
    );
  }
}

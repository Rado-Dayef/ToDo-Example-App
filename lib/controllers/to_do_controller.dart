import 'package:flutter/material.dart';
import 'package:to_do/constants/db_helper.dart';
import 'package:to_do/models/to_do_model.dart';

class ToDoController {
  List<ToDoModel> toDos = [];
  final DBHelper _dbHelper = DBHelper();

  Future<void> getToDos() async {
    await _dbHelper.read("todo").then(
      (response) {
        toDos = response.map((toDo) => ToDoModel.asToDo(toDo)).toList();
      },
    );
  }

  void addToDo({
    required int isDone,
    required String title,
    required String description,
  }) {
    _dbHelper.create(
      "todo",
      data: {
        "title": title,
        "isDone": isDone,
        "description": description,
      },
    ).then(
      (response) {
        if (response >= 0) {
          toDos.add(
            ToDoModel(
              response,
              title: title,
              description: description,
              isDone: isDone == 0 ? false : true,
            ),
          );
        } else {
          debugPrint("Error");
        }
      },
    );
  }

  void updateToDo(
    int id, {
    required int isDone,
    required String title,
    required String description,
  }) {
    _dbHelper
        .update(
      "todo",
      data: {
        "title": title,
        "description": description,
        "isDone": isDone,
      },
      condition: "id = $id",
    )
        .then(
      (response) {
        if (response) {
          ToDoModel toDo = toDos.firstWhere((toDo) => toDo.id == id);
          toDo.updateToDo(
            title: title,
            description: description,
            isDone: isDone == 0 ? false : true,
          );
        } else {
          debugPrint("Error");
        }
      },
    );
  }

  void deleteToDo(int id) {
    _dbHelper
        .delete(
      "todo",
      condition: "id = $id",
    )
        .then(
      (response) {
        if (response) {
          toDos.removeWhere((toDo) => toDo.id == id);
        } else {
          debugPrint("Error");
        }
      },
    );
  }
}

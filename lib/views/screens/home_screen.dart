import 'package:flutter/material.dart';
import 'package:to_do/controllers/to_do_controller.dart';
import 'package:to_do/models/to_do_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ToDoController toDoController = ModalRoute.of(context)!.settings.arguments as ToDoController;
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: toDoController.toDos.length,
        itemBuilder: (_, int index) {
          ToDoModel toDo = toDoController.toDos[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text((index + 1).toString()),
            ),
            title: Text(toDo.title),
            subtitle: Text(toDo.description),
            trailing: InkWell(
              onTap: ()=> toDoController.deleteToDo(toDo.id),
              child: const Icon(Icons.delete),
            ),
          );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            height: 10,
          );
        },
      ),
      floatingActionButton: InkWell(
        onTap: () {},
        child: Container(
          height: 50,
          width: 50,
          color: Colors.blue,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

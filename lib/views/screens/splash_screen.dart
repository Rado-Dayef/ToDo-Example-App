import 'package:flutter/material.dart';
import 'package:to_do/controllers/to_do_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    ToDoController toDoController = ToDoController();
    toDoController.getToDos().then(
      (value) {
        Future.delayed(
          const Duration(seconds: 5),
          () {
            if (mounted) {
              Navigator.pushReplacementNamed(
                context,
                "/home",
                arguments: toDoController,
              );
            }
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

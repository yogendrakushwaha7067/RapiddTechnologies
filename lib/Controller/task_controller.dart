// task_controller.dart
import 'package:get/get.dart';

import '../Model/task_model.dart';

class TaskController extends GetxController {
  RxList<Task> tasks = <Task>[].obs;

  void addTask(Task task) {
    tasks.add(task);
  }

  void updateTask(Task updatedTask) {
    int index = tasks.indexWhere((task) => task.id == updatedTask.id);
    tasks[index] = updatedTask;
  }
}

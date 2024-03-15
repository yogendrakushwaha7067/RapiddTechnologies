

import 'package:get/get.dart';


import '../Model/todo_list_model.dart';
import '../Service/app_service.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;
  var isLoading = true.obs;
  var isLoading1 = true.obs;
  var page = 1.obs;
  var filteredTodos = <Todo>[].obs;


  @override
  void onInit() {
    fetchTodos();
    super.onInit();
  }

  void fetchTodos() async {
    try {
      isLoading(true);
      var todoList = await ApiService.fetchTodos(page.value);
      todos.addAll(todoList.map((todo) => Todo.fromJson(todo)));
      filteredTodos.assignAll(todos);
    } finally {
      isLoading(false);
    }
  }
  void fetchTodos1() async {

    try {
     // isLoading(true);
      var todoList = await ApiService.fetchTodos(page.value);
      todos.addAll(todoList.map((todo) => Todo.fromJson(todo)));
      filteredTodos.assignAll(todos);

      print(todos.length);
      print(page.value);

    } finally {
    //  isLoading(false);
    }
  }
  void loadMore() {
    page.value++;
    isLoading1(false);
    fetchTodos1();
    isLoading1(true);
  }
  void filterTodos(String query) {

    if (query.isEmpty) {
      filteredTodos.assignAll(todos);
    } else {
      filteredTodos.assignAll(todos.where((todo) =>
          todo.title.toLowerCase().contains(query.toLowerCase())));
    }

  }
}

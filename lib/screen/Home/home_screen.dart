
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../Controller/home_controller.dart';

class TodoListScreen extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        todoController.loadMore();
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value){
                todoController.filterTodos(value);
              },
              decoration: InputDecoration(
                hintText: 'Search by title...',

                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // todoController.filterTodos(searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (todoController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                controller: scrollController,
                itemCount: todoController.filteredTodos.length,
                itemBuilder: (context, index) {
                  if (index ==todoController.filteredTodos.length-1) {
                  return const Center(child: CircularProgressIndicator());
                  }
                  else{
                    final todo = todoController.filteredTodos[index];
                    return ListTile(
                      title: Text(todo.title),
                      subtitle: Text(todo.completed ? 'Completed' : 'Not Completed'),
                    );
                  }

                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

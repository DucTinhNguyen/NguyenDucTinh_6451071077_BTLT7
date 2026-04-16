import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TaskController controller = TaskController();

  List<Task> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    final data = await controller.getTasks();

    setState(() {
      tasks = data;
      isLoading = false;
    });
  }

  void deleteTask(int id) async {
    bool success = await controller.deleteTask(id);

    if (success) {
      setState(() {
        tasks.removeWhere((task) => task.id == id);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Xóa thành công')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Xóa thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Task List')),
      body: Column(
        children: [
          // 👉 MÃ SINH VIÊN
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              '6451071077',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                return ListTile(
                  title: Text(task.title),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteTask(task.id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
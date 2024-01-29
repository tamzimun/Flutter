import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'task_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      home: BlocProvider(
        create: (context) => TaskBloc(),
        child: TaskScreen(),
      ),
    );
  }
}

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);
    TextEditingController taskController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: taskController,
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: 'Enter task',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              taskBloc.add(AddTask(taskController.text));
              taskController.clear();
            },
            child: Text('Add Task'),
          ),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskInitial) {
                  return Center(
                    child: Text('No tasks yet.'),
                  );
                } else if (state is TaskLoaded) {
                  return ListView.separated(
                    itemCount: state.tasks.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.tasks[index]),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red, // Set delete icon color to red
                          ),
                          onPressed: () {
                            taskBloc.add(DeleteTask(index));
                          },
                        ),
                        leading: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue, // Set edit icon color to blue
                          ),
                          onPressed: () {
                            _editTask(context, taskBloc, index, state.tasks[index]);
                          },
                        ),
                      );
                    },
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _editTask(BuildContext context, TaskBloc taskBloc, int index, String task) {
    TextEditingController editedTaskController = TextEditingController(text: task);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            controller: editedTaskController,
            onChanged: (value) {},
            decoration: InputDecoration(
              hintText: 'Task Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                taskBloc.add(EditTask(index, editedTaskController.text));
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
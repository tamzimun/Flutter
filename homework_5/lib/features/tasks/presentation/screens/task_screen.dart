import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homework_5/features/tasks/blocs/task_bloc.dart';
import 'package:homework_5/features/tasks/data/localization/app_localizations.dart';
import 'package:homework_5/features/tasks/blocs/localization_bloc.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);
    TextEditingController taskController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appBarTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              _showLanguageDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: taskController,
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).enterTaskHint,
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
            child: Text(AppLocalizations.of(context).addButtonLabel),
          ),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskInitial) {
                  return Center(
                    child: Text(AppLocalizations.of(context).noTasksYet),
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
                            color: Colors.red,
                          ),
                          onPressed: () {
                            taskBloc.add(DeleteTask(index));
                          },
                        ),
                        leading: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
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

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).selectLanguageDialogTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text(AppLocalizations.of(context).englishLanguageOption),
                  onTap: () {
                    print("Changing language to English");
                    BlocProvider.of<LocalizationBloc>(context).add(
                      ChangeLocalization(locale: Locale('en', 'US')),
                    );
                    Navigator.of(context).pop();
                  },
                ),
                GestureDetector(
                  child: Text(AppLocalizations.of(context).russianLanguageOption),
                  onTap: () {
                    print("Changing language to Russian");
                    BlocProvider.of<LocalizationBloc>(context).add(
                      ChangeLocalization(locale: Locale('ru', 'RU')),
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _editTask(BuildContext context, TaskBloc taskBloc, int index, String task) {
    TextEditingController editingController = TextEditingController(text: task);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).editTaskDialogTitle),
          content: TextField(
            controller: editingController,
            decoration: InputDecoration(hintText: AppLocalizations.of(context).editTaskHint),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context).saveButtonLabel),
              onPressed: () {
                taskBloc.add(EditTask(index, editingController.text));
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context).cancelButtonLabel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
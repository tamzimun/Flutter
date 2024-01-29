import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Состояния для нашего BLoC
abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoaded extends TaskState {
  final List<String> tasks;

  const TaskLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}

// События для нашего BLoC
abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TaskEvent {
  final String task;

  const AddTask(this.task);

  @override
  List<Object> get props => [task];
}

class EditTask extends TaskEvent {
  final int index;
  final String editedTask;

  const EditTask(this.index, this.editedTask);

  @override
  List<Object> get props => [index, editedTask];
}

class DeleteTask extends TaskEvent {
  final int index;

  const DeleteTask(this.index);

  @override
  List<Object> get props => [index];
}

// BLoC для управления задачами
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  List<String> tasks = [];

  TaskBloc() : super(TaskInitial()); // Fix this line

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is AddTask) {
      tasks.add(event.task);
    } else if (event is EditTask) {
      tasks[event.index] = event.editedTask;
    } else if (event is DeleteTask) {
      tasks.removeAt(event.index);
    }

    yield TaskLoaded(List.from(tasks));
  }
}
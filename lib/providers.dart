import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models.dart';

const List<Task> tasksList = [
  Task(id: 0, title: 'task1', isDone: false),
  Task(id: 1, title: 'task2', isDone: false),
  Task(id: 2, title: 'task3', isDone: false),
];

final editProvider = StateProvider<bool>((ref) => false);

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier(): super(tasksList);

  void addTask(Task newTask) {
    List<Task> newState = [];
    for (final task in state){
      newState.add(task);
    }
    newState.add(newTask);
    state = newState;
  }

  void insertTask(Task newTask) {
    List<Task> newState = [];
    for (final task in state){
      newState.add(task);
    }
    newState.insert(0,newTask);
    state = newState;
  }

  void removeTask(int id) {
    List<Task> newState = [];
    for (final task in state){
      if(task.id != id){
        newState.add(task);
      }
    }
    state = newState;
  }

  void editTask(int id, String title) {
    List<Task> newState = [];
    for (final task in state) {
      if (task.id == id) {
        newState.add(task.copyWith(title: title));
      } else {
        newState.add(task);
      }
    }
    state = newState;
  }

  void toggleDone(int id){
    List<Task> newState = [];
    for (final task in state){
      if(task.id == id){
        newState.add(task.copyWith(isDone: !task.isDone));
      }else{
        newState.add(task);
      }
    }
    state = newState;
  }

  void dragAndDrop(int oldIndex, int newIndex) {
    List<Task> newState = [];
    for (final task in state) {
      newState.add(task);
    }
    final movedTask = newState.removeAt(oldIndex);
    final insertionIndex = newIndex > oldIndex ? newIndex - 1 : newIndex;
    newState.insert(insertionIndex, movedTask);
    state = newState;
  }

}

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});
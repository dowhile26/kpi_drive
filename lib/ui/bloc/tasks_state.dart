import 'package:kpi_drive/data/models/task.dart';

class TasksState {}

class TasksInitial extends TasksState {}

class TasksLoading extends TasksState {}

class TasksLoaded extends TasksState {
  final Map<int?, List<Task>> tasks;
  final List<int> sortedParentIds;
  final Map<int, String> parentNames;
  TasksLoaded({this.tasks = const {}, this.parentNames = const {}, this.sortedParentIds = const []});
}

class TasksError extends TasksState {}

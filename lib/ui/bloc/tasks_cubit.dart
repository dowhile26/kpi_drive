import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kpi_drive/core/service_locator.dart';
import 'package:kpi_drive/data/models/task.dart';
import 'package:kpi_drive/data/task_service.dart';
import 'package:kpi_drive/ui/bloc/tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());
  final _taskService = getIt<TaskService>();

  Future<void> fetchTasks() async {
    emit(TasksLoading());
    await _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final data = await _taskService.getTasks();
      emit(TasksLoaded(tasks: data.groupedTasks, parentNames: data.parentNames, sortedParentIds: data.sortedParentIds));
    } catch (e) {
      emit(TasksError());
    }
  }

  Future<void> updateTask({
    required int taskId,
    required int fromParentId,
    required int toParentId,
    required int fromIndex,
    required int toIndex,
  }) async {
    if (fromParentId == toParentId && fromIndex == toIndex) return;
    final state_ = state as TasksLoaded;
    final newTasks = Map<int?, List<Task>>.of(state_.tasks);
    if (fromParentId == toParentId && fromIndex < toIndex) {
      toIndex -= 1;
    }

    toIndex = toIndex.clamp(0, newTasks[toParentId]!.length);
    final newOrder = toIndex + 1;
    final task = newTasks[fromParentId]!.removeAt(fromIndex).copyWith(parentId: toParentId, order: newOrder);
    newTasks[toParentId]!.insert(toIndex, task);

    emit(TasksLoaded(tasks: newTasks, parentNames: state_.parentNames, sortedParentIds: state_.sortedParentIds));

    try {
      await _taskService.updateTask(taskId: taskId, parentId: toParentId, order: newOrder);
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Update failed',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        webPosition: "center",
        webBgColor: "#333333",
        timeInSecForIosWeb: 2,
      );
      await _fetchData();
    }
  }
}

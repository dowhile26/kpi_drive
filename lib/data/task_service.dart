import 'package:dio/dio.dart';
import 'package:kpi_drive/data/models/processed_tasks.dart';
import 'package:kpi_drive/data/models/task.dart';
import 'package:kpi_drive/data/models/task_list.dart';

class TaskService {
  final Dio dio;
  const TaskService(this.dio);

  Future<ProcessedTasks> getTasks() async {
    final formData = FormData.fromMap({
      'period_start': '2026-04-01',
      'period_end': '2026-04-30',
      'period_key': 'month',
      'requested_mo_id': 42,
      'behaviour_key': 'task,kpi_task',
      'with_result': false,
      'response_fields': 'name,indicator_to_mo_id,parent_id,parent_name,order',
      'auth_user_id': 40,
    });

    final response = await dio.post('indicators/get_mo_indicators', data: formData);
    if (response.data == null || response.data['DATA'] == null) {
      throw Exception('Invalid response format');
    }

    final tasks = TaskList.fromJson(response.data['DATA']);
    return groupTasks(tasks.taskList);
  }

  Future<void> updateTask({required int taskId, int? parentId, int? order}) async {
    final formData = FormData()
      ..fields.addAll([
        MapEntry('period_start', '2026-04-01'),
        MapEntry('period_end', '2026-04-30'),
        MapEntry('period_key', 'month'),
        MapEntry('auth_user_id', '40'),
        MapEntry('indicator_to_mo_id', taskId.toString()),
        if (parentId != null) ...[MapEntry('field_name', 'parent_id'), MapEntry('field_value', parentId.toString())],
        if (order != null) ...[MapEntry('field_name', 'order'), MapEntry('field_value', order.toString())],
      ]);

    await dio.post('indicators/save_indicator_instance_field', data: formData);
  }

  ProcessedTasks groupTasks(List<Task> tasks) {
    final Map<int, List<Task>> grouped = {};
    final Map<int, String> parentNames = {};

    for (final task in tasks) {
      parentNames[task.parentId] = task.parentName;
      grouped.putIfAbsent(task.parentId, () => []).add(task);
    }

    for (final entry in grouped.entries) {
      entry.value.sort((a, b) => a.order.compareTo(b.order));
    }

    return ProcessedTasks(
      groupedTasks: grouped,
      parentNames: parentNames,
      sortedParentIds: parentNames.keys.toList()..sort(),
    );
  }
}

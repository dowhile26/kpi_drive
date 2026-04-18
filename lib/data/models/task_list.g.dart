// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskList _$TaskListFromJson(Map<String, dynamic> json) => TaskList(
  rowsCount: (json['rows_count'] as num?)?.toInt() ?? 0,
  taskList:
      (json['rows'] as List<dynamic>?)
          ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$TaskListToJson(TaskList instance) => <String, dynamic>{
  'rows_count': instance.rowsCount,
  'rows': instance.taskList,
};

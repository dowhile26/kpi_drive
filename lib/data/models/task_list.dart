import 'package:json_annotation/json_annotation.dart';
import 'package:kpi_drive/data/models/task.dart';
part 'task_list.g.dart';

@JsonSerializable()
class TaskList {
  @JsonKey(name: 'rows_count')
  final int rowsCount;
  @JsonKey(name: 'rows')
  final List<Task> taskList;
  TaskList({this.rowsCount = 0, this.taskList = const []});

  factory TaskList.fromJson(Map<String, dynamic> json) => _$TaskListFromJson(json);
  Map<String, dynamic> toJson() => _$TaskListToJson(this);
}

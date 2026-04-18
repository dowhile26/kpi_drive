import 'package:kpi_drive/data/models/task.dart';

class DragData {
  final Task task;
  final int fromParentId;
  final int fromIndex;

  DragData({required this.task, required this.fromParentId, required this.fromIndex});
}

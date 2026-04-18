import 'package:kpi_drive/data/models/task.dart';

class ProcessedTasks {
  final Map<int, List<Task>> groupedTasks;
  final List<int> sortedParentIds;
  final Map<int, String> parentNames;

  ProcessedTasks({this.groupedTasks = const {}, this.parentNames = const {}, this.sortedParentIds = const []});
}

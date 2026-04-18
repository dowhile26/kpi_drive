import 'package:flutter/material.dart';
import 'package:kpi_drive/data/models/drag_data.dart';
import 'package:kpi_drive/data/models/task.dart';
import 'package:kpi_drive/ui/widgets/task_card.dart';

class DraggableTask extends StatelessWidget {
  final int parentId;
  final Task task;
  final int index;
  const DraggableTask({super.key, required this.parentId, required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    return Draggable<DragData>(
      data: DragData(task: task, fromParentId: parentId, fromIndex: index),
      feedback: Material(
        color: Colors.transparent,
        child: TaskCard(name: task.name),
      ),
      childWhenDragging: Opacity(opacity: 0.3, child: TaskCard(name: task.name)),
      child: TaskCard(name: task.name),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kpi_drive/data/models/task.dart';
import 'package:kpi_drive/ui/widgets/draggable_task.dart';
import 'package:kpi_drive/ui/widgets/drop_zone.dart';

class BoardColumn extends StatelessWidget {
  final int parentId;
  final List<Task> tasks;
  final String header;
  final List<int> sortedParentIds;
  const BoardColumn({
    super.key,
    required this.parentId,
    this.tasks = const [],
    this.header = '',
    this.sortedParentIds = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: const Color(0xFF1C1B1F), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Container(
            height: 80,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFF242329),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Text(
              header,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: DropZone(
                      toIndex: tasks.length,
                      toParentId: parentId,
                      onWillAcceptWithDetails: (details) {
                        return details.data.fromParentId == parentId
                            ? details.data.fromIndex != tasks.length - 1
                            : true;
                      },
                      margin: EdgeInsetsGeometry.zero,
                      height: double.infinity,
                    ),
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  shrinkWrap: true,
                  itemCount: tasks.length * 2,
                  itemBuilder: (context, index) {
                    final i = index ~/ 2;
                    return index % 2 == 0
                        ? DropZone(toParentId: parentId, toIndex: i, sortedParentIds: sortedParentIds)
                        : DraggableTask(
                            key: ValueKey(tasks[i].indicatorToMoId),
                            parentId: parentId,
                            task: tasks[i],
                            index: i,
                          );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpi_drive/data/models/drag_data.dart';
import 'package:kpi_drive/ui/bloc/tasks_cubit.dart';

class DropZone extends StatelessWidget {
  final int toParentId;
  final int toIndex;
  final List<int> sortedParentIds;
  final double? height;
  final EdgeInsetsGeometry margin;
  final bool Function(DragTargetDetails<DragData>)? onWillAcceptWithDetails;
  const DropZone({
    super.key,
    required this.toIndex,
    required this.toParentId,
    this.sortedParentIds = const [],
    this.height,
    this.margin = const EdgeInsets.symmetric(vertical: 4),
    this.onWillAcceptWithDetails,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<DragData>(
      onWillAcceptWithDetails:
          onWillAcceptWithDetails ??
          (dragData) {
            final isSameColumn = dragData.data.fromParentId == toParentId;
            if (isSameColumn && (dragData.data.fromIndex == toIndex || dragData.data.fromIndex + 1 == toIndex)) {
              return false;
            }
            return true;
          },
      onAcceptWithDetails: (dragData) {
        context.read<TasksCubit>().updateTask(
          taskId: dragData.data.task.indicatorToMoId,
          fromParentId: dragData.data.fromParentId,
          toParentId: toParentId,
          fromIndex: dragData.data.fromIndex,
          toIndex: toIndex,
        );
      },
      builder: (context, candidateData, rejectedData) {
        final isActive = candidateData.isNotEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: height ?? (isActive ? 50 : 8),
          margin: margin,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF1EBE17).withValues(alpha: 0.5) : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
        );
      },
    );
  }
}

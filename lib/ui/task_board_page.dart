import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpi_drive/ui/bloc/tasks_cubit.dart';
import 'package:kpi_drive/ui/bloc/tasks_state.dart';
import 'package:kpi_drive/ui/widgets/board_column.dart';

class TaskBoardPage extends StatefulWidget {
  const TaskBoardPage({super.key});

  @override
  State<TaskBoardPage> createState() => _TaskBoardPageState();
}

class _TaskBoardPageState extends State<TaskBoardPage> {
  final _scrollController = ScrollController();
  Timer? _scrollTimer;
  double _scrollDirection = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  void _handleAutoScroll(Offset globalPosition) {
    final screenWidth = MediaQuery.of(context).size.width;
    const edgeThreshold = 120;
    final dx = globalPosition.dx;
    if (dx > screenWidth - edgeThreshold) {
      _startAutoScroll(1);
    } else if (dx < edgeThreshold) {
      _startAutoScroll(-1);
    } else {
      _stopAutoScroll();
    }
  }

  void _startAutoScroll(double direction) {
    if (_scrollDirection == direction && _scrollTimer != null) return;
    _scrollDirection = direction;
    _scrollTimer?.cancel();

    _scrollTimer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final minScroll = _scrollController.position.minScrollExtent;
      const speed = 10.0;
      final newOffset = (_scrollController.offset + speed * _scrollDirection).clamp(minScroll, maxScroll);

      _scrollController.jumpTo(newOffset);
    });
  }

  void _stopAutoScroll() {
    _scrollTimer?.cancel();
    _scrollTimer = null;
    _scrollDirection = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C0C0C),
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (state is TasksLoading) {
            return Center(child: CircularProgressIndicator(color: Color(0xFF1EBE17)));
          }
          if (state is TasksLoaded) {
            return Listener(
              onPointerMove: (event) {
                _handleAutoScroll(event.position);
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state.sortedParentIds.map((parentId) {
                    return BoardColumn(
                      parentId: parentId,
                      tasks: state.tasks[parentId] ?? [],
                      header: state.parentNames[parentId] ?? '',
                      sortedParentIds: state.sortedParentIds,
                    );
                  }).toList(),
                ),
              ),
            );
          }
          if (state is TasksError) {
            return Center(
              child: Column(
                children: [
                  Text('An error occured'),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: () => context.read<TasksCubit>().fetchTasks(), child: Text('Reload')),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}

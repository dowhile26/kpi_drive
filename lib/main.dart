import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpi_drive/core/service_locator.dart';
import 'package:kpi_drive/ui/bloc/tasks_cubit.dart';
import 'package:kpi_drive/ui/task_board_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpDependencies();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit()..fetchTasks(),
      child: MaterialApp(
        title: 'KPI Drive',
        theme: ThemeData(
          colorScheme: ColorScheme.dark(),
          textTheme: TextTheme().copyWith(bodyMedium: TextStyle(color: Color(0xFFE6E1E5))),
        ),
        home: const TaskBoardPage(),
      ),
    );
  }
}

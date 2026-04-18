import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kpi_drive/data/task_service.dart';

final GetIt getIt = GetIt.instance;

Dio createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.dev.kpi-drive.ru/_api/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.addAll([
    InterceptorsWrapper(
      onRequest: (options, handler) {
        const token = String.fromEnvironment('API_TOKEN');
        if (token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ),
    InterceptorsWrapper(
      onError: (error, handler) {
        debugPrint(error.message);
        handler.next(error);
      },
    ),
  ]);

  return dio;
}

void setUpDependencies() {
  getIt.registerLazySingleton<Dio>(createDio);
  getIt.registerLazySingleton<TaskService>(() => TaskService(getIt<Dio>()));
}

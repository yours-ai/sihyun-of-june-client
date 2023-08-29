import 'package:dio/dio.dart';
import 'package:project_june_client/environments.dart';

final Dio dio = Dio(
  BaseOptions(
    baseUrl: BuildTimeEnvironments.apiBaseUrl,
  ),
);

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/environments.dart';

final Dio dio = Dio(
  BaseOptions(
    baseUrl: BuildTimeEnvironments.apiBaseUrl,
  ),
);

void initServerErrorSnackbar(BuildContext context) {
  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (error, handler) {
        if (error.response?.statusCode != null &&
            error.response!.statusCode! > 500) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                '서버에 문제가 발생했습니다. 잠시 후 다시 시도해주세요.',
              ),
            ),
          );
        }
        return handler.next(error);
      },
    ),
  );
}

import '../client.dart';

Future<void> sendUserFunnel(String? funnel) async {
  await dio.post('/analytics/funnel/', data: {
    'funnel': funnel,
  });
  return;
}

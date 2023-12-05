import '../client.dart';

Future<void> sendUserFunnel(String? funnel) async {
  await dio.post('/analytics/funnel/', data: {
    'funnel': funnel,
  });
  return;
}

Future<void> sendUserRefCode(String refCode) async {
  await dio.post('/analytics/referral/', data: {
    'referral_code': refCode,
  });
  return;
}

Future<String> getShortenUrl(String url) async {
  var response = await dioForURL.post('/shortener/', data: {'long_url': url});
  return response.data['url'];
}

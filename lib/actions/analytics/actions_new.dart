import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:project_june_client/actions/analytics/dtos.dart';
import 'package:project_june_client/actions/client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'actions_new.g.dart';

@riverpod
Future<void> sendUserFunnel(SendUserFunnelRef ref, String? funnel) async {
  await dio.post('/analytics/funnel/', data: {
    'funnel': funnel,
  });
}

@riverpod
Future<void> sendUserRefCode(SendUserRefCodeRef ref, String refCode) async {
  await dio.post('/analytics/referral/', data: {
    'referral_code': refCode,
  });
}

@riverpod
Future<void> logUserSource(LogUserSourceRef ref, UserFunnelDTO dto) async {
  await ref.read(sendUserFunnelProvider(dto.funnel).future);
  if (dto.refCode != null && dto.refCode!.isNotEmpty) {
    await ref.read(sendUserRefCodeProvider(dto.refCode!).future);
  }
}

@riverpod
Future<void> getShareUrl(GetShareUrlRef ref, String url) async {
  final response =
      await dioForShortener.post('/shortener/', data: {'long_url': url});
  final convertedUrl = response.data['url'];
  Share.share(
      '${FirebaseRemoteConfig.instance.getString('referral_text').replaceAll("\\n", "\n")}\n$convertedUrl',
      subject: '유월의 시현이 공유하기');
}

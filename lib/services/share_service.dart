import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';
import 'package:project_june_client/environments.dart';

class ShareService {
  const ShareService();

  void kakaoShare(String? refCode) async {
    int templateId = int.parse(BuildTimeEnvironments.kakaoTemplateId);
    Map<String, String> templateArgs = {
      'ref': refCode ?? 'refCode',
    };

    bool isKakaoTalkSharingAvailable =
        await ShareClient.instance.isKakaoTalkSharingAvailable();

    if (isKakaoTalkSharingAvailable) {
      Uri uri = await ShareClient.instance
          .shareCustom(templateId: templateId, templateArgs: templateArgs);
      await ShareClient.instance.launchKakaoTalk(uri);
    } else {
      Uri shareUrl = await WebSharerClient.instance
          .makeCustomUrl(templateId: templateId, templateArgs: templateArgs);
      await launchBrowserTab(shareUrl, popupOpen: true);
    }
  }
}

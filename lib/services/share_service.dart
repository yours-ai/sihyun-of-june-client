import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';

class ShareService {
  const ShareService();

  void kakaoShare(String? refCode) async {
    int templateId = 101441;
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

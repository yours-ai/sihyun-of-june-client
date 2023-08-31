class BuildTimeEnvironments {
  static String apiBaseUrl = const String.fromEnvironment('API_BASE_URL');
  static String kakaoNativeAppKey =
      const String.fromEnvironment('KAKAO_NATIVE_APP_KEY');
}

final REQUIRED_VARIABLES = {
  'API_BASE_URL': BuildTimeEnvironments.apiBaseUrl,
  'KAKAO_NATIVE_APP_KEY': BuildTimeEnvironments.kakaoNativeAppKey,
};

void _assertBuildTimeEnvironments(Map<String, String> variables) {
  variables.entries.forEach((entry) {
    assert(entry.value.isNotEmpty,
        "환경변수 ${entry.key} 값을 제공해주세요. (flutter run --dart-define ${entry.key}=...)");
  });
}

void assertBuildTimeEnvironments() {
  _assertBuildTimeEnvironments(REQUIRED_VARIABLES);
}

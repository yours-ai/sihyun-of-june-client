class BuildTimeEnvironments {
  static String apiBaseUrl = const String.fromEnvironment('API_BASE_URL');
}

void assertBuildTimeEnvironments() {
  assert(BuildTimeEnvironments.apiBaseUrl.isNotEmpty,
      "환경변수 API_BASE_URL 값을 제공해주세요. (flutter run --dart-define API_BASE_URL=...)");
}

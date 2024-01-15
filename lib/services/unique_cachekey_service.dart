class UniqueCacheKeyService {
  static String makeUniqueKey(String url) {
    final splitedUrlList = url.split('?X-Amz-Algorithm')[0].split('/');
    final directoryName = splitedUrlList[splitedUrlList.length - 2];
    final fileName = splitedUrlList.last;
    final cacheKey = '${directoryName}_$fileName';
    return cacheKey;
  }
}

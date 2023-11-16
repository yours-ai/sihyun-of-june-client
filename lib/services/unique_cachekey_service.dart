class UniqueCacheKeyService {
  static String makeUniqueKey(String url) {
    var splitedUrlList = url.split('?X-Amz-Algorithm')[0].split('/');
    var directoryName = splitedUrlList[splitedUrlList.length - 2];
    var fileName = splitedUrlList.last;
    var cacheKey = '${directoryName}_$fileName';

    return cacheKey;
  }
}

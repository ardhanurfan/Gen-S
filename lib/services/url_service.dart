class UrlService {
  String baseUrl = 'http://music-app.test/api/';

  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}

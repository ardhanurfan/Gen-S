class UrlService {
  String baseUrl = 'http://10.0.0.2/music-app/public/api/';
  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}

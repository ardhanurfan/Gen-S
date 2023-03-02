class UrlService {
  String baseUrl =
      'https://b8a2-180-245-181-123.ap.ngrok.io/music-app/public/api/';

  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}

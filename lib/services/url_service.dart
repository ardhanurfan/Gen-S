class UrlService {
  // String baseUrl = 'http://10.0.2.2/music-app/public/api/';
  String baseUrl =
      'https://2b49-180-244-134-145.ap.ngrok.io/music-app/public/api/';

  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}

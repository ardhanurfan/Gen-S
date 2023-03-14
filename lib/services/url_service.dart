class UrlService {
  // String baseUrl = 'http://10.0.2.2/music-app/public/api/';
  String baseUrl =
      'https://14bd-114-124-131-29.ap.ngrok.io/music-app/public/api/';

  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}

class UrlService {
  String baseUrl = 'https://gens.my.id/api/';
  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}

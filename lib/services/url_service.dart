class UrlService {
  String baseUrl = 'http://gens.my.id:8000/api/';
  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}

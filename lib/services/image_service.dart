import 'dart:convert';

import 'package:music_player/models/image_model.dart';
import 'package:music_player/services/url_service.dart';

import 'package:http/http.dart' as http;

class ImageService {
  Future<ImageModel> addImage({
    int audioId = -1,
    int galleryId = -1,
    required String imagePath,
  }) async {
    late Uri url = UrlService().api('add-image');

    var headers = {
      'Content-Type': 'application/json',
    };

    var request = http.MultipartRequest('POST', url);

    // add headers
    request.headers.addAll(headers);

    // add id
    if (audioId != -1) {
      request.fields['audioId'] = audioId.toString();
    }
    if (galleryId != -1) {
      request.fields['galleryId'] = galleryId.toString();
    }

    // add audio
    request.files
        .add(await http.MultipartFile.fromPath('imageFile', imagePath));

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsed.body)['data'];
      return ImageModel.fromJson(data);
    } else {
      throw "Add image failed";
    }
  }

  Future<bool> deleteImage({required int imageId}) async {
    late Uri url = UrlService().api('delete-image');
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      'id': imageId,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw "Delete image failed";
    }
  }
}

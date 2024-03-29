import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalJSON {
  static Future<List<Map<String, dynamic>>> readJsonFile(
      {required String fileName}) async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName.json');
      if (await file.exists()) {
        final jsonContent = await file.readAsString();
        final List<Map<String, dynamic>> jsonData =
            json.decode(jsonContent).cast<Map<String, dynamic>>();
        return jsonData;
      } else {
        await file.create(recursive: true); // recursive agar membuat directory
        await file.writeAsString('[]');
        return [];
      }
    } catch (e) {
      throw 'Error reading JSON file: $e';
    }
  }

  static Future<bool> writeJsonFile(
      {required String fileName, Object? items}) async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName.json');
      final jsonData = json.encode(items);
      await file.writeAsString(jsonData);
      return true;
    } catch (e) {
      throw 'Error writing JSON file: $e';
    }
  }
}

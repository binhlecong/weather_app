import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManager {
  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> localFile(String filename) async {
    final path = await localPath;
    return File('$path/$filename');
  }

  Future<File> writeFile(String filename, String content) async {
    final file = await localFile(filename);

    // Write the file
    return file.writeAsString(content);
  }

  Future<String> readFile(String filename) async {
    try {
      final file = await localFile(filename);

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      Exception('error while reading file');
    }
    return 'null';
  }
}

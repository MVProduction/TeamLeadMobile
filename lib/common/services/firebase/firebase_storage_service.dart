import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:team_lead/common/services/storage_service.dart';
import 'package:uuid/uuid.dart';

/// Сервис хранения файлов на основе Firebase
class FirebaseStorageService extends StorageService {
  /// Сохраняет файл
  @override
  Future saveFile(String name, File file) async {
    await FirebaseStorage.instance.ref().child(name).putFile(file).onComplete;
  }

  /// Загружает файл
  @override
  Future<File> loadFile(String name) async {
    // await for (var it in Directory.systemTemp.list()) {
    //   print(it.uri);
    // }

    final tempPath = Directory.systemTemp;
    final String uuid = Uuid().v1();
    final tempFile = File('${tempPath.path}/${name}_$uuid');

    if (tempFile.existsSync()) {
      tempFile.deleteSync();
    }

    tempFile.createSync();

    try {
      await FirebaseStorage.instance
          .ref()
          .child(name)
          .writeToFile(tempFile)
          .future;
    } catch (_) {
      return null;
    }

    return tempFile;
  }

  @override
  Future deleteFile(String name) {
    // TODO: implement deleteFile
    throw UnimplementedError();
  }
}

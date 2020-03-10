import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:team_lead/common/services/storage_service.dart';

/// Сервис хранения файлов на основе Firebase
class FirebaseStorageService extends StorageService {
  /// Сохраняет файл
  @override
  Future saveFile(String name, File file) {
    return FirebaseStorage.instance.ref().child(name).putFile(file).onComplete;
  }

  /// Загружает файл
  @override
  Future<File> loadFile(String name) async {
    final tempPath = Directory.systemTemp;
    final tempFile = File('${tempPath.path}/$name');    
    tempFile.create();
    await FirebaseStorage.instance
        .ref()
        .child(name)
        .writeToFile(tempFile)
        .future;
    return tempFile;
  }

  @override
  Future deleteFile(String name) {
    // TODO: implement deleteFile
    throw UnimplementedError();
  }
}

import 'dart:io';

/// Сервис хранения файлов
abstract class StorageService {
  /// Сохраняет файл
  Future saveFile(String name, File file);

  /// Загружает файл
  Future<File> loadFile(String name);

  /// Удаляет файл
  Future deleteFile(String name);
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as pathpkg;

/// Utility class to handle paths in filesystem
class FileEntity {
  FileEntity(this.name, this.path, this.type);

  final String path;
  final String name;
  final FileSystemEntityType type;

  static Future<FileEntity> fromFileSystemEntity(
      FileSystemEntity entity) async {
    final name = pathpkg.split(entity.path).last;
    final type = await FileSystemEntity.type(entity.path);

    return FileEntity(name, entity.path, type);
  }

  bool get isDirectory {
    return type == FileSystemEntityType.directory;
  }

  String get extention {
    return name.split('.').last;
  }

  IconData get icon {
    if (isDirectory) {
      return Icons.folder;
    }

    if (name.split('.').last == 'epub') {
      return Icons.book;
    }

    return Icons.file_copy;
  }
}

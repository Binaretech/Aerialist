import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

Future<List<Directory>> getStorageDirectories() async {
  return (await pathProvider.getExternalStorageDirectories())
      .map((directory) => Directory(directory.path.split('Android').first))
      .toList();
}

Future<List<String>> searchEpubs() async {
  final dirs = await getStorageDirectories();
  List<String> paths = [];

  for (Directory dir in dirs) {
    await dir.list(recursive: true).listen((entity) {
      if (split(entity.path).last.split('.').last == 'epub') {
        paths.add(entity.path);
      }
    }).asFuture();
  }

  return paths;
}

String storageName(String path) {
  if (Platform.isAndroid) {
    return path.contains('emulated') ? 'Internal shared storage' : 'sdcard';
  }

  return path;
}

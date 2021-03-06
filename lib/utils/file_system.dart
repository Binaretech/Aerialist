import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:flutter_gen/gen_l10n/app_localizations.dart' as localization;

/// Returns a list of the available mounted storages
Future<List<Directory>> getStorageDirectories() async {
  return (await pathProvider.getExternalStorageDirectories())!
      .map((directory) => Directory(directory.path.split('Android').first))
      .toList();
}

/// Search recursively into the available storages
/// for epub files and return a list with the path of found epubs
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

/// Return a user friendly name for storage path
///
/// Only works propperly in android
String storageName(String path, BuildContext context) {
  if (Platform.isAndroid) {
    return path.contains('emulated')
        ? localization.AppLocalizations.of(context)!.internalSharedStorage
        : 'SDcard';
  }

  return path;
}

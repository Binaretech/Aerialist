import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:path/path.dart' show join;

const String kTemporaryPath = 'temporaryPath';
const String kApplicationSupportPath = 'applicationSupportPath';
const String kDownloadsPath = 'downloadsPath';
const String kLibraryPath = 'libraryPath';
const String kApplicationDocumentsPath = 'applicationDocumentsPath';
const String kExternalCachePath = 'externalCachePath';
const String kExternalStoragePath = 'externalStoragePath';

class MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  Future<String> getTemporaryPath() async {
    return kTemporaryPath;
  }

  Future<String> getApplicationSupportPath() async {
    return kApplicationSupportPath;
  }

  Future<String> getLibraryPath() async {
    return kLibraryPath;
  }

  Future<String> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }

  Future<String> getExternalStoragePath() async {
    return kExternalStoragePath;
  }

  Future<List<String>> getExternalCachePaths() async {
    return <String>[kExternalCachePath];
  }

  Future<List<String>> getExternalStoragePaths({
    StorageDirectory type,
  }) async {
    return <String>[kExternalStoragePath];
  }

  Future<String> getDownloadsPath() async {
    return kDownloadsPath;
  }
}

class MockDirectory extends Mock implements Directory {
  MockDirectory(this.path);

  final String path;

  String get name => path;

  Stream<FileSystemEntity> list(
      {bool recursive: false, bool followLinks: true}) {
    final children = [
      File(join(kExternalStoragePath, 'file.pdf')),
      File(join(kExternalStoragePath, 'file.epub')),
      File(join(kExternalStoragePath, 'file2.epub')),
    ];

    return Stream.fromIterable(children);
  }
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

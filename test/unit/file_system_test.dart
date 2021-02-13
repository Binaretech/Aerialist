import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:Aerialist/utils/file_system.dart';
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

void main() {
  setUp(() {
    PathProviderPlatform.instance = MockPathProviderPlatform();
  });

  test('Should return a list of available storages', () async {
    final directories = await getStorageDirectories();
    expect(directories.map((dir) => dir.path), [kExternalStoragePath]);
  });

  test('Should return a list of epubs path', () {
    IOOverrides.runZoned(() async {
      final directories = await searchEpubs();
      expect(directories,
          ['externalStoragePath/file.epub', 'externalStoragePath/file2.epub']);
    }, createDirectory: (String path) => MockDirectory(path));
  });
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

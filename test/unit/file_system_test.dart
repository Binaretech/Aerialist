import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:Aerialist/utils/file_system.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../utils.dart';

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

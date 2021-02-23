import 'dart:convert';

import 'package:Aerialist/models/ebook.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Aerialist/utils/storage.dart';

import '../utils.dart';

const Ebook book = Ebook(
  title: 'The awesome revenge of the donkey mocho',
  author: 'The unnamed author',
  path: '/path/to/your/heart',
  cover: null,
);

void main() {
  setUp(() {
    PathProviderPlatform.instance = MockPathProviderPlatform();
    SharedPreferences.setMockInitialValues({
      'books': jsonEncode([book]),
    });
  });

  test('Should get a list of ebooks', () async {
    final books = await getStoredBooks();

    expect(books.length, 1);
    expect(books.first, book);
  });
}

import 'dart:convert';
import 'dart:io';

import 'package:Aerialist/models/ebook.dart';
import 'package:epubx/epubx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as provider;
import 'package:path/path.dart' show join;

/// Return a list of stored books
///
/// Reads the shared preferences and parse the content of 'books' key into a [List<Ebook>]
Future<List<Ebook>> getStoredBooks() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  final storedString = preferences.getString('books');

  if (storedString == null) return List.empty();

  final books = jsonDecode(storedString) as List;

  return books.map((rawBook) => Ebook.fromMap(Map.from(rawBook))).toList();
}

/// Receive a list of ebook paths and store each one in shared preferences
///
/// Reads the data from each ebook and convert it to an [Ebook] instance, serializes it into json
/// and saves it into shared preferences
void storeBooks(List<String> paths) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  List<Ebook> books =
      await getStoredBooks().catchError(() => List<Ebook>.empty());

  for (String path in paths) {
    books.add(await readEbookPath(path));
  }

  await preferences.setString('books', jsonEncode(books));
}

/// Receive an ebook path and reads it data
///
/// Create an [Ebook] instance for the ebook at [path] by reading its data and
/// storing its cover image in the documents directory
Future<Ebook> readEbookPath(String path) async {
  final epubRef = await EpubReader.openBook(await File(path).readAsBytes());

  final cover = await epubRef.readCover();
  String? coverPath;

  if (cover != null) {
    final documentsDirectory =
        (await provider.getApplicationDocumentsDirectory()).path;

    final file = File(join(documentsDirectory, path));
    coverPath = (await file.writeAsBytes(cover.getBytes())).path;
  }

  return Ebook(
    title: epubRef.Title!,
    path: path,
    author: epubRef.Author!,
    cover: coverPath,
  );
}

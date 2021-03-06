import 'package:Aerialist/modules/reader/widgets/chapter_tile.dart';
import 'package:epubx/epubx.dart';
import 'package:flutter/material.dart';

/// Show a list of the book's chapters and subchapters
///
/// If a chapter contains subchapters the tile will be render as a
/// expandable
class ChapterList extends StatelessWidget {
  ChapterList({required this.chapters});

  final List<EpubChapterRef> chapters;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:
          chapters.map((chapter) => ChapterTile(chapter: chapter)).toList(),
    );
  }
}

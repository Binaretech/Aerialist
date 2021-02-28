import 'package:Aerialist/modules/reader/widgets/chapter_tile.dart';
import 'package:epub/epub.dart';
import 'package:flutter/material.dart';

class ChapterList extends StatelessWidget {
  ChapterList({@required this.chapters});

  final List<EpubChapterRef> chapters;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:
          chapters.map((chapter) => ChapterTile(chapter: chapter)).toList(),
    );
  }
}

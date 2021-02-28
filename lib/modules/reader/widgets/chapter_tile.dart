import 'package:epub/epub.dart';
import 'package:flutter/material.dart';

class ChapterTile extends StatelessWidget {
  ChapterTile({@required this.chapter, this.isSubChapter = false});

  final EpubChapterRef chapter;
  final bool isSubChapter;

  @override
  Widget build(BuildContext context) {
    if (chapter.SubChapters.length > 0) {
      return ExpansionTile(
        title: Text(chapter.Title),
        children:
            chapter.SubChapters.map((chapter) => ChapterTile(chapter: chapter))
                .toList(),
      );
    }

    return ListTile(
      title: Text(chapter.Title),
    );
  }
}

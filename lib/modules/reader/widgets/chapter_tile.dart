import 'package:epubx/epubx.dart';
import 'package:flutter/material.dart';

/// Display the chapter as a list tile or as a expandable if the given
/// chapter has subchapters
class ChapterTile extends StatelessWidget {
  ChapterTile({required this.chapter});

  final EpubChapterRef chapter;

  @override
  Widget build(BuildContext context) {
    if (chapter.SubChapters!.length > 0) {
      return ExpansionTile(
        title: Text(chapter.Title!),
        children: chapter.SubChapters!
            .map((chapter) => ChapterTile(chapter: chapter))
            .toList(),
      );
    }

    return ListTile(
      title: Text(chapter.Title!),
    );
  }
}

import 'package:Aerialist/modules/reader/widgets/chapter_list.dart';
import 'package:Aerialist/modules/reader/widgets/reader_drawer_tab_bar.dart';
import 'package:epub/epub.dart';
import 'package:flutter/material.dart';

class ReaderDrawerTabs extends StatelessWidget {
  ReaderDrawerTabs({@required this.chapters});

  final List<EpubChapterRef> chapters;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              ReaderDrawerTabBar(),
              Expanded(
                child: TabBarView(
                  children: [
                    ChapterList(chapters: chapters),
                    ChapterList(chapters: chapters),
                    ChapterList(chapters: chapters),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

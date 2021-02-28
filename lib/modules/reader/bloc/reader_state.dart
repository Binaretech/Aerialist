part of 'reader_bloc.dart';

abstract class ReaderState extends Equatable {
  ReaderState();

  @override
  List<Object> get props => [];
}

class ReaderLoadingState extends ReaderState {
  ReaderLoadingState();
}

class ReaderLoadedState extends ReaderState {
  ReaderLoadedState(this.title, this.chapters,
      [this.currentChapterIndex = 0, this.currentSubchapter]);

  final String title;
  final List<EpubChapterRef> chapters;
  final int currentChapterIndex;
  final int currentSubchapter;

  @override
  List<Object> get props => [title];

  EpubChapterRef get currentChapter => currentSubchapter != null
      ? chapters[currentChapterIndex].SubChapters[currentSubchapter]
      : chapters[currentChapterIndex];
}
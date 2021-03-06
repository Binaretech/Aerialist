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
  ReaderLoadedState(this.bookRef, this.title, this.chapters,
      [this.currentChapterIndex = 0]);

  final String title;
  final List<EpubChapterRef> chapters;
  final int currentChapterIndex;
  final EpubBookRef bookRef;

  @override
  List<Object> get props => [title];

  EpubChapterRef get currentChapter => chapters[currentChapterIndex];
}

part of 'reader_bloc.dart';

class ReaderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadBookEvent extends ReaderEvent {
  LoadBookEvent(this.path);

  final String path;

  @override
  List<Object> get props => [];
}

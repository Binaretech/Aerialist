import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:epubx/epubx.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reader_event.dart';
part 'reader_state.dart';

class ReaderBloc extends Bloc<ReaderEvent, ReaderState> {
  ReaderBloc() : super(ReaderLoadingState());

  static ReaderBloc of(BuildContext context) =>
      BlocProvider.of<ReaderBloc>(context);

  @override
  Stream<ReaderState> mapEventToState(ReaderEvent event) async* {
    if (event is LoadBookEvent) {
      yield await mapLoadBookEventToState(event);
    }
  }

  Future<ReaderState> mapLoadBookEventToState(LoadBookEvent event) async {
    final bookRef =
        await EpubReader.openBook(await File(event.path).readAsBytes());
    return ReaderLoadedState(
        bookRef, bookRef.Title!, await bookRef.getChapters());
  }
}

import 'package:Aerialist/modules/reader/bloc/reader_bloc.dart';
import 'package:Aerialist/modules/reader/widgets/reader_drawer_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reader_scaffold.dart';

class ReaderView extends StatelessWidget {
  ReaderView(this.bookPath);

  final String bookPath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReaderBloc()..add(LoadBookEvent(bookPath)),
      child: _ReaderScaffold(),
    );
  }
}

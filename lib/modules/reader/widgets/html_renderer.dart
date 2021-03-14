import 'package:html/dom.dart' show Element;
import 'package:Aerialist/modules/reader/bloc/reader_bloc.dart';
import 'package:flutter/material.dart' hide Element;
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';

class HtmlRenderer extends StatelessWidget {
  HtmlRenderer({required this.data});

  final String data;

  Widget Function(RenderContext, Widget, Map<String, String>, Element?)
      imgRenderer(ReaderLoadedState state) {
    return (context, child, attributes, element) {
      final image = state.bookRef.Content!.Images![attributes['src']]!
          .getContentFileEntry()
          .content;
      return Image.memory(image);
    };
  }

  @override
  Widget build(BuildContext context) {
    final state = ReaderBloc.of(context).state as ReaderLoadedState;

    return SingleChildScrollView(
      child: Html(
        data: data,
        customRender: {
          'img': imgRenderer(state),
        },
      ),
    );
  }
}

import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:Aerialist/modules/reader/bloc/reader_bloc.dart';
import 'package:flutter/material.dart';
import 'package:epubx/epubx.dart';

class HtmlRenderer extends StatelessWidget {
  HtmlRenderer({required this.data});

  final String data;
	


	Widget renderHtmlElement(dom.Element element) {
		switch(element.localName) {
			case 'img':

				return 
		}
	}

  List<Widget> renderHtmlList(Map<String, EpubByteContentFile> images ,dom.Element element) {
		switch(element.localName) {
				case 'section':
				case 'div':
						return element
								.nodes
								.map((element) => element.nodes.length > 1? renderHtmlList(images, element):renderHtmlElement(element))
								.toList<Widget>();
			}
	}

  @override
  Widget build(BuildContext context) {
    final state = ReaderBloc.of(context).state as ReaderLoadedState;
    final document =
        parser.parse("<body><div>asdads<p>123123</p></div></body>");

    return PageView(
      scrollDirection: Axis.horizontal,
      children: document.body!.children
          .map((element) => renderHtml(element))
          .toList(),
    );
  }
}

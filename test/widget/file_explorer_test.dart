import 'dart:io';

import 'package:Aerialist/widget/file_explorer/file_explorer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' as localization;

import '../utils.dart';

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('test'),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FileExplorer(
                  onAccept: (list) {},
                ),
            fullscreenDialog: true));
      },
    );
  }
}

void main() {
  testWidgets('File explorer should appear', (WidgetTester tester) async {
    IOOverrides.runZoned(() async {
      final observer = MockNavigatorObserver();
      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: [localization.AppLocalizations.delegate],
        supportedLocales: localization.AppLocalizations.supportedLocales,
        home: Scaffold(
          body: TestWidget(),
        ),
        navigatorObservers: [observer],
      ));

      expect(find.byType(ElevatedButton), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));

      await tester.pump();
      await tester.pump();

      expect(find.byType(FileExplorer), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    }, createDirectory: (String path) => MockDirectory(path));
  });
}

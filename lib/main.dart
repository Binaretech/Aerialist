import 'package:Aerialist/config/themes/bloc/theme_bloc.dart';
import 'package:Aerialist/widget/file_explorer/file_explorer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' as localization;

void main() {
  runApp(Aerialist());
}

class Aerialist extends StatelessWidget {
  Widget _materialApp(ThemeState state) {
    return MaterialApp(
      localizationsDelegates: [
        localization.AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
      ],
      title: 'Aerialist',
      theme: state.theme,
      home: Scaffold(
        body: Container(
          child: Test(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) => _materialApp(state),
      ),
    );
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text("test"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FileExplorer(
                onAccept: (list) => print(list),
                filter: ['epub'],
              ),
              fullscreenDialog: true,
            ),
          );
        },
      ),
    );
  }
}

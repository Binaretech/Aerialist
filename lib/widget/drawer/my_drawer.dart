import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' as localization;

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = localization.AppLocalizations.of(context)!;

    Material _myDrawerHeader = Material(
      elevation: 4.0,
      child: Container(
        height: 56.0,
        child: Row(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 3.0),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {},
                )),
            Container(
                margin: EdgeInsets.only(left: 21.0),
                child: Text(
                  'Aerialist',
                  style: Theme.of(context).primaryTextTheme.headline6,
                )),
          ],
        ),
      ),
    );

    return Drawer(
        child: SafeArea(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _myDrawerHeader,
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text("${locale.drawerLibrary}"),
          ),
        ],
      ),
    ));
  }
}

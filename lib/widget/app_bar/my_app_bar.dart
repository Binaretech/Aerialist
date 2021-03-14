import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar = AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Aerialist'),
      iconTheme: Theme.of(context).iconTheme,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        )
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}

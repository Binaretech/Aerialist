import 'package:flutter/material.dart';

class ReaderDrawerTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: [
        Tab(
          icon: Icon(
            Icons.format_list_bulleted,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Tab(
          icon: Icon(
            Icons.create_rounded,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Tab(
          icon: Icon(
            Icons.bookmark,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}

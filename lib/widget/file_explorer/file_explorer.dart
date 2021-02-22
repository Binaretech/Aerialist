import 'dart:io';

import 'package:Aerialist/widget/file_explorer/models/file_entity.dart';
import 'package:flutter/material.dart';
import 'package:Aerialist/utils/permissions.dart';
import 'package:Aerialist/utils/file_system.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_gen/gen_l10n/app_localizations.dart' as localization;

part 'file_explorer_tile.dart';

/// FileExplorer
///
/// Dialog that display the available storages and browse
/// into its directories
class FileExplorer extends StatefulWidget {
  FileExplorer({this.onAccept, this.filter = const []});

  /// When the user tap on the check button
  final void Function(List<String>) onAccept;

  /// Filter file extentions
  final List<String> filter;

  @override
  _FileExplorerState createState() => _FileExplorerState();
}

class _FileExplorerState extends State<FileExplorer> {
  /// FileSystemEntities found
  List<FileEntity> entities = [];

  /// Loading flag
  bool loading = true;

  /// Available storages
  List<Directory> baseDirectories = [];

  /// User selected paths
  Set<String> selectedPaths = Set();

  @override
  void initState() {
    super.initState();

    requestPermission(Permission.storage).then((result) async {
      if (!result) {
        Navigator.of(context).pop();
      }

      baseDirectories = await getStorageDirectories();
      loadDirectory(baseDirectories.first);
    });
  }

  /// Receive a directory and load its children into [entities]
  void loadDirectory(Directory directory) async {
    try {
      List<FileEntity> entities = await directory
          .list(followLinks: true)
          .asyncMap((entity) => FileEntity.fromFileSystemEntity(entity))
          .where((entity) {
        if (!entity.isDirectory) {
          return widget.filter.contains(entity.extention);
        }
        return true;
      }).toList();

      if (!inBaseDirs(directory)) {
        entities.insert(
            0,
            FileEntity(
                '..', directory.parent.path, FileSystemEntityType.directory));
      }

      setState(() {
        loading = false;
        this.entities = entities;
      });
    } catch (error) {
      setState(() {
        loading = false;
      });
    }
  }

  /// On open directory event
  ///
  /// Receive a path and load its children into [entities]
  void openDirectory(String path) {
    setState(() {
      loading = true;
    });

    loadDirectory(Directory(path));
  }

  /// On select file event
  ///
  /// Receive the file path and if the path aready exists into [selectedPaths]
  /// it will be removed, otherwise it will be stored
  void onSelect(String path) {
    setState(() {
      if (selectedPaths.contains(path)) {
        selectedPaths.remove(path);
        return;
      }

      selectedPaths.add(path);
    });
  }

  /// Returns true if the given directory is one of the
  /// available storages root path
  bool inBaseDirs(Directory directory) {
    for (Directory baseDir in baseDirectories) {
      if (path.equals(directory.path, baseDir.path)) {
        return true;
      }
    }

    return false;
  }

  /// On user accept event
  void onAccept() {
    widget.onAccept(selectedPaths.toList());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final locale = localization.AppLocalizations.of(context);

    return DefaultTabController(
      length: baseDirectories.length,
      child: Scaffold(
        appBar: AppBar(
          actions: selectedPaths.isEmpty
              ? []
              : [
                  IconButton(
                    onPressed: onAccept,
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  )
                ],
          title: Text(
              "${locale.selectFiles} (${locale.selectedFiles(selectedPaths.length)})"),
          bottom: TabBar(
            tabs: baseDirectories
                .map(
                  (dir) => Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      storageName(dir.path, context),
                    ),
                  ),
                )
                .toList(),
            onTap: (index) => loadDirectory(baseDirectories[index]),
          ),
        ),
        body: loading
            ? LinearProgressIndicator()
            : ListView(
                children: entities
                    .map((entity) => FileExplorerTile(
                          entity: entity,
                          onOpen: openDirectory,
                          onSelect: onSelect,
                          selected: selectedPaths.contains(entity.path),
                        ))
                    .toList(),
              ),
      ),
    );
  }
}

part of 'file_explorer.dart';

/// List tile for file explorer
///
/// Handle selection, directory opening, and selection status
class FileExplorerTile extends StatelessWidget {
  FileExplorerTile(
      {this.entity, this.selected = false, this.onOpen, this.onSelect});

  final FileEntity entity;
  final bool selected;
  final void Function(String) onOpen;
  final void Function(String) onSelect;

  void onTap() {
    if (entity.isDirectory) {
      return onOpen(entity.path);
    }

    onSelect(entity.path);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(entity.icon),
      title: Text(entity.name),
      onTap: onTap,
      selected: selected,
    );
  }
}

import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission(Permission permission) async {
  final status = await permission.status;
  if (status.isGranted) {
    return true;
  }

  return await permission.request().isGranted;
}

import 'package:permission_handler/permission_handler.dart';

/// Ask for permission if is not requested, if it was requested
/// returns true if the permission is granted, otherwise returns false
Future<bool> requestPermission(Permission permission) async {
  final status = await permission.status;
  if (status.isGranted) {
    return true;
  }

  return await permission.request().isGranted;
}

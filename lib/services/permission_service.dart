
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

class PermissionService {
  // Request activity recognition permission
  Future<PermissionStatus> requestActivityPermission() async {
    final status = await Permission.activityRecognition.request();
    return status;
  }

  //check activity recognition permission
  Future<bool> checkActivityPermission() async {
    final status = await Permission.activityRecognition.status;
    return status == PermissionStatus.granted;
  }
}
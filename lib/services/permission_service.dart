// * **Create the File:** Create `permission_service.dart` in the `lib/services/` folder.
//
// * **Add the Code:**
//
// ```dart
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
// Request activity recognition permission
Future<PermissionStatus> requestActivityPermission() async {
final status = await Permission.activityRecognition.request();
return status;
}

//check activity recognition permission
Future<bool> checkActivityPermission() async{
final status = await Permission.activityRecognition.status;
return status == PermissionStatus.granted;
}
}
//
// ```

// * **Explanation:**
// * The `PermissionService` class handles the activity recognition permission.
// * `requestActivityPermission()`: Requests the permission.
// * `checkActivityPermission()`: Checks the permission status

import 'package:flutter_riverpod/legacy.dart';
import 'package:permission_handler/permission_handler.dart';


// Provider de permisos del dispositivo (cámara, ubicación, etc.). Nombre distinto al permissionsProvider de auth (permisos de la app).
final devicePermissionsProvider = StateNotifierProvider<PermissionsNotifier, PermissionsState>((ref) {
  return PermissionsNotifier();
});



class PermissionsNotifier extends StateNotifier<PermissionsState> {
  PermissionsNotifier(): super(PermissionsState());

  Future<void> checkPermissions() async {
    final permissionsArray = await Future.wait([
      Permission.camera.status,
      Permission.photos.status,

      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status,
    ]);
    state = state.copyWith(
      camera           : permissionsArray[0],
      photoLibrary     : permissionsArray[1],
      location         : permissionsArray[2],
      locationAlways   : permissionsArray[3],
      locationWhenInUse: permissionsArray[4],
    );
  }

  openSettingsScreen() {
    openAppSettings();
  }
  void _checkPermissionsState(PermissionStatus status) {
    if (status == PermissionStatus.permanentlyDenied) {
      openSettingsScreen();
    }
  }

  requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);

    _checkPermissionsState(status);
  }
  requestPhotoLibraryAccess() async {
    final status = await Permission.photos.request();
    state = state.copyWith(photoLibrary: status);

    _checkPermissionsState(status);
  }
  requestLocationAccess() async {
    final status = await Permission.location.request();
    state = state.copyWith(location: status);

    _checkPermissionsState(status);
  }


}

class PermissionsState {
  
  final PermissionStatus camera;
  final PermissionStatus photoLibrary;

  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  PermissionsState({
    this.camera            = PermissionStatus.denied, 
    this.photoLibrary      = PermissionStatus.denied, 
    this.location          = PermissionStatus.denied, 
    this.locationAlways    = PermissionStatus.denied, 
    this.locationWhenInUse = PermissionStatus.denied, 
  });

  get cameraGranted {
    return camera == PermissionStatus.granted;
  }
  get photoLibraryGranted {
    return photoLibrary == PermissionStatus.granted ||
        photoLibrary == PermissionStatus.limited;
  }
  get locationGranted {
    return location == PermissionStatus.granted;
  }
  get locationAlwaysGranted {
    return locationAlways == PermissionStatus.granted;
  }
  get locationWhenInUseGranted {
    return locationWhenInUse == PermissionStatus.granted;
  }

  PermissionsState   copyWith({
    PermissionStatus? camera,
    PermissionStatus? photoLibrary,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
  }) => PermissionsState(
    camera           : camera ?? this.camera,
    photoLibrary     : photoLibrary ?? this.photoLibrary,
    location         : location ?? this.location,
    locationAlways   : locationAlways ?? this.locationAlways,
    locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse,
  );

  /* @override
  String toString() {
    return '''
    PermissionsState:
    camera: $camera
    photoLibrary: $photoLibrary
    location: $location
    locationAlways: $locationAlways
    locationWhenInUse: $locationWhenInUse
    ''';
  } */
}
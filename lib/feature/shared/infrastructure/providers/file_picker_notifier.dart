import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:consultify/feature/feature.dart'; // Importa tus permisos y CustomErro
import 'package:flutter_riverpod/flutter_riverpod.dart';
final filePickerProvider =
    StateNotifierProvider.autoDispose<FilePickerNotifier, List<String>>((ref) {
  return FilePickerNotifier(ref);
});

class FilePickerNotifier extends StateNotifier<List<String>> {
  final Ref ref;
  FilePickerNotifier(this.ref) : super([]);

  Future<void> pickMultipleImages() async {
    // 1. Reutilizamos tu lógica de permisos existente
    final permissions = ref.read(devicePermissionsProvider);
    
    if (!permissions.photoLibraryGranted) {
      await ref.read(devicePermissionsProvider.notifier).requestPhotoLibraryAccess();
      if (!ref.mounted) return;
      if (!ref.read(devicePermissionsProvider).photoLibraryGranted) {
        return; // El usuario denegó el permiso
      }
    }

    // 2. Lógica de selección
    final picker = ImagePicker();
    try {
      final List<XFile> images = await picker.pickMultiImage();
      if (!ref.mounted) return;
      if (images.isNotEmpty) {
        state = [
          ...state,
          ...images.map((img) => img.path).where((p) => p.isNotEmpty),
        ];
      }
    } catch (e) {
      print('Error real al acceder a la galería: $e');
      
      throw CustomError(message: 'Error al acceder a la galería');
    }
  }

  // Métodos de utilidad para la UI
  void removeImage(int index) {
    if (index < 0 || index >= state.length) return;
    state = [...state]..removeAt(index);
  }

  void setPaths(List<String> paths) => state = paths;

  void clear() => state = [];
}
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class LauncherUtils {
  /// Si [urlOrPath] ya es `http`/`https`, se devuelve tal cual.
  /// Si es relativa, se concatena con [baseUrl] (sin usar [Uri.resolve], que con
  /// rutas que empiezan en `/` puede colgar el path del host y romper `/api/v1/...`).
  static String? resolveHttpUrl(String urlOrPath, {required String baseUrl}) {
    final p = urlOrPath.trim();
    if (p.isEmpty) return null;
    final parsed = Uri.tryParse(p);
    if (parsed != null &&
        parsed.hasScheme &&
        (parsed.isScheme('http') || parsed.isScheme('https'))) {
      return p;
    }
    final b = baseUrl.trim();
    if (b.isEmpty) return null;
    final baseNorm = b.endsWith('/') ? b.substring(0, b.length - 1) : b;
    final pathNorm = p.startsWith('/') ? p : '/$p';
    return '$baseNorm$pathNorm';
  }

  /// Abre una URL en el navegador externo o aplicación correspondiente.
  /// Retorna [true] si se pudo abrir, [false] si la URL es inválida o falla.
  static Future<bool> openUrl(String urlString) async {
    final trimmed = urlString.trim();
    if (trimmed.isEmpty) return false;

    final parsedUrl = Uri.tryParse(trimmed);

    // Validamos que el esquema sea http o https
    if (parsedUrl == null || 
        !(parsedUrl.isScheme('http') || parsedUrl.isScheme('https'))) {
      return false;
    }

    try {
      return await launchUrl(
        parsedUrl, 
        mode: LaunchMode.externalApplication
      );
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    }
  }
}
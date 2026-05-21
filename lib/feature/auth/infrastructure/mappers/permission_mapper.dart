import 'package:consultify/feature/feature.dart';

class PermissionMapper {
  /// Convierte una lista de strings de permisos del servidor a una lista de enum UserPermission
  static List<UserPermission> getPermissionsFromResponse(List<dynamic> response) {
    final responseList = response.cast<String>();
    
    final permissions = responseList.map((permissionString) {
      return _mapStringToPermission(permissionString);
    }).where((permission) => permission != UserPermission.unknown).toList();
    
    return permissions;
  }

  /// Mapea un string de permiso del servidor al enum correspondiente
  static UserPermission _mapStringToPermission(String permissionString) {
    switch (permissionString) {

      case 'autorizaciones-portero':
        return UserPermission.authorizationsGuard;
      case 'bitacora':
        return UserPermission.binnacle;
      case 'qr':
        return UserPermission.qr;
      case 'historial-de-ingreso-portero':
        return UserPermission.incomeHistoryGuard;
      case 'correspondencia-paquete':
        return UserPermission.correspondencePackage;
      case 'objetos-perdidos':
        return UserPermission.lostProperty;
      case 'menu-lateral':
        return UserPermission.sideMenu;
      case 'anuncios':
        return UserPermission.adsHeader;
      case 'novedades':
        return UserPermission.news;
      case 'pqrs':
        return UserPermission.pqrs;
      case 'zonas-comunes':
        return UserPermission.commonZones;
      case 'autorizaciones-residente':
        return UserPermission.authorizationsResident;
      case 'buzon':
        return UserPermission.mailbox;
      case 'correspondencia':
        return UserPermission.correspondencePackage;
      case 'historial-de-ingreso-residente':
        return UserPermission.incomeHistoryResident;
      case 'todos-anuncios':
        return UserPermission.getAds;
      case 'asambleas':
        return UserPermission.assemblies;
      case 'colaboradores':
        return UserPermission.collaborators;
      case 'shortcut-autorizacion':
        return UserPermission.authorizationsResident;
      case 'citofonia-residente':
        return UserPermission.citofoniaResident;
      case 'citofonia':
        return UserPermission.citofonia;
      case 'registros':
        return UserPermission.records;
      case 'mi-hogar':
        return UserPermission.myHome;
      case 'documentos-ph':
        return UserPermission.documentsPh;
      case 'estados-de-cuenta':
        return UserPermission.accountStatus;
      case 'objetos-perdidos-residente':
        return UserPermission.lostPropertyResident;





      // Permiso desconocido
      default:
        return UserPermission.unknown;
    }
  }
}

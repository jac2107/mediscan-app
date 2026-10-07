import 'package:medicamentos_app/domain/entities/usuario.dart';
import 'package:medicamentos_app/domain/repositories/usuario_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicamentos_app/core/constants/app_constants.dart';
import 'package:uuid/uuid.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {
  static const _uuid = Uuid();

  @override
  Future<Usuario?> getUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final nombre = prefs.getString(AppConstants.keyUsuarioNombre);
    final id = prefs.getString(AppConstants.keyUsuarioId);
    if (nombre == null || id == null) return null;
    return Usuario(
      id: id,
      nombre: nombre,
      dispositivoId: id,
      creadoEn: DateTime.now(),
    );
  }

  @override
  Future<void> guardarUsuario(Usuario usuario) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.keyUsuarioNombre, usuario.nombre);
    await prefs.setString(AppConstants.keyUsuarioId, usuario.id);
    await prefs.setBool(AppConstants.keyOnboardingDone, true);
  }

  @override
  Future<void> limpiar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.keyUsuarioNombre);
    await prefs.remove(AppConstants.keyUsuarioId);
    await prefs.remove(AppConstants.keyOnboardingDone);
  }
}
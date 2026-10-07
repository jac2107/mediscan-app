import 'package:medicamentos_app/domain/entities/usuario.dart';

abstract class UsuarioRepository {
  Future<Usuario?> getUsuario();
  Future<void> guardarUsuario(Usuario usuario);
  Future<void> limpiar();
}
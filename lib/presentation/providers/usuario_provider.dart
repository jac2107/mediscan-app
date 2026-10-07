import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicamentos_app/core/constants/app_constants.dart';

final usuarioNombreProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(AppConstants.keyUsuarioNombre) ?? 'Usuario';
});

final usuarioIdProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(AppConstants.keyUsuarioId) ?? '';
});
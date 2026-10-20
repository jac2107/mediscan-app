class AppConstants {
  AppConstants._();

  static const String appName = 'Farmafolio';
  static const String dbName = 'medicamentos.db';
  static const int dbVersion = 1;

  // SharedPreferences keys
  static const String keyUsuarioNombre = 'usuario_nombre';
  static const String keyUsuarioId = 'usuario_id';
  static const String keyOnboardingDone = 'onboarding_done';
  static const String keyPendingSync = 'pending_sync';

  // Límites
  static const int maxHistorial = 50;
  static const int maxSugerencias = 8;
}

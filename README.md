# Farmafolio

Aplicación Flutter de consulta de medicamentos para personal de enfermería.

Esta entrega parte de `jac2107/mediscan-app`, rama `main`, commit
`d3ee02ceef2f54cb682839c55c521538a49a5259` (última versión verificada el 23/10/2026).
Incluye las plataformas, recursos, fuentes, precarga local y pruebas del proyecto.

## Preparación

Entorno utilizado: Flutter 3.35.7 / Dart 3.9.2. Usa esta versión o una compatible
con el archivo `pubspec.lock` incluido. Android requiere Java y Android SDK
configurados; se conserva la configuración Gradle y NDK original.

```sh
flutter pub get
flutter analyze --no-fatal-infos
flutter test
flutter run
```

En Linux, las pruebas de Drift necesitan la biblioteca de desarrollo SQLite 3
(`libsqlite3-dev` en Debian/Ubuntu). No se necesita para usar la app Android.

## Generar el APK desde consola

Desde esta carpeta, con Android SDK instalado y las licencias aceptadas:

```sh
flutter doctor -v
flutter pub get
flutter build apk --release
```

Salida: `build/app/outputs/flutter-apk/app-release.apk`.
Para comprobar una instalación de desarrollo: `flutter build apk --debug`.
La configuración original de release utiliza la firma de debug: configura tu
firma de distribución antes de publicar en una tienda.

## Aplicar la entrega

Extrae la carpeta completa. Si la copias sobre tu checkout, conserva la carpeta
`.git` y tus configuraciones locales de SDK y firma. No hace falta ejecutar SQL,
cambiar el esquema de la base de datos ni regenerar datos.
No se incluyen cachés, compilados ni rutas locales del entorno de trabajo.

Consulta `Docs/ESTILO_APROBADO.md` para conocer los cambios y su validación.

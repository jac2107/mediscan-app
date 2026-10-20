# Farmafolio — Cambios de interfaz y retirada de aplicabilidad

## Resultado

Se aplicó la paleta exacta de la guía (marfil #FBF8EF, verde #304B40, tinta #262B28 y superficies #ECEDE5), con fuentes Lora e Inter empaquetadas localmente. Se conservaron el catálogo, la búsqueda, la navegación, los favoritos, el historial, las dosis y las pestañas Ficha/Dosis/Seguridad. La pestaña Grupos se retiró porque pertenecía a la aplicabilidad.

El logo proporcionado aparece en la cabecera del catálogo. Android muestra el nombre Farmafolio e incluye el icono proporcionado en cinco densidades y en formato adaptable. No se sustituyó el identificador Android existente, para conservar la continuidad de instalación de la aplicación.

El buscador conserva el texto y los filtros al volver de una ficha. Se revisaron el estado vacío, los mensajes de error, el indicador de actualización, la desconexión y los estados existentes del micrófono. Los controles utilizan áreas táctiles amplias, radios de 8–12, respuesta hover/presionado/foco y etiquetas accesibles. No se incorporaron destinos nuevos de navegación.

## Aplicabilidad encontrada y eliminada

- Consulta remota de `medicamento_grupos` y lectura de estados en los payloads.
- Tabla local, modelos generados, métodos de acceso y provider de grupos.
- Precarga y consulta SQL interna del recurso inicial.
- Estado de aplicabilidad en filtros y pestaña Grupos en la ficha.
- Campos de estado en el modelo de filtros.

El filtro por paciente se conserva consultando las columnas de dosis: adultos, adultos mayores, niños y lactantes. Permite OR entre grupos y AND con las demás categorías. Excluye dosis vacías y marcadores de ausencia; no interpreta la presencia de una dosis como seguridad, indicación o aptitud clínica. Los textos originales de dosis no se modificaron, incluso cuando contienen «No aplicable».

La base local pasa de versión 3 a 4. La migración elimina únicamente la tabla retirada para una instalación de la versión 3 recibida; conserva medicamentos, favoritos, historial y metadatos de actualización. Se mantiene el nombre físico de la base local para no crear una base vacía al actualizar.

## Dependencias y recursos

Se retiró Google Fonts como dependencia de red y se registraron las fuentes locales con sus licencias. Se mantuvo el ajuste de dependencias de desarrollo discutido en el chat: los generadores/lints incompatibles se retiraron del pubspec y los archivos `.g.dart` entregados están sincronizados con el modelo actual. Para futuros cambios de esquema, se deberá usar una combinación compatible de Drift y sus herramientas de generación antes de regenerarlos.

No se cambiaron la URL ni la clave pública de Supabase, las políticas RLS, las tablas remotas ni el panel web. Este trabajo modifica el cliente Flutter. La consulta ya no solicita la relación retirada.

## Verificación

- **APK de depuración compilado correctamente** (`flutter build apk --debug`), con Flutter 3.29.3 / Dart 3.7.2, JDK 17, Gradle 8.10.2 y herramientas Android 34/35. Se completaron las dependencias del entorno de validación sin alterar la configuración Gradle del proyecto.
- Verificación del APK generado: etiqueta Android Farmafolio, iconos por densidad y adaptables; logo, seis archivos de fuentes, sus licencias y las 100 fichas dentro del paquete.
- **Siete pruebas automatizadas correctas.**
- Las 100 fichas precargadas conservan todos sus datos originales, salvo las estructuras retiradas de grupos.
- Pruebas automatizadas: presencia/ausencia de dosis; precarga offline de 100 fichas sin duplicados; migración v3→v4 con conservación de dosis, favoritos, historial y cursor; OR/AND en filtros; búsqueda/estado vacío/navegación; estados visuales de micrófono; ficha con texto ampliado a 180 %.
- Las pruebas de base de datos utilizan SQLite nativo en el equipo de pruebas; al ejecutarlas en otra computadora se necesita la biblioteca SQLite disponible para ese sistema.
- Capturas de las vistas renderizadas con Flutter: `test/goldens/`. Son datos de prueba visual, no contenido farmacológico agregado al catálogo.
- Análisis estático: sin errores de Dart. El análisis completo informó 1 advertencia por una importación sin uso y 23 avisos informativos de estilo/deprecación; no se hicieron cambios ajenos al alcance para silenciarlos.
- La herramienta Android `aapt2` compiló correctamente los recursos del icono; se verificaron el nombre Farmafolio y las referencias del manifiesto.
- Los permisos nativos de micrófono, el reconocimiento real de voz, la instalación del icono en cada lanzador y la sincronización contra Supabase requieren una prueba final en Android físico. No se afirma haber realizado esas pruebas físicas.

## Uso en tu equipo

Extrae la carpeta y abre la que contiene `pubspec.yaml`. No copies carpetas `build` o `.dart_tool` de otra computadora. Para incorporar estos cambios a tu repositorio, conserva la carpeta `.git` de tu clon original y copia los archivos entregados sobre él.

```bash
flutter pub get
flutter build apk --debug
```

El APK de prueba se genera en `build/app/outputs/flutter-apk/app-debug.apk`.

## Archivos modificados respecto al ZIP recibido

- `android/app/src/main/AndroidManifest.xml`
- `android/app/src/main/res/mipmap-hdpi/ic_launcher.png`
- `android/app/src/main/res/mipmap-mdpi/ic_launcher.png`
- `android/app/src/main/res/mipmap-xhdpi/ic_launcher.png`
- `android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png`
- `android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png`
- `assets/data/seed_medicamentos.json`
- `assets/data/tools/generar_seed.py`
- `lib/app.dart`
- `lib/core/constants/app_constants.dart`
- `lib/core/theme/app_theme.dart`
- `lib/data/local/database/app_database.dart`
- `lib/data/local/database/app_database.g.dart`
- `lib/data/local/seed/seed_loader.dart`
- `lib/domain/entities/filtros.dart`
- `lib/presentation/providers/connectivity_provider.dart`
- `lib/presentation/providers/medicamentos_provider.dart`
- `lib/presentation/providers/sync_provider.dart`
- `lib/presentation/providers/voz_provider.dart`
- `lib/presentation/screens/catalogo/catalogo_screen.dart`
- `lib/presentation/screens/favoritos/favoritos_screen.dart`
- `lib/presentation/screens/historial/historial_screen.dart`
- `lib/presentation/screens/medicamento/medicamento_detail_screen.dart`
- `lib/presentation/widgets/common/error_widget.dart`
- `lib/presentation/widgets/common/sync_indicator.dart`
- `lib/presentation/widgets/filtros/filtros_sheet.dart`
- `lib/presentation/widgets/main_scaffold.dart`
- `lib/presentation/widgets/medicamento/medicamento_card.dart`
- `pubspec.lock`
- `pubspec.yaml`

## Archivos añadidos

- `android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml`
- `android/app/src/main/res/mipmap-hdpi/ic_launcher_foreground.png`
- `android/app/src/main/res/mipmap-mdpi/ic_launcher_foreground.png`
- `android/app/src/main/res/mipmap-xhdpi/ic_launcher_foreground.png`
- `android/app/src/main/res/mipmap-xxhdpi/ic_launcher_foreground.png`
- `android/app/src/main/res/mipmap-xxxhdpi/ic_launcher_foreground.png`
- `android/app/src/main/res/values/colors.xml`
- `assets/brand/farmafolio-icon.png`
- `assets/brand/farmafolio-logo.png`
- `assets/fonts/Inter-Bold.ttf`
- `assets/fonts/Inter-Medium.ttf`
- `assets/fonts/Inter-OFL.txt`
- `assets/fonts/Inter-Regular.ttf`
- `assets/fonts/Inter-SemiBold.ttf`
- `assets/fonts/Lora-Bold.ttf`
- `assets/fonts/Lora-OFL.txt`
- `assets/fonts/Lora-Regular.ttf`
- `lib/core/search/dosis_filter.dart`
- `lib/core/theme/app_fonts.dart`
- `lib/presentation/widgets/common/brand_mark.dart`
- `lib/presentation/widgets/common/editorial_notice.dart`
- `test/farmafolio_test.dart`
- `test/goldens/catalogo.png`
- `test/goldens/favoritos.png`
- `test/goldens/ficha.png`
- `test/goldens/filtros.png`
- `test/goldens/historial.png`
- `test/goldens/microfono.png`

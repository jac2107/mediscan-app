# Farmafolio: filtros, imagen e inicio

Base: https://github.com/jac2107/mediscan-app, commit `bca4a7f`.
Referencia de datos: `medicamentos_rows_estandarizados.csv`, 100 medicamentos.

## Filtros

- SQLite guarda los campos múltiples como texto JSON. El lector admite listas, JSON serializado y valores escalares; no compara un arreglo entero con una cadena.
- Coincidencia exacta por elemento, con normalización de espacios, mayúsculas y tildes únicamente para comparar. No se usan subcadenas para los filtros duros. El buscador conserva su búsqueda tolerante existente.
- OR dentro de cada selección múltiple y AND entre categorías, con buscador y ordenamiento existentes.
- Principios activos: reconoce los alias vitamínicos B1/B6/B12 sin confundir distintas sales. Tiamina clorhidrato encuentra también el medicamento combinado MED-072.
- Opciones deduplicadas con las mismas claves usadas para filtrar. Se reconocen las variantes antiguas de listas agrupadas presentes en el seed, sin modificarlo ni cambiar la información clínica mostrada.
- Las opciones dependen del catálogo en memoria y se actualizan al sincronizar. Se corrige también la invalidación de vistas tras la primera descarga completa.

## Grupos de edad: criterio documental

Se incluye un medicamento si la columna del grupo documenta una cantidad/pauta explícita o una referencia explícita al mismo esquema, dosis o pauta. No se calcula ni se deduce ninguna dosis.

Se excluyen campos vacíos, falta de información, prohibiciones o recomendaciones negativas sin una pauta positiva y textos ambiguos. Una restricción parcial se conserva cuando otra cláusula documenta una pauta: por ejemplo, MED-002 en lactantes y MED-021/MED-042 en pediatría. Aparecer no significa que corresponda a todas las edades del grupo.

Las referencias a mujeres en lactancia o posparto dentro de `dosis_lactantes` no se toman como dosis para bebés. Los textos generales como «bajo indicación pediátrica» o «ajustar según función renal» sin pauta explícita quedan fuera del filtro para revisión. No se reincorpora tabla, campo ni estado de aplicabilidad.

`REVISION_DOSIS.md` enumera los 68 textos que requieren revisión y los resultados de las 400 celdas. El texto original permanece visible en la ficha. Puede reproducirse con `dart run tool/auditar_dosis.dart`.

## Imagen y visor

- Imagen inicial centrada de 180 px; transición continua mediante el desplazamiento a la fila compacta de 64 px. Al volver al inicio se expande. El encabezado puede salir del área visible, como antes, para no bloquear la lectura con textos grandes.
- Imagen con `BoxFit.contain`, tamaño reservado durante la carga y sustituto ante ausencia/error.
- Visor modal con imagen completa, cierre visible, Escape y Atrás; foco inicial en el cierre y barrera modal que bloquea la interacción con el fondo.
- Se conservan los colores, Lora, Inter, tres pestañas, favoritos, historial y demás funciones.

## Inicio

La primera pantalla Flutter se dibuja antes de preparar SQLite y Supabase. La carga termina al completarse la inicialización; no tiene una duración mínima artificial. Se conserva el seed existente y se cierra la conexión temporal a la BD.

La inicialización remota tiene un límite de 12 segundos. Si falla, ofrece reintentar o entrar al catálogo local. En modo local, el botón de actualización vuelve a intentar la inicialización. Si falla la preparación de SQLite, muestra el error con reintento, sin abrir un catálogo incompleto.

Se armonizan los temas nativos Android, incluidos Android 12+ y modo oscuro, con el fondo crema y el icono existente. No se añade una segunda dependencia de splash. Se retira del pubspec la referencia a `assets/images/`, carpeta que no existe en el repositorio.

## Archivos principales

- `lib/core/search/filter_values.dart`: lectura, alias y comparación de filtros.
- `lib/core/search/dosis_filter.dart`: clasificación documental de dosis.
- `lib/presentation/providers/medicamentos_provider.dart`: filtros, opciones y selecciones.
- `lib/presentation/providers/sync_provider.dart`: actualización de vistas tras sincronizar.
- `lib/presentation/widgets/filtros/filtros_sheet.dart`: selecciones y explicación del filtro por edad.
- `lib/presentation/screens/medicamento/medicamento_detail_screen.dart`: encabezado adaptable y carga de fotografía.
- `lib/presentation/widgets/medicamento/image_viewer.dart`: visor modal.
- `lib/main.dart`, `lib/app.dart`, `lib/presentation/screens/inicio/inicio_app.dart`: arranque y recuperación.
- `android/app/src/main/res/drawable*/launch_background.xml`, `values*/styles.xml`, `values/colors.xml`: inicio nativo.
- `pubspec.yaml`: elimina recurso inexistente; no añade dependencias.
- `test/filtros_reales_test.dart`, `test/interacciones_test.dart`, `test/farmafolio_test.dart`, `test/fixtures/medicamentos_filtros.json`, `test/goldens/`: comprobaciones y capturas.
- `tool/auditar_dosis.dart`, `REVISION_DOSIS.md`: revisión reproducible del CSV.

## Verificación

- `flutter test --no-pub --update-goldens`: 18 tests aprobados (incluye el smoke heredado sin aserciones). Casos reales de los 100 registros, arrays, OR/AND, búsqueda, contadores, limpieza, dosis, seed y migración de favoritos/historial.
- Widgets en 390×844 y 1280×900; transición de 180 a 64 px y regreso, falta/error de imagen, imagen cargada mediante respuesta HTTP de prueba, `BoxFit.contain`, cierre visible, Escape, Atrás, foco y bloqueo del fondo.
- Inicio: espera del Future real, error local, reintento con estado de carga y entrada al catálogo local ante fallo remoto.
- `dart analyze lib test`: cero errores; quedan 1 advertencia heredada de importación sin uso y 33 avisos informativos de estilo/deprecaciones. No se declara el proyecto libre de avisos.
- `flutter build bundle --no-pub --target-platform=linux-x64`: compilación correcta del código Dart y los recursos. No es un APK ni un ejecutable de escritorio.
- Revisión visual de capturas de detalle expandido/compacto y visor; XML Android válido. Paleta, fuentes, recursos de marca, seed y esquema local idénticos al commit base.
- Las 400 dosis de la fixture coinciden exactamente con el CSV. No se modificaron datos de Supabase.
- Entorno de comprobación: Flutter 3.38.10 / Dart 3.10.9. Se conserva el lock recibido para evitar imponer una actualización ajena al cambio.

Para repetir en tu equipo: `flutter pub get`, `flutter test`, `dart analyze lib test`. Los tests de SQLite requieren la biblioteca SQLite nativa del sistema; en este entorno Linux se suministró desde la instalación existente. Las capturas golden pueden depender del motor y de las fuentes del entorno.

Los widgets se prueban en tamaños de móvil y escritorio. Esto no equivale a instalar el APK en un dispositivo ni a ejecutar una versión web: el repositorio no incluye un destino web configurado. No se han aplicado cambios a Supabase ni publicado commits en GitHub.

## Aplicar el proyecto

Descomprime el ZIP y copia su contenido sobre tu carpeta de trabajo conservando tu carpeta `.git` y la configuración local del SDK (`android/local.properties`). No contiene SDK, cachés, archivos de compilación ni APK. Ejecuta `flutter pub get` y después `flutter build apk --debug` en tu equipo Android.

## Inventario exacto de archivos modificados o nuevos

- `CAMBIOS_FILTROS_IMAGEN_INICIO.md`
- `REVISION_DOSIS.md`
- `android/app/src/main/res/drawable-v21/launch_background.xml`
- `android/app/src/main/res/drawable/launch_background.xml`
- `android/app/src/main/res/values-night-v31/styles.xml`
- `android/app/src/main/res/values-night/styles.xml`
- `android/app/src/main/res/values-v31/styles.xml`
- `android/app/src/main/res/values/colors.xml`
- `android/app/src/main/res/values/styles.xml`
- `lib/app.dart`
- `lib/core/search/dosis_filter.dart`
- `lib/core/search/filter_values.dart`
- `lib/main.dart`
- `lib/presentation/providers/medicamentos_provider.dart`
- `lib/presentation/providers/sync_provider.dart`
- `lib/presentation/screens/inicio/inicio_app.dart`
- `lib/presentation/screens/medicamento/medicamento_detail_screen.dart`
- `lib/presentation/widgets/filtros/filtros_sheet.dart`
- `lib/presentation/widgets/medicamento/image_viewer.dart`
- `pubspec.yaml`
- `test/farmafolio_test.dart`
- `test/filtros_reales_test.dart`
- `test/fixtures/medicamentos_filtros.json`
- `test/goldens/detalle_compacto_1280.png`
- `test/goldens/detalle_compacto_390.png`
- `test/goldens/detalle_expandido_1280.png`
- `test/goldens/detalle_expandido_390.png`
- `test/goldens/ficha.png`
- `test/goldens/filtros.png`
- `test/goldens/visor_imagen.png`
- `test/interacciones_test.dart`
- `tool/auditar_dosis.dart`

# Filtro de categorías — actualización

Trabajado sobre el proyecto del ZIP FarmafolioApp_actualizado anterior, conservando los cambios previos de filtros, imagen e inicio. No se ha publicado en GitHub ni ejecutado SQL en Supabase.

## Comportamiento

- Lee cada elemento de la lista JSON guardada en la columna TEXT `categoria`, compatible con el SQL actualizar_categorias_farmafolio.sql. No cambia el tipo de la columna ni la API.
- Selección múltiple: OR entre categorías; AND con los otros filtros y el buscador. Compara elementos completos, ignorando tildes, espacios y mayúsculas; evita opciones duplicadas.
- Las 89 etiquetas originales del CSV de 100 medicamentos tienen equivalencias explícitas a las mismas 62 categorías del SQL. Esto permite usar los filtros sin conexión con el catálogo local anterior y evita mezclar etiquetas antiguas y nuevas mientras se sincroniza. No aplica reglas clínicas ni interpreta palabras de categorías desconocidas: se conservan.
- Tarjetas y detalle muestran nombres separados por « · », sin la sintaxis JSON. El detalle calcula su altura con el mismo texto visible.
- La búsqueda y el orden por categoría utilizan el texto formateado. El lector antiguo AppDatabase.getCategorias también devuelve opciones individuales.
- No se modifican medicamentos, dosis, imágenes, marca ni estructura de la BD. No se añade aplicabilidad. El panel web es otro proyecto y no se modifica en este ZIP.

## Archivos de esta actualización

- lib/core/search/categorias_legadas.dart (nuevo: equivalencias del CSV/SQL).
- lib/core/search/filter_values.dart (lectura compatible y texto visible).
- lib/core/search/fuzzy_search.dart (búsqueda sobre categorías legibles).
- lib/data/local/database/app_database.dart (opciones individuales).
- lib/presentation/providers/medicamentos_provider.dart (orden por categoría legible).
- lib/presentation/widgets/medicamento/medicamento_card.dart (etiqueta).
- lib/presentation/screens/medicamento/medicamento_detail_screen.dart (etiqueta y altura).
- test/categorias_test.dart y test/fixtures/categorias_normalizadas.json (nuevos: 100 registros y equivalencias esperadas del SQL).
- test/interacciones_test.dart (tarjetas y detalle con categorías JSON en móvil/escritorio).

## Verificación

23 pruebas pasan: 18 anteriores y 5 nuevas. Incluyen los 100 registros en formato antiguo y JSON, las 62 opciones, coincidencia exacta, tildes/mayúsculas, OR/AND, contador, buscador, sin resultados, limpieza y textos legibles en tarjetas/fichas a 390×844 y 1280×900. Las comprobaciones visuales anteriores también pasan.

Análisis Dart sin errores; persiste la advertencia anterior de importación no utilizada en app_router.dart y sugerencias de estilo. Compilación Dart y recursos mediante `flutter build bundle --no-pub --target-platform=linux-x64` realizada; no equivale a generar un APK. No se probó sincronización en Supabase real ni instalación física de Android.

## Aplicar

Haz una copia de tu carpeta actual. Copia el contenido de FarmafolioApp sobre tu proyecto conservando tu carpeta .git y android/local.properties. Ejecuta `flutter pub get`, `flutter test` y `flutter build apk --release` en tu equipo. No necesitas borrar la base local. El SQL se ejecuta por separado en Supabase; esta actualización también admite las categorías originales mientras se descarga el catálogo actualizado.

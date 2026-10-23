# Estilo aprobado · implementación

## Cambios

- Se conserva Lora para títulos, Inter para lectura y la paleta crema original.
- Verdes coordinados para acciones, selección, favoritos, dosis y voz.
- Radios según función: tarjetas, botones, campos, chips, paneles y navegación.
- Un mismo botón de favorito en catálogo, favoritos y detalle; estados activo,
  inactivo, deshabilitado, hover, foco y pulsación, con área de 48 × 48 px.
- Tarjetas del catálogo con imagen, nombre, genérico, principios activos,
  concentraciones, formas, presentación, categorías y vías existentes.
- Dosis por edad con tarjetas verdes y texto clínico íntegro, seleccionable.
  Distribución adaptable: las columnas se apilan con texto grande o poco ancho.
- Micrófono con espacio reservado para los anillos, ondas ligadas al nivel real
  de sonido, transcripción real y estados de preparación, escucha y procesamiento.
  Los resultados parciales no ejecutan búsquedas. Los finales lo hacen una vez.
  Cancelar o cambiar de sección impide aplicar transcripciones de esa sesión.
- Visor ampliado con borde verde, fondo limpio, carga/error y cierre visible.
- Transiciones discretas sin escalado de tarjetas ni cambios de tamaño al hover;
  respeto de la preferencia del sistema para reducir animaciones.
- Estilos compartidos para filtros, desplegables, formularios y controles.

## Conservación funcional

Se comprobaron los hashes respecto al commit base: todos los archivos de
`lib/data`, `lib/domain` y `lib/core/search`, las fuentes y la precarga de datos
permanecen intactos. No se cambió la sincronización con Supabase, el esquema de
Drift, el algoritmo de búsqueda ni los criterios de filtros y grupos de dosis.
La persistencia de favoritos conserva sus llamadas originales.
Solo se ajustó el ciclo de presentación de voz para animación, cancelación y
protección contra resultados tardíos. Se corrigió además una importación ambigua
`isNull` de una prueba existente y una importación sin uso del router.

## Comprobaciones realizadas

Entorno: Flutter 3.35.7, Dart 3.9.2, Linux; 23/10/2026.

- `flutter test`: 43 pruebas aprobadas, incluidas las existentes de catálogo,
  búsqueda, filtros reales, dosis, precarga, favoritos, historial e imágenes.
- Pruebas nuevas: interacción de favoritos con ratón/teclado/táctil, geometría
  fija del micrófono, anillos dentro de sus límites, movimiento reducido,
  filtros abiertos/cerrados/seleccionados/limpios, borde y cierre del visor.
- Pruebas de voz con motor simulado: permiso denegado, motor no disponible,
  resultados parciales/finales, final tardío tras detener, cancelación durante
  permisos y escucha, errores y duplicados del resultado final.
- Pruebas adaptables a 320, 390 y 1024 px con texto al 180 %, y pruebas existentes
  del detalle/visor a 390 y 1280 px.
- Capturas de referencia actualizadas y revisadas visualmente; segunda ejecución
  de las 43 pruebas sin actualizar capturas: aprobada.
- `flutter analyze --no-fatal-infos`: sin errores ni advertencias; conserva
  36 recomendaciones informativas de estilo/API, detalladas por el analizador.
- `flutter build bundle --debug --no-pub`: compilación de código y recursos
  Flutter correcta.
- `flutter build apk --debug --no-pub`: bloqueado por ausencia de Android SDK en
  el entorno. NO se presenta la compilación nativa Android como verificada.

Las pruebas de voz no graban audio. Queda por verificar en un teléfono Android
el permiso real, el reconocedor del sistema, los niveles del micrófono y el APK.
Los comandos de preparación y APK están en README.md.

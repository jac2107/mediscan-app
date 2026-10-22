# Sincronización de catálogo y papelera

Base: `5e6a8a18e5c56bed2e72f30d3e59441c0661b609` de `jac2107/mediscan-app`.

Aplicar primero `supabase/04_panel_rpc.sql` y `05_papelera_y_catalogo.sql` del cambio del panel Farmafolio. La app utiliza la nueva RPC `catalogo_medicamentos_app()`; sin ella conserva su caché e informa error de sincronización.

Se unifica la conversión remota en `lib/data/models/medicamento_model.dart`. `MedicamentosRemote` solo lee la instantánea pública; ya no ofrece escrituras ni consulta fichas sin filtrar publicación. Usa `foto_path` (URL completa o Storage) o `medicamento_fuentes.imagen_origen_url` y mantiene los campos múltiples como arreglos.

`AppDatabase.aplicarCatalogoPublico` aplica toda la instantánea dentro de una transacción, mantiene favoritos de fichas vigentes y retira medicamentos ausentes de consultas, favoritos y fichas por ID. Descargas o conversiones fallidas no limpian la caché. Una instantánea válida vacía sí la vacía. La restauración remota reincorpora el mismo ID y código al volver a publicar/sincronizar; una ficha restaurada como borrador permanece fuera de Android.

`SyncNotifier` utiliza el mismo repositorio y no reproduce payloads históricos. Así evita resucitar eliminados, depender de un lote limitado de 200 eventos o perder cambios por el orden de commit de los cursores. Realtime se mantiene como señal; consulta también al reconectar, volver al primer plano, actualizar manualmente y cada minuto. Si llega un evento durante una sincronización, se procesa una nueva comprobación al terminar.

Se agregaron cinco tests de Drift/mapper en `test/catalogo_publico_test.dart`: retirar/restaurar fichas sin duplicar, acceso por ID, favoritos vigentes, transacción ante conflicto, instantánea vacía, arreglos e imágenes. No se pudieron ejecutar en el entorno de edición por falta de Flutter.

Verificación necesaria antes de distribuir:

```bash
flutter pub get
flutter analyze
flutter test
flutter build apk --release
```

Una APK sin conexión conserva los datos descargados y no puede enterarse de una baja hasta completar la siguiente sincronización. No se modificaron dosis, buscador, filtros ni estética de la app.

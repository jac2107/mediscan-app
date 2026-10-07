import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medicamentos_app/core/constants/app_constants.dart';
import 'package:medicamentos_app/data/local/database/app_database.dart';
import 'package:medicamentos_app/data/remote/supabase/audit_remote.dart';
import 'package:medicamentos_app/data/remote/supabase/medicamentos_remote.dart';
import 'package:medicamentos_app/presentation/providers/medicamentos_provider.dart';
import 'package:medicamentos_app/presentation/providers/favoritos_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class MedicamentoFormScreen extends ConsumerStatefulWidget {
  final String? medicamentoId;
  final String? codigoInicial;

  const MedicamentoFormScreen({
    super.key,
    this.medicamentoId,
    this.codigoInicial,
  });

  @override
  ConsumerState<MedicamentoFormScreen> createState() =>
      _MedicamentoFormScreenState();
}

class _MedicamentoFormScreenState
    extends ConsumerState<MedicamentoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  static const _uuid = Uuid();

  // Controladores
  final _codigoCtrl = TextEditingController();
  final _nombreCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();
  final _fotoUrlCtrl = TextEditingController();
  final _dosisAdultoCtrl = TextEditingController();
  final _dosisMayorCtrl = TextEditingController();
  final _dosisNinoCtrl = TextEditingController();

  // Listas dinámicas
  List<String> _alergias = [];
  List<String> _contraindicaciones = [];
  List<String> _enfermedades = [];

  bool _guardando = false;
  bool _esEdicion = false;
  MedicamentosTableData? _medOriginal;

  @override
  void initState() {
    super.initState();
    if (widget.codigoInicial != null) {
      _codigoCtrl.text = widget.codigoInicial!;
    }
    if (widget.medicamentoId != null) {
      _esEdicion = true;
      _cargarMedicamento();
    }
  }

  Future<void> _cargarMedicamento() async {
    final dao = ref.read(medicamentosDaoProvider);
    final todos = await dao.getAll();
    try {
      final med = todos.firstWhere((m) => m.id == widget.medicamentoId);
      setState(() {
        _medOriginal = med;
        _codigoCtrl.text = med.codigoBarras;
        _nombreCtrl.text = med.nombre;
        _descripcionCtrl.text = med.descripcion ?? '';
        _fotoUrlCtrl.text = med.fotoUrl ?? '';
        _dosisAdultoCtrl.text = med.dosisAdulto ?? '';
        _dosisMayorCtrl.text = med.dosisMayor ?? '';
        _dosisNinoCtrl.text = med.dosisNino ?? '';
        _alergias = AppDatabase.jsonToList(med.alergias);
        _contraindicaciones =
            AppDatabase.jsonToList(med.contraindicaciones);
        _enfermedades =
            AppDatabase.jsonToList(med.enfermedadesIncompatibles);
      });
    } catch (_) {}
  }

  @override
  void dispose() {
    _codigoCtrl.dispose();
    _nombreCtrl.dispose();
    _descripcionCtrl.dispose();
    _fotoUrlCtrl.dispose();
    _dosisAdultoCtrl.dispose();
    _dosisMayorCtrl.dispose();
    _dosisNinoCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _guardando = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final usuarioNombre =
          prefs.getString(AppConstants.keyUsuarioNombre) ?? 'Desconocido';
      final dispositivoId =
          prefs.getString(AppConstants.keyUsuarioId) ?? '';

      final dao = ref.read(medicamentosDaoProvider);
      final id = _esEdicion ? widget.medicamentoId! : _uuid.v4();
      final ahora = DateTime.now();

      final companion = MedicamentosTableCompanion(
        id: Value(id),
        codigoBarras: Value(_codigoCtrl.text.trim()),
        nombre: Value(_nombreCtrl.text.trim()),
        descripcion: Value(_descripcionCtrl.text.trim().isEmpty
            ? null
            : _descripcionCtrl.text.trim()),
        fotoUrl: Value(_fotoUrlCtrl.text.trim().isEmpty
            ? null
            : _fotoUrlCtrl.text.trim()),
        dosisAdulto: Value(_dosisAdultoCtrl.text.trim().isEmpty
            ? null
            : _dosisAdultoCtrl.text.trim()),
        dosisMayor: Value(_dosisMayorCtrl.text.trim().isEmpty
            ? null
            : _dosisMayorCtrl.text.trim()),
        dosisNino: Value(_dosisNinoCtrl.text.trim().isEmpty
            ? null
            : _dosisNinoCtrl.text.trim()),
        alergias: Value(jsonEncode(_alergias)),
        contraindicaciones: Value(jsonEncode(_contraindicaciones)),
        enfermedadesIncompatibles: Value(jsonEncode(_enfermedades)),
        actualizadoEn: Value(ahora),
        sincronizado: const Value(false),
      );

      // Guardar local
      await dao.upsert(companion);

      // Audit log
      final auditData = {
        'id': _uuid.v4(),
        'usuario_nombre': usuarioNombre,
        'dispositivo_id': dispositivoId,
        'accion': _esEdicion ? 'EDITAR' : 'CREAR',
        'tabla': 'medicamentos',
        'registro_id': id,
        'datos_antes': _esEdicion && _medOriginal != null
            ? {
                'nombre': _medOriginal!.nombre,
                'codigo_barras': _medOriginal!.codigoBarras,
              }
            : null,
        'datos_despues': {
          'nombre': _nombreCtrl.text.trim(),
          'codigo_barras': _codigoCtrl.text.trim(),
        },
        'fecha': ahora.toIso8601String(),
      };

      // Intentar subir a Supabase
      try {
        final remote = MedicamentosRemote();
        await remote.upsert({
          'id': id,
          'codigo_barras': _codigoCtrl.text.trim(),
          'nombre': _nombreCtrl.text.trim(),
          'descripcion': _descripcionCtrl.text.trim().isEmpty
              ? null
              : _descripcionCtrl.text.trim(),
          'foto_url': _fotoUrlCtrl.text.trim().isEmpty
              ? null
              : _fotoUrlCtrl.text.trim(),
          'dosis_adulto': _dosisAdultoCtrl.text.trim().isEmpty
              ? null
              : _dosisAdultoCtrl.text.trim(),
          'dosis_mayor': _dosisMayorCtrl.text.trim().isEmpty
              ? null
              : _dosisMayorCtrl.text.trim(),
          'dosis_nino': _dosisNinoCtrl.text.trim().isEmpty
              ? null
              : _dosisNinoCtrl.text.trim(),
          'alergias': _alergias,
          'contraindicaciones': _contraindicaciones,
          'enfermedades_incompatibles': _enfermedades,
          'actualizado_en': ahora.toIso8601String(),
          'eliminado': false,
        });
        await dao.marcarSincronizado(id);

        final auditRemote = AuditRemote();
        await auditRemote.registrar(auditData);
      } catch (_) {
        // Sin internet — queda en cola (sincronizado=false)
      }

      ref.invalidate(todosMedicamentosProvider);
      ref.invalidate(favoritosProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _esEdicion
                  ? 'Medicamento actualizado por $usuarioNombre'
                  : 'Medicamento creado por $usuarioNombre',
            ),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      setState(() => _guardando = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al guardar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _agregarItem(List<String> lista, String titulo) {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Agregar $titulo'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(hintText: titulo),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                setState(() => lista.add(ctrl.text.trim()));
              }
              Navigator.pop(context);
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  void _eliminarItem(List<String> lista, int index) {
    setState(() => lista.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_esEdicion ? 'Editar medicamento' : 'Nuevo medicamento'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sección info básica
              _Seccion(titulo: 'Información básica'),
              const SizedBox(height: 12),
              _Campo(
                ctrl: _codigoCtrl,
                label: 'Código de barras',
                icono: Icons.qr_code_rounded,
                requerido: true,
              ),
              const SizedBox(height: 12),
              _Campo(
                ctrl: _nombreCtrl,
                label: 'Nombre del medicamento',
                icono: Icons.medication_rounded,
                requerido: true,
                capitalizar: true,
              ),
              const SizedBox(height: 12),
              _Campo(
                ctrl: _descripcionCtrl,
                label: 'Descripción',
                icono: Icons.description_outlined,
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              _Campo(
                ctrl: _fotoUrlCtrl,
                label: 'URL de foto (opcional)',
                icono: Icons.image_outlined,
                teclado: TextInputType.url,
              ),

              const SizedBox(height: 24),
              _Seccion(titulo: 'Dosis'),
              const SizedBox(height: 12),
              _Campo(
                ctrl: _dosisAdultoCtrl,
                label: 'Dosis adultos',
                icono: Icons.person_rounded,
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              _Campo(
                ctrl: _dosisMayorCtrl,
                label: 'Dosis adultos mayores',
                icono: Icons.elderly_rounded,
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              _Campo(
                ctrl: _dosisNinoCtrl,
                label: 'Dosis niños',
                icono: Icons.child_care_rounded,
                maxLines: 2,
              ),

              const SizedBox(height: 24),
              _ListaDinamica(
                titulo: 'Alergias',
                icono: Icons.warning_amber_rounded,
                color: Colors.orange,
                items: _alergias,
                onAgregar: () => _agregarItem(_alergias, 'alergia'),
                onEliminar: (i) => _eliminarItem(_alergias, i),
              ),

              const SizedBox(height: 24),
              _ListaDinamica(
                titulo: 'Contraindicaciones',
                icono: Icons.block_rounded,
                color: Colors.red,
                items: _contraindicaciones,
                onAgregar: () =>
                    _agregarItem(_contraindicaciones, 'contraindicación'),
                onEliminar: (i) => _eliminarItem(_contraindicaciones, i),
              ),

              const SizedBox(height: 24),
              _ListaDinamica(
                titulo: 'Enfermedades incompatibles',
                icono: Icons.coronavirus_outlined,
                color: Colors.deepOrange,
                items: _enfermedades,
                onAgregar: () =>
                    _agregarItem(_enfermedades, 'enfermedad'),
                onEliminar: (i) => _eliminarItem(_enfermedades, i),
              ),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: _guardando ? null : _guardar,
                  child: _guardando
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          _esEdicion ? 'Guardar cambios' : 'Crear medicamento',
                          style: const TextStyle(fontSize: 16),
                        ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _Seccion extends StatelessWidget {
  final String titulo;
  const _Seccion({required this.titulo});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      titulo,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
    );
  }
}

class _Campo extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final IconData icono;
  final bool requerido;
  final bool capitalizar;
  final int maxLines;
  final TextInputType teclado;

  const _Campo({
    required this.ctrl,
    required this.label,
    required this.icono,
    this.requerido = false,
    this.capitalizar = false,
    this.maxLines = 1,
    this.teclado = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctrl,
      maxLines: maxLines,
      keyboardType: teclado,
      textCapitalization:
          capitalizar ? TextCapitalization.words : TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icono),
      ),
      validator: requerido
          ? (v) => (v == null || v.trim().isEmpty) ? 'Campo requerido' : null
          : null,
    );
  }
}

class _ListaDinamica extends StatelessWidget {
  final String titulo;
  final IconData icono;
  final Color color;
  final List<String> items;
  final VoidCallback onAgregar;
  final void Function(int) onEliminar;

  const _ListaDinamica({
    required this.titulo,
    required this.icono,
    required this.color,
    required this.items,
    required this.onAgregar,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icono, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              titulo,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: onAgregar,
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('Agregar'),
              style: TextButton.styleFrom(foregroundColor: color),
            ),
          ],
        ),
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Ninguna registrada',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        else
          ...items.asMap().entries.map(
                (e) => Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color.withOpacity(0.25)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(e.value, style: theme.textTheme.bodyMedium),
                      ),
                      GestureDetector(
                        onTap: () => onEliminar(e.key),
                        child: Icon(Icons.close_rounded,
                            size: 18, color: color),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
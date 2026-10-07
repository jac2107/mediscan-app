import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:medicamentos_app/core/constants/app_constants.dart';
import 'package:medicamentos_app/presentation/router/routes.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _guardando = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _guardarNombre() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _guardando = true);

    final prefs = await SharedPreferences.getInstance();
    final nombre = _controller.text.trim();
    final id = const Uuid().v4();

    await prefs.setString(AppConstants.keyUsuarioNombre, nombre);
    await prefs.setString(AppConstants.keyUsuarioId, id);
    await prefs.setBool(AppConstants.keyOnboardingDone, true);

    if (mounted) context.go(Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 32,
            right: 32,
            top: 32,
            bottom: MediaQuery.of(context).viewInsets.bottom + 32,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // Ícono
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(
                      Icons.medical_services_rounded,
                      size: 56,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Título
                Text(
                  'Bienvenido a\nMediScan',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Consulta información de medicamentos\nal instante, con o sin internet.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 48),

                // Campo nombre
                Text(
                  '¿Cuál es tu nombre?',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _controller,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    hintText: 'Ej. María González',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor ingresa tu nombre';
                    }
                    if (value.trim().length < 2) {
                      return 'El nombre debe tener al menos 2 caracteres';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => _guardarNombre(),
                ),
                const SizedBox(height: 24),

                // Botón
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: _guardando ? null : _guardarNombre,
                    child: _guardando
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Comenzar',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                // Nota
                Center(
                  child: Text(
                    'Tu nombre se usa solo para registrar\nquién realizó cada cambio.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
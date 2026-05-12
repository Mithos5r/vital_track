import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/firebase_auth/auth_repository_impl.dart';
import '../../domain/health_metrics/health_metric_entity.dart';
import '../../l10n/app_localizations.dart';
import '../dashboard/dashboard_notifier.dart';

class AddEntryScreen extends ConsumerStatefulWidget {
  const AddEntryScreen({super.key});

  @override
  ConsumerState<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends ConsumerState<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _heartRateController = TextEditingController();
  final _bloodOxygenController = TextEditingController();
  final _stepsController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _exerciseTypeController = TextEditingController();
  final _exerciseDurationController = TextEditingController();

  @override
  void dispose() {
    _heartRateController.dispose();
    _bloodOxygenController.dispose();
    _stepsController.dispose();
    _caloriesController.dispose();
    _exerciseTypeController.dispose();
    _exerciseDurationController.dispose();
    super.dispose();
  }

  Future<void> _submit(AppLocalizations l10n) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final hr = int.tryParse(_heartRateController.text);
    final bo = double.tryParse(_bloodOxygenController.text);
    final st = int.tryParse(_stepsController.text);
    final cal = int.tryParse(_caloriesController.text);
    final exType = _exerciseTypeController.text.trim();
    final exDur = int.tryParse(_exerciseDurationController.text);

    // Context.md requirement: Cannot save a completely empty form
    if (hr == null && bo == null && st == null && cal == null && exType.isEmpty && exDur == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.errorAtLeastOneField)),
      );
      return;
    }

    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;

    final metric = HealthMetricEntity(
      user: user.uid,
      timestamp: DateTime.now(),
      heartRate: hr,
      bloodOxygen: bo,
      steps: st,
      caloriesBurned: cal,
      exerciseType: exType.isEmpty ? null : exType,
      exerciseDuration: exDur,
    );

    await ref.read(dashboardProvider.notifier).addMetric(metric);
    
    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            onPressed: state.isLoading ? null : () => _submit(l10n),
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildNumericField(
                  controller: _heartRateController,
                  label: l10n.heartRate,
                  icon: Icons.favorite_outline,
                  l10n: l10n,
                ),
                const SizedBox(height: 16),
                _buildNumericField(
                  controller: _bloodOxygenController,
                  label: l10n.bloodOxygen,
                  icon: Icons.opacity,
                  isDecimal: true,
                  l10n: l10n,
                ),
                const SizedBox(height: 16),
                _buildNumericField(
                  controller: _stepsController,
                  label: l10n.steps,
                  icon: Icons.directions_walk,
                  l10n: l10n,
                ),
                const SizedBox(height: 16),
                _buildNumericField(
                  controller: _caloriesController,
                  label: l10n.calories,
                  icon: Icons.local_fire_department_outlined,
                  l10n: l10n,
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 24),
                Text(
                  l10n.exercise,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _exerciseTypeController,
                  decoration: InputDecoration(
                    labelText: l10n.exerciseType,
                    prefixIcon: const Icon(Icons.fitness_center),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      if (_exerciseDurationController.text.isNotEmpty) {
                        return l10n.fieldRequired;
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _exerciseDurationController,
                  decoration: InputDecoration(
                    labelText: l10n.exerciseDuration,
                    prefixIcon: const Icon(Icons.timer_outlined),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      if (_exerciseTypeController.text.isNotEmpty) {
                        return l10n.fieldRequired;
                      }
                      return null;
                    }
                    if (int.tryParse(value) == null) return l10n.invalidNumber;
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: state.isLoading ? null : () => _submit(l10n),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: state.isLoading
                      ? const CircularProgressIndicator()
                      : Text(l10n.save),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumericField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required AppLocalizations l10n,
    bool isDecimal = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: isDecimal),
      validator: (value) {
        if (value == null || value.isEmpty) return null;
        if (isDecimal) {
          if (double.tryParse(value) == null) return l10n.invalidNumber;
        } else {
          if (int.tryParse(value) == null) return l10n.invalidNumber;
        }
        return null;
      },
    );
  }
}

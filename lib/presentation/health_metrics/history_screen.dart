import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/health_metrics/health_metric_entity.dart';
import '../../l10n/app_localizations.dart';
import 'history_notifier.dart';

class HistoryScreen extends ConsumerWidget {
  final String param;

  const HistoryScreen({
    super.key,
    required this.param,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final historyAsync = ref.watch(historyProvider(param));
    
    final title = _getTitle(l10n);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: historyAsync.when(
        data: (metrics) {
          if (metrics.isEmpty) {
            return _EmptyHistory(l10n: l10n, paramName: title);
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: metrics.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final metric = metrics[index];
              return _HistoryItem(
                metric: metric,
                param: param,
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(err.toString())),
      ),
    );
  }

  String _getTitle(AppLocalizations l10n) {
    return switch (param) {
      'heartRate' => l10n.heartRate,
      'bloodOxygen' => l10n.bloodOxygen,
      'steps' => l10n.steps,
      'calories' => l10n.calories,
      'exercise' => l10n.exercise,
      _ => 'Historial',
    };
  }
}

class _HistoryItem extends StatelessWidget {
  final HealthMetricEntity metric;
  final String param;

  const _HistoryItem({
    required this.metric,
    required this.param,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    
    return Card(
      child: ListTile(
        title: _buildValueText(context),
        subtitle: Text(
          dateFormat.format(metric.timestamp),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: _getIcon(),
      ),
    );
  }

  Widget _buildValueText(BuildContext context) {
    if (param == 'exercise') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            metric.exerciseType ?? 'Desconocido',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '${metric.exerciseDuration ?? 0} min',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      );
    }

    final value = switch (param) {
      'heartRate' => '${metric.heartRate} bpm',
      'bloodOxygen' => '${metric.bloodOxygen}%',
      'steps' => '${metric.steps} pasos',
      'calories' => '${metric.caloriesBurned} kcal',
      _ => '--',
    };

    return Text(
      value,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _getIcon() {
    final iconData = switch (param) {
      'heartRate' => Icons.favorite,
      'bloodOxygen' => Icons.opacity,
      'steps' => Icons.directions_walk,
      'calories' => Icons.local_fire_department,
      'exercise' => Icons.fitness_center,
      _ => Icons.help_outline,
    };

    final color = switch (param) {
      'heartRate' => Colors.red,
      'bloodOxygen' => Colors.teal,
      'steps' => Colors.blue,
      'calories' => Colors.orange,
      'exercise' => Colors.purple,
      _ => Colors.grey,
    };

    return Icon(iconData, color: color);
  }
}

class _EmptyHistory extends StatelessWidget {
  final AppLocalizations l10n;
  final String paramName;

  const _EmptyHistory({
    required this.l10n,
    required this.paramName,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.history, size: 100, color: Colors.grey),
            const SizedBox(height: 24),
            Text(
              l10n.noDataHistory(paramName),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

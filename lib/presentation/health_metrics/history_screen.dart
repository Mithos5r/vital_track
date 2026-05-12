import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/constants/health_metrics_info.dart';
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
    
    final info = HealthMetricInfo.fromId(param);

    return Scaffold(
      appBar: AppBar(
        title: Text(info.getTitle(l10n)),
      ),
      body: historyAsync.when(
        data: (metrics) {
          if (metrics.isEmpty) {
            return _EmptyHistory(l10n: l10n, paramName: info.getTitle(l10n));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: metrics.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final metric = metrics[index];
              return Dismissible(
                key: Key('metric_${metric.id}'),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  if (metric.id != null) {
                    ref.read(historyProvider(param).notifier).deleteMetric(metric.id!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.recordDeleted)),
                    );
                  }
                },
                child: _HistoryItem(
                  metric: metric,
                  info: info,
                  l10n: l10n,
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(err.toString())),
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final HealthMetricEntity metric;
  final HealthMetricInfo info;
  final AppLocalizations l10n;

  const _HistoryItem({
    required this.metric,
    required this.info,
    required this.l10n,
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
        trailing: Icon(info.icon, color: info.iconColor),
      ),
    );
  }

  Widget _buildValueText(BuildContext context) {
    if (info is ExerciseInfo) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${metric.exerciseDuration ?? 0} ${info.getUnit(l10n)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            metric.exerciseType ?? 'Desconocido',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      );
    }

    final value = switch (info.id) {
      'heartRate' => '${metric.heartRate} ${info.getUnit(l10n)}',
      'bloodOxygen' => '${metric.bloodOxygen}${info.getUnit(l10n)}',
      'steps' => '${metric.steps} pasos',
      'calories' => '${metric.caloriesBurned} ${info.getUnit(l10n)}',
      _ => '--',
    };

    return Text(
      value,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
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

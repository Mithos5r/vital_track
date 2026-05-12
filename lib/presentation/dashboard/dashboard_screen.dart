import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../data/firebase_auth/auth_repository_impl.dart';
import '../../domain/health_metrics/health_metric_entity.dart';
import '../../l10n/app_localizations.dart';
import 'dashboard_notifier.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> with SingleTickerProviderStateMixin {
  late AnimationController _fabController;
  late Animation<double> _expandAnimation;
  bool _isFabExpanded = false;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      value: 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _fabController,
    );
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  void _toggleFab() {
    setState(() {
      _isFabExpanded = !_isFabExpanded;
      if (_isFabExpanded) {
        _fabController.forward();
      } else {
        _fabController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final metricsAsync = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeTitle, style: Theme.of(context).textTheme.headlineSmall),
        centerTitle: false,
      ),
      body: metricsAsync.when(
        data: (metrics) {
          if (metrics.isEmpty) {
            return _EmptyDashboard(l10n: l10n);
          }
          return _DashboardContent(metrics: metrics, l10n: l10n);
        },
        loading: () => Skeletonizer(
          enabled: true,
          child: _DashboardContent(
            metrics: [
              HealthMetricEntity(
                user: '',
                timestamp: DateTime.now(),
                heartRate: 80,
                steps: 5000,
                caloriesBurned: 300,
              )
            ],
            l10n: l10n,
          ),
        ),
        error: (err, stack) => Center(child: Text(err.toString())),
      ),
      floatingActionButton: _ExpandableFab(
        isExpanded: _isFabExpanded,
        animation: _expandAnimation,
        onToggle: _toggleFab,
        onAdd: () => context.push('/add-entry'),
        onLogout: () => ref.read(authRepositoryProvider).signOut(),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final List<HealthMetricEntity> metrics;
  final AppLocalizations l10n;

  const _DashboardContent({required this.metrics, required this.l10n});

  @override
  Widget build(BuildContext context) {
    // Basic calculation for the latest metrics summary
    final latest = metrics.first;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _BentoTile(
            title: l10n.heartRate,
            value: latest.heartRate?.toString() ?? '--',
            unit: 'bpm',
            icon: Icons.favorite,
            color: Colors.red.shade50,
            iconColor: Colors.red,
          ),
          _BentoTile(
            title: l10n.steps,
            value: latest.steps?.toString() ?? '--',
            unit: '',
            icon: Icons.directions_walk,
            color: Colors.blue.shade50,
            iconColor: Colors.blue,
          ),
          _BentoTile(
            title: l10n.calories,
            value: latest.caloriesBurned?.toString() ?? '--',
            unit: 'kcal',
            icon: Icons.local_fire_department,
            color: Colors.orange.shade50,
            iconColor: Colors.orange,
          ),
          _BentoTile(
            title: l10n.bloodOxygen,
            value: latest.bloodOxygen != null ? '${latest.bloodOxygen}%' : '--',
            unit: '',
            icon: Icons.opacity,
            color: Colors.teal.shade50,
            iconColor: Colors.teal,
          ),
          _BentoTile(
            title: l10n.exercise,
            value: latest.exerciseType ?? '--',
            unit: latest.exerciseDuration != null ? '${latest.exerciseDuration} min' : '',
            icon: Icons.fitness_center,
            color: Colors.purple.shade50,
            iconColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}

class _BentoTile extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final Color iconColor;

  const _BentoTile({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: iconColor),
                Text(unit, style: TextStyle(color: iconColor.withValues(alpha: 0.7), fontSize: 12)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: iconColor.withValues(alpha: 0.9),
                      ),
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: iconColor.withValues(alpha: 0.7),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyDashboard extends StatelessWidget {
  final AppLocalizations l10n;

  const _EmptyDashboard({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder SVG for empty state as per context.md
            const Icon(Icons.analytics_outlined, size: 100, color: Colors.grey),
            const SizedBox(height: 24),
            Text(
              l10n.noDataHome,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpandableFab extends StatelessWidget {
  final bool isExpanded;
  final Animation<double> animation;
  final VoidCallback onToggle;
  final VoidCallback onAdd;
  final VoidCallback onLogout;

  const _ExpandableFab({
    required this.isExpanded,
    required this.animation,
    required this.onToggle,
    required this.onAdd,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildFabItem(
          icon: Icons.logout,
          onPressed: onLogout,
          index: 1,
        ),
        const SizedBox(height: 16),
        _buildFabItem(
          icon: Icons.add,
          onPressed: onAdd,
          index: 0,
        ),
        const SizedBox(height: 16),
        FloatingActionButton(
          onPressed: onToggle,
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: animation,
          ),
        ),
      ],
    );
  }

  Widget _buildFabItem({required IconData icon, required VoidCallback onPressed, required int index}) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: FloatingActionButton.small(
          onPressed: () {
            onToggle();
            onPressed();
          },
          heroTag: 'fab_$index',
          child: Icon(icon),
        ),
      ),
    );
  }
}

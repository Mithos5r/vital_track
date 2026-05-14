import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/constants/health_metrics_info.dart';
import '../../data/firebase_auth/auth_repository_impl.dart';
import '../../data/health_metrics/health_repository_impl.dart';
import '../../domain/health_metrics/dashboard_summary.dart';
import '../../data/health_metrics/shared_prefs_data_source.dart';
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

  Future<void> _shareHistory(AppLocalizations l10n) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;

    final box = context.findRenderObject() as RenderBox?;
    final sharePositionOrigin = box != null ? box.localToGlobal(Offset.zero) & box.size : null;

    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    final json = await ref.read(exportHealthDataUseCaseProvider).execute(
          userId: user.uid,
          sinceDate: sevenDaysAgo,
        );

    if (json == '[]') {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.noDataHistory(''))),
        );
      }
      return;
    }

    await SharePlus.instance.share(
      ShareParams(
        text: json,
        subject: 'VitalTrack History (Last 7 Days)',
        sharePositionOrigin: sharePositionOrigin,
      ),
    );
  }

  void _showPermissionErrorDialog(AppLocalizations l10n) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(l10n.syncErrorTitle),
        content: Text(l10n.syncErrorMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.close),
          ),
          ElevatedButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            child: Text(l10n.settings),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final metricsAsync = ref.watch(dashboardProvider);

    // Watch sync status to show error dialog
    ref.listen(sharedPrefsDataSourceProvider, (previous, next) {
      next.whenData((prefs) {
        if (prefs.isSyncStopped()) {
          _showPermissionErrorDialog(l10n);
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeTitle, style: Theme.of(context).textTheme.headlineSmall),
        centerTitle: false,
        actions: [
          IconButton(
            key: const Key('add-entry-button'),
            icon: const Icon(Icons.add),
            tooltip: l10n.save,
            onPressed: () => context.push('/add-entry'),
          ),
        ],
      ),
      body: metricsAsync.when(
        data: (metrics) {
          if (metrics.isEmpty) {
            return _EmptyDashboard(l10n: l10n);
          }

          final summary = DashboardSummary.fromHistory(metrics);

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _MetricTile(
                      info: const HeartRateInfo(),
                      value: summary.heartRate?.toString() ?? '--',
                      l10n: l10n,
                    ),
                    _MetricTile(
                      info: const StepsInfo(),
                      value: summary.steps?.toString() ?? '--',
                      l10n: l10n,
                    ),
                    _MetricTile(
                      info: const CaloriesInfo(),
                      value: summary.caloriesBurned?.toString() ?? '--',
                      l10n: l10n,
                    ),
                    _MetricTile(
                      info: const BloodOxygenInfo(),
                      value: summary.bloodOxygen != null ? '${summary.bloodOxygen}' : '--',
                      l10n: l10n,
                    ),
                    _MetricTile(
                      info: const SleepInfo(),
                      value: summary.sleep != null ? (summary.sleep! / 60).toStringAsFixed(1) : '--',
                      l10n: l10n,
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverToBoxAdapter(
                  child: _MetricTile(
                    info: const ExerciseInfo(),
                    value: summary.exerciseDuration?.toString() ?? '--',
                    subtitle: summary.exerciseType,
                    isFullWidth: true,
                    l10n: l10n,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)), // Space for FAB
            ],
          );
        },
        loading: () => Skeletonizer(
          enabled: true,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: List.generate(
                    4,
                    (index) => _MetricTile(
                      info: const HeartRateInfo(),
                      value: '00',
                      l10n: l10n,
                    ),
                  ),
                ),
              ),
            ],
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
        onShare: () => _shareHistory(l10n),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final HealthMetricInfo info;
  final String value;
  final String? subtitle;
  final bool isFullWidth;
  final AppLocalizations l10n;

  const _MetricTile({
    required this.info,
    required this.value,
    this.subtitle,
    this.isFullWidth = false,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: info.backgroundColor,
      child: InkWell(
        onTap: () => context.push('/history/${info.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(info.icon, color: info.iconColor),
                  Text(
                    isFullWidth ? (subtitle ?? '') : info.getUnit(l10n),
                    style: TextStyle(
                      color: info.iconColor.withValues(alpha: 0.7),
                      fontSize: 14,
                      fontWeight: isFullWidth ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        value,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: info.iconColor.withValues(alpha: 0.9),
                            ),
                      ),
                      if (isFullWidth) ...[
                        const SizedBox(width: 4),
                        Text(
                          info.getUnit(l10n),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: info.iconColor.withValues(alpha: 0.7),
                              ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    info.getTitle(l10n),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: info.iconColor.withValues(alpha: 0.7),
                        ),
                  ),
                ],
              ),
            ],
          ),
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
  final VoidCallback onShare;

  const _ExpandableFab({
    required this.isExpanded,
    required this.animation,
    required this.onToggle,
    required this.onAdd,
    required this.onLogout,
    required this.onShare,
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
          index: 2,
        ),
        const SizedBox(height: 16),
        _buildFabItem(
          icon: Icons.share,
          onPressed: onShare,
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

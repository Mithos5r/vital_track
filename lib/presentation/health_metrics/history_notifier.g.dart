// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HistoryNotifier)
final historyProvider = HistoryNotifierFamily._();

final class HistoryNotifierProvider
    extends $StreamNotifierProvider<HistoryNotifier, List<HealthMetricEntity>> {
  HistoryNotifierProvider._({
    required HistoryNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'historyProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$historyNotifierHash();

  @override
  String toString() {
    return r'historyProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  HistoryNotifier create() => HistoryNotifier();

  @override
  bool operator ==(Object other) {
    return other is HistoryNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$historyNotifierHash() => r'd6b5859d61a61ff4182686db3c74f7aba40e508b';

final class HistoryNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          HistoryNotifier,
          AsyncValue<List<HealthMetricEntity>>,
          List<HealthMetricEntity>,
          Stream<List<HealthMetricEntity>>,
          String
        > {
  HistoryNotifierFamily._()
    : super(
        retry: null,
        name: r'historyProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HistoryNotifierProvider call(String param) =>
      HistoryNotifierProvider._(argument: param, from: this);

  @override
  String toString() => r'historyProvider';
}

abstract class _$HistoryNotifier
    extends $StreamNotifier<List<HealthMetricEntity>> {
  late final _$args = ref.$arg as String;
  String get param => _$args;

  Stream<List<HealthMetricEntity>> build(String param);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<HealthMetricEntity>>,
              List<HealthMetricEntity>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<HealthMetricEntity>>,
                List<HealthMetricEntity>
              >,
              AsyncValue<List<HealthMetricEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

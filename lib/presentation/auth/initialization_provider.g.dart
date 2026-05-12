// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initialization_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InitializationNotifier)
final initializationProvider = InitializationNotifierProvider._();

final class InitializationNotifierProvider
    extends $AsyncNotifierProvider<InitializationNotifier, void> {
  InitializationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initializationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$initializationNotifierHash();

  @$internal
  @override
  InitializationNotifier create() => InitializationNotifier();
}

String _$initializationNotifierHash() =>
    r'43873a49b94a602ba53c1b8ee882536e71a6b6b1';

abstract class _$InitializationNotifier extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

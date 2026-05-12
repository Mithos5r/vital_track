// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_prefs_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sharedPrefsDataSource)
final sharedPrefsDataSourceProvider = SharedPrefsDataSourceProvider._();

final class SharedPrefsDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<SharedPreferencesDataSource>,
          SharedPreferencesDataSource,
          FutureOr<SharedPreferencesDataSource>
        >
    with
        $FutureModifier<SharedPreferencesDataSource>,
        $FutureProvider<SharedPreferencesDataSource> {
  SharedPrefsDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPrefsDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPrefsDataSourceHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferencesDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferencesDataSource> create(Ref ref) {
    return sharedPrefsDataSource(ref);
  }
}

String _$sharedPrefsDataSourceHash() =>
    r'841ccec12505c57496db590eb0654e12ea0f5c8d';

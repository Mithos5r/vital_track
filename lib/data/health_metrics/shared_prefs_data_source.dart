import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shared_prefs_data_source.g.dart';

class SharedPreferencesDataSource {
  final SharedPreferences _prefs;

  SharedPreferencesDataSource(this._prefs);

  static const _lastSyncKey = 'last_sync_timestamp';
  static const _stopSyncKey = 'stop_background_sync';

  int? getLastSyncTimestamp() {
    return _prefs.getInt(_lastSyncKey);
  }

  Future<void> setLastSyncTimestamp(int timestamp) async {
    await _prefs.setInt(_lastSyncKey, timestamp);
  }

  bool isSyncStopped() {
    return _prefs.getBool(_stopSyncKey) ?? false;
  }

  Future<void> setSyncStopped(bool stopped) async {
    await _prefs.setBool(_stopSyncKey, stopped);
  }
}

@riverpod
Future<SharedPreferencesDataSource> sharedPrefsDataSource(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  return SharedPreferencesDataSource(prefs);
}

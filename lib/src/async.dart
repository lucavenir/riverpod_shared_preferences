import "dart:async";
import "dart:convert";

import "package:meta/meta.dart";
import "package:riverpod/experimental/persist.dart";
import "package:riverpod_shared_preferences/src/helpers.dart";
import "package:riverpod_shared_preferences/src/models/persisted_sp_value.dart";
import "package:shared_preferences/shared_preferences.dart";

/// a [Storage] that stores data in a [SharedPreferencesAsync] using JSON.
///
/// This is generally used in combination `riverpod_annotation's` `JsonPersist`.
final class JsonSharedPreferencesAsyncStorage extends Storage<String, String> {
  /// initializes the storage and deletes expired keys before returning
  factory JsonSharedPreferencesAsyncStorage.open() {
    final sharedPreferences = SharedPreferencesAsync();
    final instance = JsonSharedPreferencesAsyncStorage._(sharedPreferences);
    return instance;
  }

  JsonSharedPreferencesAsyncStorage._(this.prefs) : super();

  /// the underlying [SharedPreferencesAsync] instance;
  /// shouldn't be directly tampered with
  @internal
  @protected
  @visibleForTesting
  final SharedPreferencesAsync prefs;

  @override
  Future<void> deleteOutOfDate() async {
    final keys = await prefs.getKeys();
    final values = await keys.map(prefs.getString).wait;
    await values.nonNulls
        .map(jsonDecode)
        .map((e) => e as Map<String, Object?>)
        .map(PersistedSpValue.fromJson)
        .where(PersistedSpValue.isExpired)
        .map((e) => e.key)
        .map(prefs.remove)
        .wait;
  }

  @override
  Future<void> delete(String key) async {
    final riverpodKey = Helpers.computeRiverpodKey(key);
    final _ = await prefs.remove(riverpodKey);
  }

  @override
  Future<PersistedData<String>?> read(String key) async {
    final riverpodKey = Helpers.computeRiverpodKey(key);
    final encoded = await prefs.getString(riverpodKey);
    if (encoded == null) return null;
    final decoded = jsonDecode(encoded) as Map<String, Object?>;
    final mapped = PersistedSpValue.fromJson(decoded);

    return PersistedData(
      mapped.data,
      destroyKey: mapped.destroyKey,
      expireAt: mapped.expiresAt,
    );
  }

  @override
  Future<void> write(String key, String value, StorageOptions options) async {
    final ttl = options.cacheTime.duration;
    final riverpodKey = Helpers.computeRiverpodKey(key);
    final expiresAt = Helpers.computeExpirationTime(ttl: ttl);

    final persist = PersistedSpValue(
      key: riverpodKey,
      data: value,
      expiresAt: expiresAt,
      destroyKey: options.destroyKey,
    );
    final encoded = jsonEncode(persist.toJson());

    await prefs.setString(riverpodKey, encoded);
  }
}

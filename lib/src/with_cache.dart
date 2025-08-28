import "dart:async";
import "dart:convert";

import "package:meta/meta.dart";
import "package:riverpod/experimental/persist.dart";
import "package:riverpod_shared_preferences/src/helpers.dart";
import "package:riverpod_shared_preferences/src/models/persisted_sp_value.dart";
import "package:shared_preferences/shared_preferences.dart";

/// a [Storage] that stores data in a [SharedPreferencesWithCache] using JSON.
///
/// This is generally used in combination `riverpod_annotation's` `JsonPersist`.
final class JsonSharedPreferencesWithCacheStorage
    extends Storage<String, String> {
  JsonSharedPreferencesWithCacheStorage._(this.prefs) : super();

  /// the underlying [SharedPreferencesWithCache] instance;
  /// shouldn't be directly tampered with
  @internal
  @protected
  @visibleForTesting
  final SharedPreferencesWithCache prefs;

  /// initializes the storage and deletes expired keys before returning
  static Future<JsonSharedPreferencesWithCacheStorage> open() async {
    final sharedPreferences = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
    final instance = JsonSharedPreferencesWithCacheStorage._(sharedPreferences);
    return instance;
  }

  @override
  Future<void> deleteOutOfDate() async {
    await prefs.keys
        .map(prefs.getString)
        .nonNulls
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
    final encoded = prefs.getString(riverpodKey);
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

import "package:fake_async/fake_async.dart";
import "package:flutter_test/flutter_test.dart";
import "package:riverpod/experimental/persist.dart";
import "package:riverpod_shared_preferences/src/async.dart";
import "package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart";
import "package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart";

void main() {
  group("JsonSharedPreferencesAsyncStorage", () {
    late JsonSharedPreferencesAsyncStorage storage;
    const ttl = Duration(days: 1);
    const options = StorageOptions(cacheTime: StorageCacheTime(ttl));

    setUp(() {
      SharedPreferencesAsyncPlatform.instance =
          InMemorySharedPreferencesAsync.empty();
      storage = JsonSharedPreferencesAsyncStorage.open();
    });

    test("clears expired keys on creation", () {
      FakeAsync().run((async) async {
        await storage.write("expired", "value", options);
        final ttl2 = ttl + const Duration(days: 1);
        final options2 = StorageOptions(cacheTime: StorageCacheTime(ttl2));
        await storage.write("maintained", "value", options2);

        async.elapse(ttl);

        final aliveKeys = await storage.prefs.getKeys();
        expect(aliveKeys, hasLength(1));
        expect(aliveKeys.single, equals("maintained"));

        final result = await storage.prefs.getString(aliveKeys.single);
        expect(result, equals("value"));
      });
    });

    test("returns null on unknown keys", () async {
      await expectLater(storage.read("key"), completion(isNull));
    });

    test("returns the value if it exists", () async {
      await storage.write("key", "value", options);

      final result = storage.read("key");

      await expectLater(
        result,
        completion(
          isA<PersistedData<String>>().having(
            (e) => e.data,
            "value",
            equals("value"),
          ),
        ),
      );
    });

    test("returns null after a delete", () async {
      await storage.write("key", "value", options);

      await storage.delete("key");

      final result = storage.read("key");
      await expectLater(result, completion(isNull));
    });
  });
}

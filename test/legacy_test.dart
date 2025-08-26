import 'package:fake_async/fake_async.dart';
import 'package:riverpod/experimental/persist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_shared_preferences/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('LegacyJsonSharedPreferencesStorage', () {
    late LegacyJsonSharedPreferencesStorage storage;
    const ttl = Duration(days: 1);
    const options = StorageOptions(cacheTime: StorageCacheTime(ttl));

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      storage = await LegacyJsonSharedPreferencesStorage.open();
    });

    test('Clears expired keys on creation', () async {
      FakeAsync().run((async) async {
        await storage.write('expired', 'value', options);
        final ttl2 = ttl + Duration(days: 1);
        final options2 = StorageOptions(cacheTime: StorageCacheTime(ttl2));
        await storage.write('maintained', 'value', options2);

        async.elapse(ttl);

        final aliveKeys = storage.prefs.getKeys();
        expect(aliveKeys, hasLength(1));
        expect(aliveKeys.single, equals("maintained"));

        final result = storage.prefs.getString(aliveKeys.single);
        expect(result, equals("value"));
      });
    });

    test('returns null on unknown keys', () async {
      await expectLater(storage.read('key'), completion(isNull));
    });

    test('returns the value if it exists', () async {
      await storage.write('key', 'value', options);

      final result = storage.read('key');

      await expectLater(
        result,
        completion(
          isA<PersistedData<String>>().having(
            (e) => e.data,
            'value',
            equals('value'),
          ),
        ),
      );
    });

    test('returns null after a delete', () async {
      await storage.write('key', 'value', options);

      await storage.delete('key');

      final result = storage.read('key');
      await expectLater(result, completion(isNull));
    });
  });
}

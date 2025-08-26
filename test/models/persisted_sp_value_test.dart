import 'package:clock/clock.dart';
import 'package:riverpod_shared_preferences/src/models/persisted_sp_value.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PersistedSpValue', () {
    final time = DateTime.utc(1992, 11, 27, 21, 50);
    final clock = Clock.fixed(time);

    group('fromJson', () {
      test('deserialization works', () {
        withClock(clock, () {
          final json = {
            'key': 'test_key',
            'data': 'test_data',
            'expiresAt': time.toIso8601String(),
            'destroyKey': 'test_destroy_key',
          };

          final instance = PersistedSpValue.fromJson(json);

          expect(instance.key, equals('test_key'));
          expect(instance.data, equals('test_data'));
          expect(instance.expiresAt, isNotNull);
          expect(instance.expiresAt, equals(time));
          expect(instance.destroyKey, equals('test_destroy_key'));
        });
      });
      test('serialization works', () {
        withClock(clock, () {
          final instance = PersistedSpValue(
            key: 'test_key',
            data: 'test_data',
            expiresAt: time,
            destroyKey: 'test_destroy_key',
          );

          final json = instance.toJson();

          expect(json['key'], equals('test_key'));
          expect(json['data'], equals('test_data'));
          expect(json['expiresAt'], isNotNull);
          expect(json['expiresAt'], equals("1992-11-27T21:50:00.000Z"));
          expect(json['destroyKey'], equals('test_destroy_key'));
        });
      });
    });

    group('toPersistedData', () {
      test('adapts PersistedSpValue to PersistedData', () {
        withClock(clock, () {
          final instance = PersistedSpValue(
            key: 'test_key',
            data: 'test_data',
            expiresAt: time,
            destroyKey: 'test_destroy_key',
          );

          final data = instance.toPersistedData();

          expect(data.destroyKey, equals('test_destroy_key'));
          expect(data.data, equals('test_data'));
          expect(data.expireAt, equals(time));
        });
      });
    });

    group('isExpired', () {
      final instance = PersistedSpValue(
        key: 'test_key',
        data: 'test_data',
        expiresAt: time,
        destroyKey: 'test_destroy_key',
      );

      test('returns true when expiresAt is in the past', () {
        withClock(clock, () {
          final past = time.subtract(const Duration(milliseconds: 1));
          final invalid = instance.copyWith(expiresAt: past);

          final expired = PersistedSpValue.isExpired(invalid);

          expect(expired, isTrue);
        });
      });
      test('returns false when expiresAt is null', () {
        withClock(clock, () {
          final noExpiry = instance.copyWith(expiresAt: null);

          final expired = PersistedSpValue.isExpired(noExpiry);

          expect(expired, isFalse);
        });
      });
      test('return false when expiresAt is in the future', () {
        withClock(clock, () {
          final future = time.add(const Duration(days: 1));
          final valid = instance.copyWith(expiresAt: future);

          final expired = PersistedSpValue.isExpired(valid);

          expect(expired, isFalse);
        });
      });
    });
  });
}

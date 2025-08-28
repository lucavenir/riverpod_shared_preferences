import "package:clock/clock.dart";
import "package:flutter_test/flutter_test.dart";
import "package:riverpod_shared_preferences/src/helpers.dart";

void main() {
  group("RiverpodSharedPreferencesHelpers", () {
    final time = DateTime.utc(1992, 11, 27, 21, 50);
    final clock = Clock.fixed(time);

    group("computeExpirationTime", () {
      test("returns null if ttl is null", () {
        withClock(clock, () {
          final datetime = Helpers.computeExpirationTime(ttl: null);
          expect(datetime, isNull);
        });
      });

      test("shifts expiration time by ttl if not null", () {
        withClock(clock, () {
          const ttl = Duration(hours: 1);
          final datetime = Helpers.computeExpirationTime(ttl: ttl);
          expect(datetime, isNotNull);
          expect(datetime!.isUtc, isTrue);
          expect(datetime, equals(DateTime.utc(1992, 11, 27, 22, 50)));
        });
      });
    });

    group("computeRiverpodKey", () {
      test("returns correct shared preferences key", () {
        final key = Helpers.computeRiverpodKey("abc");
        expect(key, equals("riverpod.abc"));
      });
      test("throws ArgumentError if key is empty", () {
        expect(() => Helpers.computeRiverpodKey(""), throwsArgumentError);
      });
    });
  });
}

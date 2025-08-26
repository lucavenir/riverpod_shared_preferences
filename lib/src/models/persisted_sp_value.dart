import 'package:clock/clock.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/experimental/persist.dart';
part 'persisted_sp_value.freezed.dart';
part 'persisted_sp_value.g.dart';

@freezed
abstract class PersistedSpValue with _$PersistedSpValue {
  const PersistedSpValue._();

  const factory PersistedSpValue({
    required String data,
    required String key,
    required String? destroyKey,
    required DateTime? expiresAt,
  }) = _PersistedSpValue;

  factory PersistedSpValue.fromJson(Map<String, dynamic> json) =>
      _$PersistedSpValueFromJson(json);

  PersistedData toPersistedData() {
    return PersistedData(data, destroyKey: destroyKey, expireAt: expiresAt);
  }

  static bool isExpired(PersistedSpValue input) {
    return switch (input.expiresAt) {
      null => false,
      final value => value.isBefore(clock.now()),
    };
  }
}

import "package:clock/clock.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "persisted_sp_value.freezed.dart";
part "persisted_sp_value.g.dart";

@freezed
@internal
abstract class PersistedSpValue with _$PersistedSpValue {
  const factory PersistedSpValue({
    required String data,
    required String key,
    required String? destroyKey,
    required DateTime? expiresAt,
  }) = _PersistedSpValue;
  const PersistedSpValue._();

  factory PersistedSpValue.fromJson(Map<String, dynamic> json) =>
      _$PersistedSpValueFromJson(json);

  static bool isExpired(PersistedSpValue input) {
    return switch (input.expiresAt) {
      null => false,
      final value => value.isBefore(clock.now()),
    };
  }
}

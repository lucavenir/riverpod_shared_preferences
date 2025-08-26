// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persisted_sp_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PersistedSpValue _$PersistedSpValueFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PersistedSpValue', json, ($checkedConvert) {
      final val = _PersistedSpValue(
        data: $checkedConvert('data', (v) => v as String),
        key: $checkedConvert('key', (v) => v as String),
        destroyKey: $checkedConvert('destroyKey', (v) => v as String?),
        expiresAt: $checkedConvert(
          'expiresAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PersistedSpValueToJson(_PersistedSpValue instance) =>
    <String, dynamic>{
      'data': instance.data,
      'key': instance.key,
      'destroyKey': ?instance.destroyKey,
      'expiresAt': ?instance.expiresAt?.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'persisted_sp_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PersistedSpValue {

 String get data; String get key; String? get destroyKey; DateTime? get expiresAt;
/// Create a copy of PersistedSpValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersistedSpValueCopyWith<PersistedSpValue> get copyWith => _$PersistedSpValueCopyWithImpl<PersistedSpValue>(this as PersistedSpValue, _$identity);

  /// Serializes this PersistedSpValue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersistedSpValue&&(identical(other.data, data) || other.data == data)&&(identical(other.key, key) || other.key == key)&&(identical(other.destroyKey, destroyKey) || other.destroyKey == destroyKey)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data,key,destroyKey,expiresAt);

@override
String toString() {
  return 'PersistedSpValue(data: $data, key: $key, destroyKey: $destroyKey, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $PersistedSpValueCopyWith<$Res>  {
  factory $PersistedSpValueCopyWith(PersistedSpValue value, $Res Function(PersistedSpValue) _then) = _$PersistedSpValueCopyWithImpl;
@useResult
$Res call({
 String data, String key, String? destroyKey, DateTime? expiresAt
});




}
/// @nodoc
class _$PersistedSpValueCopyWithImpl<$Res>
    implements $PersistedSpValueCopyWith<$Res> {
  _$PersistedSpValueCopyWithImpl(this._self, this._then);

  final PersistedSpValue _self;
  final $Res Function(PersistedSpValue) _then;

/// Create a copy of PersistedSpValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? key = null,Object? destroyKey = freezed,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,destroyKey: freezed == destroyKey ? _self.destroyKey : destroyKey // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PersistedSpValue].
extension PersistedSpValuePatterns on PersistedSpValue {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersistedSpValue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersistedSpValue() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersistedSpValue value)  $default,){
final _that = this;
switch (_that) {
case _PersistedSpValue():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersistedSpValue value)?  $default,){
final _that = this;
switch (_that) {
case _PersistedSpValue() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String data,  String key,  String? destroyKey,  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersistedSpValue() when $default != null:
return $default(_that.data,_that.key,_that.destroyKey,_that.expiresAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String data,  String key,  String? destroyKey,  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _PersistedSpValue():
return $default(_that.data,_that.key,_that.destroyKey,_that.expiresAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String data,  String key,  String? destroyKey,  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _PersistedSpValue() when $default != null:
return $default(_that.data,_that.key,_that.destroyKey,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersistedSpValue extends PersistedSpValue {
  const _PersistedSpValue({required this.data, required this.key, required this.destroyKey, required this.expiresAt}): super._();
  factory _PersistedSpValue.fromJson(Map<String, dynamic> json) => _$PersistedSpValueFromJson(json);

@override final  String data;
@override final  String key;
@override final  String? destroyKey;
@override final  DateTime? expiresAt;

/// Create a copy of PersistedSpValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersistedSpValueCopyWith<_PersistedSpValue> get copyWith => __$PersistedSpValueCopyWithImpl<_PersistedSpValue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersistedSpValueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersistedSpValue&&(identical(other.data, data) || other.data == data)&&(identical(other.key, key) || other.key == key)&&(identical(other.destroyKey, destroyKey) || other.destroyKey == destroyKey)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data,key,destroyKey,expiresAt);

@override
String toString() {
  return 'PersistedSpValue(data: $data, key: $key, destroyKey: $destroyKey, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$PersistedSpValueCopyWith<$Res> implements $PersistedSpValueCopyWith<$Res> {
  factory _$PersistedSpValueCopyWith(_PersistedSpValue value, $Res Function(_PersistedSpValue) _then) = __$PersistedSpValueCopyWithImpl;
@override @useResult
$Res call({
 String data, String key, String? destroyKey, DateTime? expiresAt
});




}
/// @nodoc
class __$PersistedSpValueCopyWithImpl<$Res>
    implements _$PersistedSpValueCopyWith<$Res> {
  __$PersistedSpValueCopyWithImpl(this._self, this._then);

  final _PersistedSpValue _self;
  final $Res Function(_PersistedSpValue) _then;

/// Create a copy of PersistedSpValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? key = null,Object? destroyKey = freezed,Object? expiresAt = freezed,}) {
  return _then(_PersistedSpValue(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,destroyKey: freezed == destroyKey ? _self.destroyKey : destroyKey // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

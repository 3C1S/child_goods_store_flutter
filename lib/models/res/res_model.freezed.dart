// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'res_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ResModel<T> _$ResModelFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _ResModel<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$ResModel<T> {
  @JsonKey(fromJson: castToInt)
  int get code => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  T? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResModelCopyWith<T, ResModel<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResModelCopyWith<T, $Res> {
  factory $ResModelCopyWith(
          ResModel<T> value, $Res Function(ResModel<T>) then) =
      _$ResModelCopyWithImpl<T, $Res, ResModel<T>>;
  @useResult
  $Res call({@JsonKey(fromJson: castToInt) int code, String? message, T? data});
}

/// @nodoc
class _$ResModelCopyWithImpl<T, $Res, $Val extends ResModel<T>>
    implements $ResModelCopyWith<T, $Res> {
  _$ResModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResModelImplCopyWith<T, $Res>
    implements $ResModelCopyWith<T, $Res> {
  factory _$$ResModelImplCopyWith(
          _$ResModelImpl<T> value, $Res Function(_$ResModelImpl<T>) then) =
      __$$ResModelImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({@JsonKey(fromJson: castToInt) int code, String? message, T? data});
}

/// @nodoc
class __$$ResModelImplCopyWithImpl<T, $Res>
    extends _$ResModelCopyWithImpl<T, $Res, _$ResModelImpl<T>>
    implements _$$ResModelImplCopyWith<T, $Res> {
  __$$ResModelImplCopyWithImpl(
      _$ResModelImpl<T> _value, $Res Function(_$ResModelImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$ResModelImpl<T>(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$ResModelImpl<T> implements _ResModel<T> {
  _$ResModelImpl(
      {@JsonKey(fromJson: castToInt) required this.code,
      this.message,
      this.data});

  factory _$ResModelImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$ResModelImplFromJson(json, fromJsonT);

  @override
  @JsonKey(fromJson: castToInt)
  final int code;
  @override
  final String? message;
  @override
  final T? data;

  @override
  String toString() {
    return 'ResModel<$T>(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResModelImpl<T> &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, message, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResModelImplCopyWith<T, _$ResModelImpl<T>> get copyWith =>
      __$$ResModelImplCopyWithImpl<T, _$ResModelImpl<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$ResModelImplToJson<T>(this, toJsonT);
  }
}

abstract class _ResModel<T> implements ResModel<T> {
  factory _ResModel(
      {@JsonKey(fromJson: castToInt) required final int code,
      final String? message,
      final T? data}) = _$ResModelImpl<T>;

  factory _ResModel.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$ResModelImpl<T>.fromJson;

  @override
  @JsonKey(fromJson: castToInt)
  int get code;
  @override
  String? get message;
  @override
  T? get data;
  @override
  @JsonKey(ignore: true)
  _$$ResModelImplCopyWith<T, _$ResModelImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

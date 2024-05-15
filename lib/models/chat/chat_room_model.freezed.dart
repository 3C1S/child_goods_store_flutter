// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_room_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatRoomModel _$ChatRoomModelFromJson(Map<String, dynamic> json) {
  return _ChatRoomModel.fromJson(json);
}

/// @nodoc
mixin _$ChatRoomModel {
  int? get chatRoomId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: EChatItemType.fromJson, toJson: EChatItemType.toJson)
  EChatItemType? get category => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String? get productName => throw _privateConstructorUsedError;
  int? get participantsNum => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  int? get unitPrice => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatRoomModelCopyWith<ChatRoomModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomModelCopyWith<$Res> {
  factory $ChatRoomModelCopyWith(
          ChatRoomModel value, $Res Function(ChatRoomModel) then) =
      _$ChatRoomModelCopyWithImpl<$Res, ChatRoomModel>;
  @useResult
  $Res call(
      {int? chatRoomId,
      @JsonKey(fromJson: EChatItemType.fromJson, toJson: EChatItemType.toJson)
      EChatItemType? category,
      int? id,
      String? productName,
      int? participantsNum,
      int? price,
      int? unitPrice,
      DateTime? endDate,
      String? message,
      DateTime? createdAt});
}

/// @nodoc
class _$ChatRoomModelCopyWithImpl<$Res, $Val extends ChatRoomModel>
    implements $ChatRoomModelCopyWith<$Res> {
  _$ChatRoomModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRoomId = freezed,
    Object? category = freezed,
    Object? id = freezed,
    Object? productName = freezed,
    Object? participantsNum = freezed,
    Object? price = freezed,
    Object? unitPrice = freezed,
    Object? endDate = freezed,
    Object? message = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      chatRoomId: freezed == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as EChatItemType?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      participantsNum: freezed == participantsNum
          ? _value.participantsNum
          : participantsNum // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      unitPrice: freezed == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatRoomModelImplCopyWith<$Res>
    implements $ChatRoomModelCopyWith<$Res> {
  factory _$$ChatRoomModelImplCopyWith(
          _$ChatRoomModelImpl value, $Res Function(_$ChatRoomModelImpl) then) =
      __$$ChatRoomModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? chatRoomId,
      @JsonKey(fromJson: EChatItemType.fromJson, toJson: EChatItemType.toJson)
      EChatItemType? category,
      int? id,
      String? productName,
      int? participantsNum,
      int? price,
      int? unitPrice,
      DateTime? endDate,
      String? message,
      DateTime? createdAt});
}

/// @nodoc
class __$$ChatRoomModelImplCopyWithImpl<$Res>
    extends _$ChatRoomModelCopyWithImpl<$Res, _$ChatRoomModelImpl>
    implements _$$ChatRoomModelImplCopyWith<$Res> {
  __$$ChatRoomModelImplCopyWithImpl(
      _$ChatRoomModelImpl _value, $Res Function(_$ChatRoomModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRoomId = freezed,
    Object? category = freezed,
    Object? id = freezed,
    Object? productName = freezed,
    Object? participantsNum = freezed,
    Object? price = freezed,
    Object? unitPrice = freezed,
    Object? endDate = freezed,
    Object? message = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ChatRoomModelImpl(
      chatRoomId: freezed == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as EChatItemType?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      participantsNum: freezed == participantsNum
          ? _value.participantsNum
          : participantsNum // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      unitPrice: freezed == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatRoomModelImpl implements _ChatRoomModel {
  _$ChatRoomModelImpl(
      {this.chatRoomId,
      @JsonKey(fromJson: EChatItemType.fromJson, toJson: EChatItemType.toJson)
      this.category,
      this.id,
      this.productName,
      this.participantsNum,
      this.price,
      this.unitPrice,
      this.endDate,
      this.message,
      this.createdAt});

  factory _$ChatRoomModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRoomModelImplFromJson(json);

  @override
  final int? chatRoomId;
  @override
  @JsonKey(fromJson: EChatItemType.fromJson, toJson: EChatItemType.toJson)
  final EChatItemType? category;
  @override
  final int? id;
  @override
  final String? productName;
  @override
  final int? participantsNum;
  @override
  final int? price;
  @override
  final int? unitPrice;
  @override
  final DateTime? endDate;
  @override
  final String? message;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ChatRoomModel(chatRoomId: $chatRoomId, category: $category, id: $id, productName: $productName, participantsNum: $participantsNum, price: $price, unitPrice: $unitPrice, endDate: $endDate, message: $message, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomModelImpl &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.participantsNum, participantsNum) ||
                other.participantsNum == participantsNum) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      chatRoomId,
      category,
      id,
      productName,
      participantsNum,
      price,
      unitPrice,
      endDate,
      message,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomModelImplCopyWith<_$ChatRoomModelImpl> get copyWith =>
      __$$ChatRoomModelImplCopyWithImpl<_$ChatRoomModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRoomModelImplToJson(
      this,
    );
  }
}

abstract class _ChatRoomModel implements ChatRoomModel {
  factory _ChatRoomModel(
      {final int? chatRoomId,
      @JsonKey(fromJson: EChatItemType.fromJson, toJson: EChatItemType.toJson)
      final EChatItemType? category,
      final int? id,
      final String? productName,
      final int? participantsNum,
      final int? price,
      final int? unitPrice,
      final DateTime? endDate,
      final String? message,
      final DateTime? createdAt}) = _$ChatRoomModelImpl;

  factory _ChatRoomModel.fromJson(Map<String, dynamic> json) =
      _$ChatRoomModelImpl.fromJson;

  @override
  int? get chatRoomId;
  @override
  @JsonKey(fromJson: EChatItemType.fromJson, toJson: EChatItemType.toJson)
  EChatItemType? get category;
  @override
  int? get id;
  @override
  String? get productName;
  @override
  int? get participantsNum;
  @override
  int? get price;
  @override
  int? get unitPrice;
  @override
  DateTime? get endDate;
  @override
  String? get message;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ChatRoomModelImplCopyWith<_$ChatRoomModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PurchaseModel _$PurchaseModelFromJson(Map<String, dynamic> json) {
  return _PurchaseModel.fromJson(json);
}

/// @nodoc
mixin _$PurchaseModel {
  @JsonKey(fromJson: EChatItemType.fromJson, toJson: EChatItemType.toJson)
  EChatItemType? get category => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get sellerName => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  DateTime? get saleCompleteDate => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  bool? get isReview => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PurchaseModelCopyWith<PurchaseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseModelCopyWith<$Res> {
  factory $PurchaseModelCopyWith(
          PurchaseModel value, $Res Function(PurchaseModel) then) =
      _$PurchaseModelCopyWithImpl<$Res, PurchaseModel>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: EChatItemType.fromJson, toJson: EChatItemType.toJson)
      EChatItemType? category,
      int? id,
      String? title,
      String? sellerName,
      int? price,
      DateTime? saleCompleteDate,
      String? image,
      bool? isReview});
}

/// @nodoc
class _$PurchaseModelCopyWithImpl<$Res, $Val extends PurchaseModel>
    implements $PurchaseModelCopyWith<$Res> {
  _$PurchaseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
    Object? id = freezed,
    Object? title = freezed,
    Object? sellerName = freezed,
    Object? price = freezed,
    Object? saleCompleteDate = freezed,
    Object? image = freezed,
    Object? isReview = freezed,
  }) {
    return _then(_value.copyWith(
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as EChatItemType?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      sellerName: freezed == sellerName
          ? _value.sellerName
          : sellerName // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      saleCompleteDate: freezed == saleCompleteDate
          ? _value.saleCompleteDate
          : saleCompleteDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      isReview: freezed == isReview
          ? _value.isReview
          : isReview // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchaseModelImplCopyWith<$Res>
    implements $PurchaseModelCopyWith<$Res> {
  factory _$$PurchaseModelImplCopyWith(
          _$PurchaseModelImpl value, $Res Function(_$PurchaseModelImpl) then) =
      __$$PurchaseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: EChatItemType.fromJson, toJson: EChatItemType.toJson)
      EChatItemType? category,
      int? id,
      String? title,
      String? sellerName,
      int? price,
      DateTime? saleCompleteDate,
      String? image,
      bool? isReview});
}

/// @nodoc
class __$$PurchaseModelImplCopyWithImpl<$Res>
    extends _$PurchaseModelCopyWithImpl<$Res, _$PurchaseModelImpl>
    implements _$$PurchaseModelImplCopyWith<$Res> {
  __$$PurchaseModelImplCopyWithImpl(
      _$PurchaseModelImpl _value, $Res Function(_$PurchaseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
    Object? id = freezed,
    Object? title = freezed,
    Object? sellerName = freezed,
    Object? price = freezed,
    Object? saleCompleteDate = freezed,
    Object? image = freezed,
    Object? isReview = freezed,
  }) {
    return _then(_$PurchaseModelImpl(
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as EChatItemType?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      sellerName: freezed == sellerName
          ? _value.sellerName
          : sellerName // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      saleCompleteDate: freezed == saleCompleteDate
          ? _value.saleCompleteDate
          : saleCompleteDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      isReview: freezed == isReview
          ? _value.isReview
          : isReview // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseModelImpl implements _PurchaseModel {
  _$PurchaseModelImpl(
      {@JsonKey(fromJson: EChatItemType.fromJson, toJson: EChatItemType.toJson)
      this.category,
      this.id,
      this.title,
      this.sellerName,
      this.price,
      this.saleCompleteDate,
      this.image,
      this.isReview});

  factory _$PurchaseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseModelImplFromJson(json);

  @override
  @JsonKey(fromJson: EChatItemType.fromJson, toJson: EChatItemType.toJson)
  final EChatItemType? category;
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? sellerName;
  @override
  final int? price;
  @override
  final DateTime? saleCompleteDate;
  @override
  final String? image;
  @override
  final bool? isReview;

  @override
  String toString() {
    return 'PurchaseModel(category: $category, id: $id, title: $title, sellerName: $sellerName, price: $price, saleCompleteDate: $saleCompleteDate, image: $image, isReview: $isReview)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseModelImpl &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.sellerName, sellerName) ||
                other.sellerName == sellerName) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.saleCompleteDate, saleCompleteDate) ||
                other.saleCompleteDate == saleCompleteDate) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.isReview, isReview) ||
                other.isReview == isReview));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, category, id, title, sellerName,
      price, saleCompleteDate, image, isReview);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseModelImplCopyWith<_$PurchaseModelImpl> get copyWith =>
      __$$PurchaseModelImplCopyWithImpl<_$PurchaseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseModelImplToJson(
      this,
    );
  }
}

abstract class _PurchaseModel implements PurchaseModel {
  factory _PurchaseModel(
      {@JsonKey(fromJson: EChatItemType.fromJson, toJson: EChatItemType.toJson)
      final EChatItemType? category,
      final int? id,
      final String? title,
      final String? sellerName,
      final int? price,
      final DateTime? saleCompleteDate,
      final String? image,
      final bool? isReview}) = _$PurchaseModelImpl;

  factory _PurchaseModel.fromJson(Map<String, dynamic> json) =
      _$PurchaseModelImpl.fromJson;

  @override
  @JsonKey(fromJson: EChatItemType.fromJson, toJson: EChatItemType.toJson)
  EChatItemType? get category;
  @override
  int? get id;
  @override
  String? get title;
  @override
  String? get sellerName;
  @override
  int? get price;
  @override
  DateTime? get saleCompleteDate;
  @override
  String? get image;
  @override
  bool? get isReview;
  @override
  @JsonKey(ignore: true)
  _$$PurchaseModelImplCopyWith<_$PurchaseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

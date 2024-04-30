// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return _ProductModel.fromJson(json);
}

/// @nodoc
mixin _$ProductModel {
  int? get productId => throw _privateConstructorUsedError;
  UserProfileModel? get user => throw _privateConstructorUsedError;
  String? get productName => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(fromJson: EMainCategory.fromJson, toJson: EMainCategory.toJson)
  EMainCategory? get mainCategory => throw _privateConstructorUsedError;
  @JsonKey(fromJson: ESubCategory.fromJson, toJson: ESubCategory.toJson)
  ESubCategory? get subCategory => throw _privateConstructorUsedError;
  @JsonKey(fromJson: EProductState.fromJson, toJson: EProductState.toJson)
  EProductState? get productState => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: EProductSaleState.fromJson, toJson: EProductSaleState.toJson)
  EProductSaleState? get state => throw _privateConstructorUsedError;
  @JsonKey(fromJson: EChildAge.fromJson, toJson: EChildAge.toJson)
  EChildAge? get age => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<String> get tag => throw _privateConstructorUsedError;
  List<String> get productImage => throw _privateConstructorUsedError;
  bool? get productHeart => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductModelCopyWith<ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductModelCopyWith<$Res> {
  factory $ProductModelCopyWith(
          ProductModel value, $Res Function(ProductModel) then) =
      _$ProductModelCopyWithImpl<$Res, ProductModel>;
  @useResult
  $Res call(
      {int? productId,
      UserProfileModel? user,
      String? productName,
      int? price,
      String? content,
      @JsonKey(fromJson: EMainCategory.fromJson, toJson: EMainCategory.toJson)
      EMainCategory? mainCategory,
      @JsonKey(fromJson: ESubCategory.fromJson, toJson: ESubCategory.toJson)
      ESubCategory? subCategory,
      @JsonKey(fromJson: EProductState.fromJson, toJson: EProductState.toJson)
      EProductState? productState,
      @JsonKey(
          fromJson: EProductSaleState.fromJson,
          toJson: EProductSaleState.toJson)
      EProductSaleState? state,
      @JsonKey(fromJson: EChildAge.fromJson, toJson: EChildAge.toJson)
      EChildAge? age,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<String> tag,
      List<String> productImage,
      bool? productHeart});

  $UserProfileModelCopyWith<$Res>? get user;
}

/// @nodoc
class _$ProductModelCopyWithImpl<$Res, $Val extends ProductModel>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = freezed,
    Object? user = freezed,
    Object? productName = freezed,
    Object? price = freezed,
    Object? content = freezed,
    Object? mainCategory = freezed,
    Object? subCategory = freezed,
    Object? productState = freezed,
    Object? state = freezed,
    Object? age = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? tag = null,
    Object? productImage = null,
    Object? productHeart = freezed,
  }) {
    return _then(_value.copyWith(
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserProfileModel?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      mainCategory: freezed == mainCategory
          ? _value.mainCategory
          : mainCategory // ignore: cast_nullable_to_non_nullable
              as EMainCategory?,
      subCategory: freezed == subCategory
          ? _value.subCategory
          : subCategory // ignore: cast_nullable_to_non_nullable
              as ESubCategory?,
      productState: freezed == productState
          ? _value.productState
          : productState // ignore: cast_nullable_to_non_nullable
              as EProductState?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as EProductSaleState?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as EChildAge?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as List<String>,
      productImage: null == productImage
          ? _value.productImage
          : productImage // ignore: cast_nullable_to_non_nullable
              as List<String>,
      productHeart: freezed == productHeart
          ? _value.productHeart
          : productHeart // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserProfileModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserProfileModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductModelImplCopyWith<$Res>
    implements $ProductModelCopyWith<$Res> {
  factory _$$ProductModelImplCopyWith(
          _$ProductModelImpl value, $Res Function(_$ProductModelImpl) then) =
      __$$ProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? productId,
      UserProfileModel? user,
      String? productName,
      int? price,
      String? content,
      @JsonKey(fromJson: EMainCategory.fromJson, toJson: EMainCategory.toJson)
      EMainCategory? mainCategory,
      @JsonKey(fromJson: ESubCategory.fromJson, toJson: ESubCategory.toJson)
      ESubCategory? subCategory,
      @JsonKey(fromJson: EProductState.fromJson, toJson: EProductState.toJson)
      EProductState? productState,
      @JsonKey(
          fromJson: EProductSaleState.fromJson,
          toJson: EProductSaleState.toJson)
      EProductSaleState? state,
      @JsonKey(fromJson: EChildAge.fromJson, toJson: EChildAge.toJson)
      EChildAge? age,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<String> tag,
      List<String> productImage,
      bool? productHeart});

  @override
  $UserProfileModelCopyWith<$Res>? get user;
}

/// @nodoc
class __$$ProductModelImplCopyWithImpl<$Res>
    extends _$ProductModelCopyWithImpl<$Res, _$ProductModelImpl>
    implements _$$ProductModelImplCopyWith<$Res> {
  __$$ProductModelImplCopyWithImpl(
      _$ProductModelImpl _value, $Res Function(_$ProductModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = freezed,
    Object? user = freezed,
    Object? productName = freezed,
    Object? price = freezed,
    Object? content = freezed,
    Object? mainCategory = freezed,
    Object? subCategory = freezed,
    Object? productState = freezed,
    Object? state = freezed,
    Object? age = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? tag = null,
    Object? productImage = null,
    Object? productHeart = freezed,
  }) {
    return _then(_$ProductModelImpl(
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserProfileModel?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      mainCategory: freezed == mainCategory
          ? _value.mainCategory
          : mainCategory // ignore: cast_nullable_to_non_nullable
              as EMainCategory?,
      subCategory: freezed == subCategory
          ? _value.subCategory
          : subCategory // ignore: cast_nullable_to_non_nullable
              as ESubCategory?,
      productState: freezed == productState
          ? _value.productState
          : productState // ignore: cast_nullable_to_non_nullable
              as EProductState?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as EProductSaleState?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as EChildAge?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tag: null == tag
          ? _value._tag
          : tag // ignore: cast_nullable_to_non_nullable
              as List<String>,
      productImage: null == productImage
          ? _value._productImage
          : productImage // ignore: cast_nullable_to_non_nullable
              as List<String>,
      productHeart: freezed == productHeart
          ? _value.productHeart
          : productHeart // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductModelImpl implements _ProductModel {
  _$ProductModelImpl(
      {this.productId,
      this.user,
      this.productName,
      this.price,
      this.content,
      @JsonKey(fromJson: EMainCategory.fromJson, toJson: EMainCategory.toJson)
      this.mainCategory,
      @JsonKey(fromJson: ESubCategory.fromJson, toJson: ESubCategory.toJson)
      this.subCategory,
      @JsonKey(fromJson: EProductState.fromJson, toJson: EProductState.toJson)
      this.productState,
      @JsonKey(
          fromJson: EProductSaleState.fromJson,
          toJson: EProductSaleState.toJson)
      this.state,
      @JsonKey(fromJson: EChildAge.fromJson, toJson: EChildAge.toJson) this.age,
      this.createdAt,
      this.updatedAt,
      final List<String> tag = const [],
      final List<String> productImage = const [],
      this.productHeart})
      : _tag = tag,
        _productImage = productImage;

  factory _$ProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductModelImplFromJson(json);

  @override
  final int? productId;
  @override
  final UserProfileModel? user;
  @override
  final String? productName;
  @override
  final int? price;
  @override
  final String? content;
  @override
  @JsonKey(fromJson: EMainCategory.fromJson, toJson: EMainCategory.toJson)
  final EMainCategory? mainCategory;
  @override
  @JsonKey(fromJson: ESubCategory.fromJson, toJson: ESubCategory.toJson)
  final ESubCategory? subCategory;
  @override
  @JsonKey(fromJson: EProductState.fromJson, toJson: EProductState.toJson)
  final EProductState? productState;
  @override
  @JsonKey(
      fromJson: EProductSaleState.fromJson, toJson: EProductSaleState.toJson)
  final EProductSaleState? state;
  @override
  @JsonKey(fromJson: EChildAge.fromJson, toJson: EChildAge.toJson)
  final EChildAge? age;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  final List<String> _tag;
  @override
  @JsonKey()
  List<String> get tag {
    if (_tag is EqualUnmodifiableListView) return _tag;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tag);
  }

  final List<String> _productImage;
  @override
  @JsonKey()
  List<String> get productImage {
    if (_productImage is EqualUnmodifiableListView) return _productImage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productImage);
  }

  @override
  final bool? productHeart;

  @override
  String toString() {
    return 'ProductModel(productId: $productId, user: $user, productName: $productName, price: $price, content: $content, mainCategory: $mainCategory, subCategory: $subCategory, productState: $productState, state: $state, age: $age, createdAt: $createdAt, updatedAt: $updatedAt, tag: $tag, productImage: $productImage, productHeart: $productHeart)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductModelImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.mainCategory, mainCategory) ||
                other.mainCategory == mainCategory) &&
            (identical(other.subCategory, subCategory) ||
                other.subCategory == subCategory) &&
            (identical(other.productState, productState) ||
                other.productState == productState) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._tag, _tag) &&
            const DeepCollectionEquality()
                .equals(other._productImage, _productImage) &&
            (identical(other.productHeart, productHeart) ||
                other.productHeart == productHeart));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      productId,
      user,
      productName,
      price,
      content,
      mainCategory,
      subCategory,
      productState,
      state,
      age,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_tag),
      const DeepCollectionEquality().hash(_productImage),
      productHeart);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      __$$ProductModelImplCopyWithImpl<_$ProductModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductModelImplToJson(
      this,
    );
  }
}

abstract class _ProductModel implements ProductModel {
  factory _ProductModel(
      {final int? productId,
      final UserProfileModel? user,
      final String? productName,
      final int? price,
      final String? content,
      @JsonKey(fromJson: EMainCategory.fromJson, toJson: EMainCategory.toJson)
      final EMainCategory? mainCategory,
      @JsonKey(fromJson: ESubCategory.fromJson, toJson: ESubCategory.toJson)
      final ESubCategory? subCategory,
      @JsonKey(fromJson: EProductState.fromJson, toJson: EProductState.toJson)
      final EProductState? productState,
      @JsonKey(
          fromJson: EProductSaleState.fromJson,
          toJson: EProductSaleState.toJson)
      final EProductSaleState? state,
      @JsonKey(fromJson: EChildAge.fromJson, toJson: EChildAge.toJson)
      final EChildAge? age,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final List<String> tag,
      final List<String> productImage,
      final bool? productHeart}) = _$ProductModelImpl;

  factory _ProductModel.fromJson(Map<String, dynamic> json) =
      _$ProductModelImpl.fromJson;

  @override
  int? get productId;
  @override
  UserProfileModel? get user;
  @override
  String? get productName;
  @override
  int? get price;
  @override
  String? get content;
  @override
  @JsonKey(fromJson: EMainCategory.fromJson, toJson: EMainCategory.toJson)
  EMainCategory? get mainCategory;
  @override
  @JsonKey(fromJson: ESubCategory.fromJson, toJson: ESubCategory.toJson)
  ESubCategory? get subCategory;
  @override
  @JsonKey(fromJson: EProductState.fromJson, toJson: EProductState.toJson)
  EProductState? get productState;
  @override
  @JsonKey(
      fromJson: EProductSaleState.fromJson, toJson: EProductSaleState.toJson)
  EProductSaleState? get state;
  @override
  @JsonKey(fromJson: EChildAge.fromJson, toJson: EChildAge.toJson)
  EChildAge? get age;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  List<String> get tag;
  @override
  List<String> get productImage;
  @override
  bool? get productHeart;
  @override
  @JsonKey(ignore: true)
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

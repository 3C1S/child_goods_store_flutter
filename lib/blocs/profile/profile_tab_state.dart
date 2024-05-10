import 'package:child_goods_store_flutter/blocs/abs_bloc_state.dart';
import 'package:child_goods_store_flutter/enums/chat_item_type.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/models/product/product_preview_model.dart';
import 'package:child_goods_store_flutter/models/purchase/purchase_model.dart';
import 'package:child_goods_store_flutter/models/review/review_model.dart';
import 'package:child_goods_store_flutter/models/together/together_preview_model.dart';

class ProfileTabState extends BlocState {
  final EChatItemType category;

  final ELoadingStatus myProductsStatus;
  final String? myProductsMessage;
  final List<ProductPreviewModel> myProducts;
  final int myProductsPage;

  final ELoadingStatus myTogethersStatus;
  final String? myTogethersMessage;
  final List<TogetherPreviewModel> myTogethers;
  final int myTogethersPage;

  final ELoadingStatus heartProductsStatus;
  final String? heartProductsMessage;
  final List<ProductPreviewModel> heartProducts;
  final int heartProductsPage;

  final ELoadingStatus heartTogethersStatus;
  final String? heartTogethersMessage;
  final List<TogetherPreviewModel> heartTogethers;
  final int heartTogethersPage;

  final ELoadingStatus purchaseProductsStatus;
  final String? purchaseProductsMessage;
  final List<PurchaseModel> purchaseProducts;
  final int purchaseProductsPage;

  final ELoadingStatus purchaseTogethersStatus;
  final String? purchaseTogethersMessage;
  final List<PurchaseModel> purchaseTogethers;
  final int purchaseTogethersPage;

  final ELoadingStatus receivedReviewsStatus;
  final String? receivedReviewsMessage;
  final List<ReviewModel> receivedReviews;
  final int receivedReviewsPage;

  const ProfileTabState({
    required this.category,
    //
    required this.myProductsStatus,
    this.myProductsMessage,
    required this.myProducts,
    required this.myProductsPage,
    //
    required this.myTogethersStatus,
    this.myTogethersMessage,
    required this.myTogethers,
    required this.myTogethersPage,
    //
    required this.heartProductsStatus,
    this.heartProductsMessage,
    required this.heartProducts,
    required this.heartProductsPage,
    //
    required this.heartTogethersStatus,
    this.heartTogethersMessage,
    required this.heartTogethers,
    required this.heartTogethersPage,
    //
    required this.purchaseProductsStatus,
    this.purchaseProductsMessage,
    required this.purchaseProducts,
    required this.purchaseProductsPage,
    //
    required this.purchaseTogethersStatus,
    this.purchaseTogethersMessage,
    required this.purchaseTogethers,
    required this.purchaseTogethersPage,
    //
    required this.receivedReviewsStatus,
    this.receivedReviewsMessage,
    required this.receivedReviews,
    required this.receivedReviewsPage,
    //
    required super.status,
    super.message,
  });

  const ProfileTabState.init()
      : category = EChatItemType.product,
        //
        myProductsStatus = ELoadingStatus.init,
        myProductsMessage = null,
        myProducts = const [],
        myProductsPage = 0,
        //
        myTogethersStatus = ELoadingStatus.init,
        myTogethersMessage = null,
        myTogethers = const [],
        myTogethersPage = 0,
        //
        heartProductsStatus = ELoadingStatus.init,
        heartProductsMessage = null,
        heartProducts = const [],
        heartProductsPage = 0,
        //
        heartTogethersStatus = ELoadingStatus.init,
        heartTogethersMessage = null,
        heartTogethers = const [],
        heartTogethersPage = 0,
        //
        purchaseProductsStatus = ELoadingStatus.init,
        purchaseProductsMessage = null,
        purchaseProducts = const [],
        purchaseProductsPage = 0,
        //
        purchaseTogethersStatus = ELoadingStatus.init,
        purchaseTogethersMessage = null,
        purchaseTogethers = const [],
        purchaseTogethersPage = 0,
        //
        receivedReviewsStatus = ELoadingStatus.init,
        receivedReviewsMessage = null,
        receivedReviews = const [],
        receivedReviewsPage = 0,
        super(
          status: ELoadingStatus.init,
          message: null,
        );

  @override
  ProfileTabState copyWith({
    ELoadingStatus? status,
    String? message,
    EChatItemType? category,
    //
    ELoadingStatus? myProductsStatus,
    String? myProductsMessage,
    List<ProductPreviewModel>? myProducts,
    int? myProductsPage,
    //
    ELoadingStatus? myTogethersStatus,
    String? myTogethersMessage,
    List<TogetherPreviewModel>? myTogethers,
    int? myTogethersPage,
    //
    ELoadingStatus? heartProductsStatus,
    String? heartProductsMessage,
    List<ProductPreviewModel>? heartProducts,
    int? heartProductsPage,
    //
    ELoadingStatus? heartTogethersStatus,
    String? heartTogethersMessage,
    List<TogetherPreviewModel>? heartTogethers,
    int? heartTogethersPage,
    //
    ELoadingStatus? purchaseProductsStatus,
    String? purchaseProductsMessage,
    List<PurchaseModel>? purchaseProducts,
    int? purchaseProductsPage,
    //
    ELoadingStatus? purchaseTogethersStatus,
    String? purchaseTogethersMessage,
    List<PurchaseModel>? purchaseTogethers,
    int? purchaseTogethersPage,
    //
    ELoadingStatus? receivedReviewsStatus,
    String? receivedReviewsMessage,
    List<ReviewModel>? receivedReviews,
    int? receivedReviewsPage,
  }) =>
      ProfileTabState(
        status: status ?? this.status,
        message: message ?? this.message,
        category: category ?? this.category,
        //
        myProductsStatus: myProductsStatus ?? this.myProductsStatus,
        myProductsMessage: myProductsMessage ?? this.myProductsMessage,
        myProducts: myProducts ?? this.myProducts,
        myProductsPage: myProductsPage ?? this.myProductsPage,
        //
        myTogethersStatus: myTogethersStatus ?? this.myTogethersStatus,
        myTogethersMessage: myTogethersMessage ?? this.myTogethersMessage,
        myTogethers: myTogethers ?? this.myTogethers,
        myTogethersPage: myTogethersPage ?? this.myTogethersPage,
        //
        heartProductsStatus: heartProductsStatus ?? this.heartProductsStatus,
        heartProductsMessage: heartProductsMessage ?? this.heartProductsMessage,
        heartProducts: heartProducts ?? this.heartProducts,
        heartProductsPage: heartProductsPage ?? this.heartProductsPage,
        //
        heartTogethersStatus: heartTogethersStatus ?? this.heartTogethersStatus,
        heartTogethersMessage:
            heartTogethersMessage ?? this.heartTogethersMessage,
        heartTogethers: heartTogethers ?? this.heartTogethers,
        heartTogethersPage: heartTogethersPage ?? this.heartTogethersPage,
        //
        purchaseProductsStatus:
            purchaseProductsStatus ?? this.purchaseProductsStatus,
        purchaseProductsMessage:
            purchaseProductsMessage ?? this.purchaseProductsMessage,
        purchaseProducts: purchaseProducts ?? this.purchaseProducts,
        purchaseProductsPage: purchaseProductsPage ?? this.purchaseProductsPage,
        //
        purchaseTogethersStatus:
            purchaseTogethersStatus ?? this.purchaseTogethersStatus,
        purchaseTogethersMessage:
            purchaseTogethersMessage ?? this.purchaseTogethersMessage,
        purchaseTogethers: purchaseTogethers ?? this.purchaseTogethers,
        purchaseTogethersPage:
            purchaseTogethersPage ?? this.purchaseTogethersPage,
        //
        receivedReviewsStatus:
            receivedReviewsStatus ?? this.receivedReviewsStatus,
        receivedReviewsMessage:
            receivedReviewsMessage ?? this.receivedReviewsMessage,
        receivedReviews: receivedReviews ?? this.receivedReviews,
        receivedReviewsPage: receivedReviewsPage ?? this.receivedReviewsPage,
      );

  @override
  List<Object?> get props => [
        status,
        message,
        category,
        //
        myProductsStatus,
        myProductsMessage,
        myProducts,
        myProductsPage,
        //
        myTogethersStatus,
        myTogethersMessage,
        myTogethers,
        myTogethersPage,
        //
        heartProductsStatus,
        heartProductsMessage,
        heartProducts,
        heartProductsPage,
        //
        heartTogethersStatus,
        heartTogethersMessage,
        heartTogethers,
        heartTogethersPage,
        //
        purchaseProductsStatus,
        purchaseProductsMessage,
        purchaseProducts,
        purchaseProductsPage,
        //
        purchaseTogethersStatus,
        purchaseTogethersMessage,
        purchaseTogethers,
        purchaseTogethersPage,
        //
        receivedReviewsStatus,
        receivedReviewsMessage,
        receivedReviews,
        receivedReviewsPage,
      ];
}

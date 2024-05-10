import 'package:bloc/bloc.dart';
import 'package:child_goods_store_flutter/blocs/edit_review/edit_review_event.dart';
import 'package:child_goods_store_flutter/blocs/edit_review/edit_review_state.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/chat_item_type.dart';
import 'package:child_goods_store_flutter/enums/http_method.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/models/review/review_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/product_repository_interfave.dart';
import 'package:child_goods_store_flutter/repositories/interface/review_repository_interface.dart';
import 'package:child_goods_store_flutter/repositories/interface/together_repository_interface.dart';

class EditReviewBloc extends Bloc<EditReviewEvent, EditReviewState>
    with DioExceptionHandlerMixin {
  final IReviewRepository reviewRepository;
  final IProductRepository productRepository;
  final ITogetherRepository togetherRepository;
  final EHttpMethod httpMethod;
  final int id;
  final EChatItemType type;

  EditReviewBloc({
    required this.reviewRepository,
    required this.productRepository,
    required this.togetherRepository,
    required this.httpMethod,
    required this.id,
    required this.type,
    ReviewModel? review,
  }) : super(EditReviewState.init(review: review)) {
    on<EditReviewGetItem>(_editReviewGetItemHandler);
    on<EditReviewChangeScore>(_editReviewChangeScoreHandler);
    on<EditReviewChangeContent>(_editReviewChangeContentHandler);
    on<EditReviewSubmit>(_editReviewSubmitHandler);

    add(EditReviewGetItem());
  }

  Future<void> _editReviewGetItemHandler(
    EditReviewGetItem event,
    Emitter<EditReviewState> emit,
  ) async {
    if (state.targetStatus == ELoadingStatus.loading) return;

    await handleApiRequest(
      () async {
        emit(state.copyWith(
          status: ELoadingStatus.loading,
          targetStatus: ELoadingStatus.loading,
        ));

        switch (type) {
          case EChatItemType.product:
            var res = await productRepository.getProduct(
              productId: id,
            );

            emit(state.copyWith(
              status: ELoadingStatus.loaded,
              targetStatus: ELoadingStatus.loaded,
              targetProduct: res.data,
            ));

            break;
          case EChatItemType.together:
            var res = await togetherRepository.getTogether(
              togetherId: id,
            );

            emit(state.copyWith(
              status: ELoadingStatus.loaded,
              targetStatus: ELoadingStatus.loaded,
              targetTogether: res.data,
            ));

            break;
        }
      },
      state: state,
      emit: emit,
      initAfterError: false,
      finallyCall: () async {
        if (state.status == ELoadingStatus.error) {
          emit(state.copyWith(
            targetStatus: ELoadingStatus.error,
          ));
        }
      },
    );
  }

  Future<void> _editReviewChangeScoreHandler(
    EditReviewChangeScore event,
    Emitter<EditReviewState> emit,
  ) async {
    emit(state.copyWith(
      review: state.review.copyWith(
        score: event.score,
      ),
    ));
  }

  Future<void> _editReviewChangeContentHandler(
    EditReviewChangeContent event,
    Emitter<EditReviewState> emit,
  ) async {
    emit(state.copyWith(
      review: state.review.copyWith(
        content: event.content,
      ),
    ));
  }

  Future<void> _editReviewSubmitHandler(
    EditReviewSubmit event,
    Emitter<EditReviewState> emit,
  ) async {
    if (state.reviewStatus == ELoadingStatus.loading) return;

    // Validate
    if (state.review.score == null) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        reviewStatus: ELoadingStatus.error,
        message: '평점을 입력해주세요.',
      ));
      emit(state.copyWith(
        status: ELoadingStatus.init,
        reviewStatus: ELoadingStatus.init,
      ));
      return;
    }
    if (state.review.content == null ||
        state.review.content == Strings.nullStr) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        reviewStatus: ELoadingStatus.error,
        message: '후기를 입력해주세요.',
      ));
      emit(state.copyWith(
        status: ELoadingStatus.init,
        reviewStatus: ELoadingStatus.init,
      ));
      return;
    }

    await handleApiRequest(
      () async {
        emit(state.copyWith(
          status: ELoadingStatus.loading,
          reviewStatus: ELoadingStatus.loading,
        ));

        switch (httpMethod) {
          case EHttpMethod.post:
            await reviewRepository.postReview(review: state.review);
            break;
          case EHttpMethod.patch:
            await reviewRepository.patchReview(review: state.review);
            break;
        }

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          reviewStatus: ELoadingStatus.loaded,
        ));
      },
      state: state,
      emit: emit,
      initAfterError: false,
      finallyCall: () async {
        if (state.status == ELoadingStatus.error) {
          emit(state.copyWith(
            reviewStatus: ELoadingStatus.error,
          ));
          emit(state.copyWith(
            status: ELoadingStatus.init,
            reviewStatus: ELoadingStatus.init,
          ));
        }
      },
    );
  }
}

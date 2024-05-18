import 'package:child_goods_store_flutter/blocs/abs_bloc_state.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/models/chat/chat_model.dart';
import 'package:child_goods_store_flutter/models/product/product_model.dart';
import 'package:child_goods_store_flutter/models/together/together_model.dart';

class ChatRoomState extends BlocState {
  final int page; // TODO: page보다 불러온 채팅 중 가장 오래된 채팅으로 대체해야 할 듯.
  final List<ChatModel> chats;
  final ELoadingStatus chatStatus;
  final String? chatErrMessage;
  final ProductModel? targetProduct;
  final TogetherModel? targetTogether;
  final ELoadingStatus targetStatus;
  final String? targetErrMessage;

  const ChatRoomState({
    required this.page,
    required this.chats,
    required this.chatStatus,
    this.chatErrMessage,
    this.targetProduct,
    this.targetTogether,
    required this.targetStatus,
    this.targetErrMessage,
    required super.status,
    super.message,
  });

  const ChatRoomState.init()
      : page = 0,
        chats = const [],
        chatStatus = ELoadingStatus.init,
        chatErrMessage = null,
        targetProduct = null,
        targetTogether = null,
        targetStatus = ELoadingStatus.init,
        targetErrMessage = null,
        super(
          status: ELoadingStatus.init,
          message: null,
        );

  @override
  ChatRoomState copyWith({
    ELoadingStatus? status,
    String? message,
    int? page,
    List<ChatModel>? chats,
    ELoadingStatus? chatStatus,
    String? chatErrMessage,
    ProductModel? targetProduct,
    TogetherModel? targetTogether,
    ELoadingStatus? targetStatus,
    String? targetErrMessage,
  }) =>
      ChatRoomState(
        page: page ?? this.page,
        chats: chats ?? this.chats,
        chatStatus: chatStatus ?? this.chatStatus,
        chatErrMessage: chatErrMessage ?? this.chatErrMessage,
        targetProduct: targetProduct ?? this.targetProduct,
        targetTogether: targetTogether ?? this.targetTogether,
        targetStatus: targetStatus ?? this.targetStatus,
        targetErrMessage: targetErrMessage ?? this.targetErrMessage,
        status: status ?? this.status,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        page,
        chats,
        chatStatus,
        chatErrMessage,
        targetProduct,
        targetTogether,
        targetStatus,
        targetErrMessage,
        status,
        message,
      ];
}

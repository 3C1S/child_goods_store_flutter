import 'package:child_goods_store_flutter/blocs/abs_bloc_state.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/models/chat/chat_model.dart';
import 'package:child_goods_store_flutter/models/product/product_model.dart';
import 'package:child_goods_store_flutter/models/together/together_model.dart';

class ChatRoomState extends BlocState {
  final int page; // TODO: page보다 불러온 채팅 중 가장 오래된 채팅으로 대체해야 할 듯.
  final List<ChatModel> chats;
  final ELoadingStatus chatStatus;
  final ProductModel? targetProduct;
  final TogetherModel? targetTogether;
  final ELoadingStatus targetStatus;

  const ChatRoomState({
    required this.page,
    required this.chats,
    required this.chatStatus,
    this.targetProduct,
    this.targetTogether,
    required this.targetStatus,
    required super.status,
    super.message,
  });

  const ChatRoomState.init()
      : page = 0,
        chats = const [],
        chatStatus = ELoadingStatus.init,
        targetProduct = null,
        targetTogether = null,
        targetStatus = ELoadingStatus.init,
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
    ProductModel? targetProduct,
    TogetherModel? targetTogether,
    ELoadingStatus? targetStatus,
  }) =>
      ChatRoomState(
        page: page ?? this.page,
        chats: chats ?? this.chats,
        chatStatus: chatStatus ?? this.chatStatus,
        targetProduct: targetProduct ?? this.targetProduct,
        targetTogether: targetTogether ?? this.targetTogether,
        targetStatus: targetStatus ?? this.targetStatus,
        status: status ?? this.status,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        page,
        chats,
        chatStatus,
        targetProduct,
        targetTogether,
        targetStatus,
        status,
        message,
      ];
}

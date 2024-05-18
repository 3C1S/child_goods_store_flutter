import 'package:child_goods_store_flutter/blocs/chat/room/chat_room_bloc.dart';
import 'package:child_goods_store_flutter/blocs/chat/room/chat_room_event.dart';
import 'package:child_goods_store_flutter/blocs/chat/room/chat_room_state.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/utils/time_utils.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:child_goods_store_flutter/widgets/common/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _onTapMore() {}

  void _scrollListener() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent) {
        _getChats();
      }
    });
  }

  void _getChats({bool force = false}) {
    var bloc = context.read<ChatRoomBloc>();
    if (bloc.state.chatStatus != ELoadingStatus.error || force) {
      bloc.add(ChatRoomGetChats());
    }
  }

  void _onTapRetryGetItem() {
    context.read<ChatRoomBloc>().add(ChatRoomGetItem());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _onTapMore,
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
        title: BlocBuilder<ChatRoomBloc, ChatRoomState>(
          buildWhen: (previous, current) =>
              previous.targetStatus != current.targetStatus,
          builder: (context, state) {
            if (state.targetStatus == ELoadingStatus.error) {
              return const AppFont('채팅');
            }
            return SizedBox(
              height: Sizes.size56,
              child: ItemCard(
                type: state.targetStatus == ELoadingStatus.loaded
                    ? context.read<ChatRoomBloc>().type
                    : null,
                product: state.targetProduct,
                together: state.targetTogether,
                isLarge: false,
              ),
            );
          },
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        reverse: true,
        slivers: [
          // body
          BlocConsumer<ChatRoomBloc, ChatRoomState>(
            listener: (context, state) {
              if (state.chatStatus == ELoadingStatus.loaded) {
                _scrollListener();
              }
            },
            builder: (context, state) {
              if (state.targetStatus == ELoadingStatus.error) {
                return SliverFillRemaining(
                  child: _buildError(
                    message: state.targetErrMessage ?? Strings.unknownFail,
                    onRetry: _onTapRetryGetItem,
                  ),
                );
              }
              return _buildBody(state);
            },
          ),
          // Loading indicator
          SliverToBoxAdapter(
            child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
              builder: (context, state) {
                if (state.targetStatus == ELoadingStatus.error) {
                  return const SizedBox();
                }
                if (state.chatStatus == ELoadingStatus.error) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
                    child: _buildError(
                      message: state.chatErrMessage ?? Strings.unknownFail,
                      onRetry: () => _getChats(force: true),
                    ),
                  );
                }
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: Sizes.size20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(ChatRoomState state) {
    return SliverList.builder(
      itemBuilder: (context, index) => Row(
        children: [
          AppFont('${state.chats[index].user?.userId} >>'),
          Gaps.h10,
          AppFont(state.chats[index].message ?? Strings.nullStr),
          Gaps.h10,
          AppFont(timeDiff(state.chats[index].createdAt)),
        ],
      ),
      itemCount: state.chats.length,
    );
  }

  Widget _buildError({
    required String message,
    required Function() onRetry,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppFont(message),
          Gaps.v20,
          AppInkButton(
            onTap: onRetry,
            child: const AppFont(
              '재시도',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

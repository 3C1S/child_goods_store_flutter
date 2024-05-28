import 'package:child_goods_store_flutter/blocs/chat/list/chat_list_bloc.dart';
import 'package:child_goods_store_flutter/blocs/chat/list/chat_list_event.dart';
import 'package:child_goods_store_flutter/blocs/chat/list/chat_list_state.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/pages/chat/widgets/chat_room_widget.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_h_spliter.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  void _onTapRetryGetChatRooms(BuildContext context) {
    context.read<ChatListBloc>().add(ChatListGetChatRooms());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppFont('채팅'),
        elevation: Sizes.size1,
      ),
      body: BlocBuilder<ChatListBloc, ChatListState>(
        builder: (context, state) {
          if (state.status == ELoadingStatus.loaded) {
            return _buildBody(context, state: state);
          }
          if (state.status == ELoadingStatus.error) {
            return _buildError(
              context,
              message: state.message ?? Strings.unknownFail,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context, {
    required ChatListState state,
  }) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => ChatRoomWidget(
        chatRoom: state.chatRooms[index],
      ),
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.size10),
        child: AppHSpliter(),
      ),
      itemCount: state.chatRooms.length,
    );
  }

  Widget _buildError(
    BuildContext context, {
    required String message,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppFont(message),
          Gaps.v20,
          AppInkButton(
            onTap: () => _onTapRetryGetChatRooms(context),
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

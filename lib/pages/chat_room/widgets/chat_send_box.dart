import 'package:child_goods_store_flutter/blocs/chat/room/chat_room_bloc.dart';
import 'package:child_goods_store_flutter/blocs/chat/room/chat_room_event.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:child_goods_store_flutter/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatSendBox extends StatefulWidget {
  const ChatSendBox({super.key});

  @override
  State<ChatSendBox> createState() => _ChatSendBoxState();
}

class _ChatSendBoxState extends State<ChatSendBox> {
  late final TextEditingController _messageController;
  late final FocusNode _messageFocusNode;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _messageFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  void _sendChat() {
    context.read<ChatRoomBloc>().add(ChatRoomSendChat(_messageController.text));
    _messageController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            blurRadius: Sizes.size1 / 2,
            spreadRadius: Sizes.size1 / 2,
            offset: const Offset(0, -Sizes.size2),
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Gaps.h10,
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 120,
                ),
                child: AppTextFormField(
                  controller: _messageController,
                  focusNode: _messageFocusNode,
                  singleLine: false,
                  focusBorderColor: Colors.transparent,
                  enableBorderColor: Colors.transparent,
                ),
              ),
            ),
            AppInkButton(
              onTap: _sendChat,
              borderRadSize: 0,
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

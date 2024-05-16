import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/chat_item_type.dart';
import 'package:child_goods_store_flutter/models/chat/chat_room_model.dart';
import 'package:child_goods_store_flutter/utils/time_utils.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:flutter/material.dart';

class ChatRoomWidget extends StatelessWidget {
  final ChatRoomModel chatRoom;

  const ChatRoomWidget({
    super.key,
    required this.chatRoom,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.size80,
      child: AppInkButton(
        borderRadSize: 0,
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: Sizes.size60,
              height: Sizes.size60,
              color: Colors.grey.shade400,
            ),
            Gaps.h10,
            Expanded(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppFont(
                      chatRoom.productName ?? Strings.nullStr,
                      maxLine: 1,
                    ),
                    AppFont(
                      chatRoom.message ?? Strings.nullStr,
                      maxLine: 2,
                      fontSize: Sizes.size12,
                    ),
                  ],
                ),
              ),
            ),
            Gaps.h10,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppFont(
                  timeDiff(chatRoom.createdAt),
                  maxLine: 1,
                  fontSize: Sizes.size12,
                ),
                if (chatRoom.category == EChatItemType.together)
                  _timeLeftCard(chatRoom.endDate),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeLeftCard(DateTime? endDate) {
    var left = timeLeft(endDate);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size3,
        vertical: Sizes.size1,
      ),
      decoration: BoxDecoration(
        color: left.contains('D-')
            ? Colors.green
            : left.contains('시간 후')
                ? Colors.orange
                : Colors.red,
        borderRadius: BorderRadius.circular(Sizes.size4),
      ),
      child: AppFont(
        timeLeft(endDate),
        maxLine: 1,
        fontSize: Sizes.size12,
        color: Colors.white,
      ),
    );
  }
}

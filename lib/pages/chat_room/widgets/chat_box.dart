import 'package:child_goods_store_flutter/blocs/auth/auth_bloc_singleton.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/models/chat/chat_model.dart';
import 'package:child_goods_store_flutter/utils/time_utils.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatBox extends StatelessWidget {
  final List<ChatModel> chats;
  final int index;

  const ChatBox({
    required this.chats,
    required this.index,
    super.key,
  });

  bool _sameWithAfterUser() {
    if (index == chats.length - 1) return false;
    return chats[index].user?.userId == chats[index + 1].user?.userId;
  }

  bool _sameWithAfterTime() {
    if (index == chats.length - 1) return false;
    return timeDiff(chats[index].createdAt) ==
        timeDiff(chats[index + 1].createdAt);
  }

  bool _sameWithBeforeTime() {
    if (index == 0) return false;
    return timeDiff(chats[index].createdAt) ==
        timeDiff(chats[index - 1].createdAt);
  }

  @override
  Widget build(BuildContext context) {
    var iam =
        chats[index].user?.userId == AuthBlocSingleton.bloc.state.user?.userId;
    var hideProfile = _sameWithAfterUser() && _sameWithAfterTime();
    var hideTime = _sameWithBeforeTime();

    if (iam) {
      return _iamChat(
        context,
        hideProfile: hideProfile,
        hideTime: hideTime,
      );
    }
    return _youChat(
      context,
      hideProfile: hideProfile,
      hideTime: hideTime,
    );
  }

  Widget _iamChat(
    BuildContext context, {
    required bool hideProfile,
    required bool hideTime,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: Sizes.size80,
          child: hideTime
              ? null
              : Align(
                  alignment: Alignment.bottomRight,
                  child: AppFont(
                    timeDiff(chats[index].createdAt),
                    fontSize: Sizes.size10,
                  ),
                ),
        ),
        Gaps.h10,
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size5,
              horizontal: Sizes.size10,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(hideProfile ? Sizes.size7 : 0),
                topLeft: const Radius.circular(Sizes.size7),
                bottomRight: const Radius.circular(Sizes.size7),
                bottomLeft: const Radius.circular(Sizes.size7),
              ),
            ),
            child: AppFont(
              chats[index].message ?? Strings.nullStr,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _youChat(
    BuildContext context, {
    required bool hideProfile,
    required bool hideTime,
  }) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Sizes.size36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size10),
            ),
            clipBehavior: Clip.hardEdge,
            child: hideProfile
                ? null
                : AppNetworkImage(
                    profileImg: chats[index].user?.profileImg,
                    width: Sizes.size36,
                    height: Sizes.size36,
                  ),
          ),
          Gaps.h10,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!hideProfile)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (chats[index].isLeader == true)
                        Padding(
                          padding: const EdgeInsets.only(right: Sizes.size5),
                          child: Icon(
                            FontAwesomeIcons.crown,
                            size: Sizes.size10,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      Flexible(
                        child: AppFont(
                          '${chats[index].user?.nickName}',
                          maxLine: 1,
                        ),
                      ),
                    ],
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size5,
                    horizontal: Sizes.size10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: chats[index].isLeader == true
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).shadowColor.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(hideProfile ? Sizes.size7 : 0),
                      topRight: const Radius.circular(Sizes.size7),
                      bottomLeft: const Radius.circular(Sizes.size7),
                      bottomRight: const Radius.circular(Sizes.size7),
                    ),
                  ),
                  child: AppFont(
                    chats[index].message ?? Strings.nullStr,
                  ),
                ),
              ],
            ),
          ),
          Gaps.h10,
          SizedBox(
            width: Sizes.size80,
            child: hideTime
                ? null
                : Align(
                    alignment: Alignment.bottomLeft,
                    child: AppFont(
                      timeDiff(chats[index].createdAt),
                      fontSize: Sizes.size10,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

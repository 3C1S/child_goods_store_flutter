import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/pages/notification/widgets/notification_listitem.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppFont('알림 설정'),
        centerTitle: false,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NotificationListItem(
                title: '전체 알림',
                onState: true,
                onChanged: (value) {},
              ),
              Gaps.v20,
              NotificationListItem(
                title: '채팅',
                onState: true,
                onChanged: (value) {},
              ),
              NotificationListItem(
                title: '팔로우',
                onState: true,
                onChanged: (value) {},
              ),
              Gaps.v20,
              const AppFont('중고거래'),
              Padding(
                padding: const EdgeInsets.only(
                  left: Sizes.size20,
                  top: Sizes.size10,
                ),
                child: Column(
                  children: [
                    NotificationListItem(
                      title: '찜',
                      onState: true,
                      onChanged: (value) {},
                    ),
                    NotificationListItem(
                      title: '후기 알림',
                      onState: true,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              Gaps.v20,
              const AppFont('공동구매'),
              Padding(
                padding: const EdgeInsets.only(
                  left: Sizes.size20,
                  top: Sizes.size10,
                ),
                child: Column(
                  children: [
                    NotificationListItem(
                      title: '참여자 추가',
                      onState: true,
                      onChanged: (value) {},
                    ),
                    NotificationListItem(
                      title: '후기 알림',
                      onState: true,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.viewPaddingOf(context).bottom),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMCubit extends Cubit<FCMState> {
  final String fcmToken;

  FCMCubit({
    required this.fcmToken,
  }) : super(const FCMState()) {
    // FCM listening
    // at foreground
    FirebaseMessaging.onMessage.listen(listenFCM);
    // at background
    FirebaseMessaging.onMessageOpenedApp.listen(listenFCM);
    // at terminate
    FirebaseMessaging.instance.getInitialMessage().then((msg) => listenFCM(
          msg,
          afterReset: false,
        ));
  }

  void listenFCM(
    RemoteMessage? message, {
    bool afterReset = true,
  }) {
    if (message != null && fcmToken != Strings.nullStr) {
      emit(FCMState.fromRemoteMessage(message));
    }
    if (afterReset) {
      emit(const FCMState());
    }
  }

  void resetFCM() {
    emit(const FCMState());
  }
}

class FCMState extends Equatable {
  /// 푸쉬 알림에서 보여지는 문자열
  final String? body;

  /// FCM의 data 객체 데이터를 저장하는 객체 \
  /// [code]: 어떤 타입의 데이터인지 정의 \
  /// [message]: 문자열로 인코딩된 json 데이터. 파싱 방법은 code에 따라 상이.
  final ResModel? data;

  const FCMState({
    this.body,
    this.data,
  });

  factory FCMState.fromRemoteMessage(RemoteMessage? message) {
    if (message != null && message.notification != null) {
      return FCMState(
        body: message.notification?.body,
        data: ResModel.fromJson(message.data, (json) => null),
      );
    }
    return const FCMState();
  }

  @override
  List<Object?> get props => [
        body,
        data,
      ];
}

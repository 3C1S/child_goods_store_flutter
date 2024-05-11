import 'package:child_goods_store_flutter/blocs/fcm/fcm_cubit.dart';

class FCMCubitSingleton {
  FCMCubitSingleton._constructor();
  static final FCMCubitSingleton _signleton = FCMCubitSingleton._constructor();
  static FCMCubitSingleton get instance => _signleton;

  static late final FCMCubit _cubit;
  static FCMCubit get cubit => _cubit;

  static initializer({
    required String fcmToken,
  }) {
    _cubit = FCMCubit(
      fcmToken: fcmToken,
    );
  }
}

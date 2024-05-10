import 'package:child_goods_store_flutter/enums/auth_method.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';

abstract interface class IAuthRepository {
  Future<String> signinWithGoogle();

  Future<void> signoutWithGoogle();

  Future<String> signinWithKakao();

  Future<String> signinWithNaver();

  Future<void> signoutWithNaver();

  ///
  /// API 1
  Future<ResModel<String>> signinWithOauth2({
    required EAuthMethod method,
    required String accessToken,
  });

  ///
  /// API 2
  Future<ResModel<String>> signinWith3C1S({
    required String email,
    required String password,
  });

  ///
  /// API 3
  Future<ResModel<void>> postSignup({
    required String email,
    required String password,
    // required String phoneNum,
  });

  ///
  /// API 4
  Future<ResModel<void>> postEmailSend({
    required String email,
  });

  ///
  /// API 5
  Future<ResModel<void>> postEmailVerify({
    required String email,
    required String code,
  });
}

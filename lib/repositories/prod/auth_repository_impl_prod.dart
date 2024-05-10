import 'package:child_goods_store_flutter/enums/auth_method.dart';
import 'package:child_goods_store_flutter/interceptors/un_auth_interceptor.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/auth_repository_interfece.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class AuthRepositoryImplProd implements IAuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['openid', 'email'],
  );

  @override
  Future<String> signinWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    if (googleSignInAccount == null) {
      throw Exception('Google Sign-In was canceled');
    }

    final GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;

    if (googleAuth.accessToken == null) {
      throw Exception('Failed to get AccessToken');
    }
    // if (googleAuth.idToken == null) {
    //   throw Exception('Failed to get IdToken');
    // }

    return googleAuth.accessToken!;
  }

  @override
  Future<void> signoutWithGoogle() async {
    await _googleSignIn.signOut();
    return;
  }

  @override
  Future<String> signinWithKakao() async {
    if (await isKakaoTalkInstalled()) {
      try {
        final kakaoToken = await UserApi.instance.loginWithKakaoTalk();

        return kakaoToken.accessToken;
      } catch (e) {
        if (e is PlatformException && e.code == 'CANCELED') {
          throw Exception('Kakao Sign-In was canceled');
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        final kakaoToken = await UserApi.instance.loginWithKakaoAccount();

        return kakaoToken.accessToken;
      }
    } else {
      final kakaoToken = await UserApi.instance.loginWithKakaoAccount();

      return kakaoToken.accessToken;
    }
  }

  @override
  Future<String> signinWithNaver() async {
    NaverLoginResult result = await FlutterNaverLogin.logIn();

    if (result.status == NaverLoginStatus.error) {
      throw Exception('Failed to get AccessToken');
    }
    if (result.status == NaverLoginStatus.cancelledByUser) {
      throw Exception('Naver Sign-In was canceled');
    }

    NaverAccessToken accessToken = await FlutterNaverLogin.currentAccessToken;

    return accessToken.accessToken;
  }

  @override
  Future<void> signoutWithNaver() async {
    await FlutterNaverLogin.logOut();
    return;
  }

  ///
  /// API 1
  @override
  Future<ResModel<String>> signinWithOauth2({
    required EAuthMethod method,
    required String accessToken,
  }) async {
    // Dio dio = Dio();
    // dio.interceptors.add(UnAuthInterceptor());
    // var res = await dio.post(
    //   '/oauth',
    //   data: {
    //     'method': method.key,
    //     'accessToken': accessToken,
    //   },
    // );

    // TODO: connect api
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<String>(
      code: 1000,
      data: 'test_jwt_token',
    ).toJson((token) => token.toString());

    var res = ResModel<String>.fromJson(
      resTmp,
      (json) => json.toString(),
    );

    return res;
  }

  ///
  /// API 2
  @override
  Future<ResModel<String>> signinWith3C1S({
    required String email,
    required String password,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(UnAuthInterceptor());
    var res = await dio.post(
      '/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    var resModel = ResModel<String>.fromJson(
      res.data,
      (json) => json.toString(),
    );

    return resModel;
  }

  ///
  /// API 3
  @override
  Future<ResModel<void>> postSignup({
    required String email,
    required String password,
    // required String phoneNum,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(UnAuthInterceptor());
    var res = await dio.post(
      '/signup',
      data: {
        'email': email,
        'password': password,
        // 'phoneNum': phoneNum,
      },
    );

    var resModel = ResModel<void>.fromJson(
      res.data,
      (json) {},
    );

    return resModel;
  }

  ///
  /// API 4
  @override
  Future<ResModel<void>> postEmailSend({
    required String email,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(UnAuthInterceptor());
    var res = await dio.post(
      '/mail/send',
      data: {
        'email': email,
      },
    );

    var resModel = ResModel<void>.fromJson(
      res.data,
      (json) {},
    );

    return resModel;
  }

  ///
  /// API 5
  @override
  Future<ResModel<void>> postEmailVerify({
    required String email,
    required String code,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(UnAuthInterceptor());
    var res = await dio.post(
      '/mail/verify',
      data: {
        'email': email,
        'authNum': code,
      },
    );

    var resModel = ResModel<void>.fromJson(
      res.data,
      (json) {},
    );

    return resModel;
  }
}

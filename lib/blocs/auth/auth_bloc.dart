import 'package:bloc/bloc.dart';
import 'package:child_goods_store_flutter/GA/models/ga_login_event.dart';
import 'package:child_goods_store_flutter/blocs/auth/auth_event.dart';
import 'package:child_goods_store_flutter/blocs/auth/auth_state.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/auth_method.dart';
import 'package:child_goods_store_flutter/enums/auth_status.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/repositories/interface/auth_repository_interfece.dart';
import 'package:child_goods_store_flutter/repositories/interface/user_repository_interface.dart';
import 'package:child_goods_store_flutter/GA/google_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>
    with ChangeNotifier, DioExceptionHandlerMixin {
  final IAuthRepository authRepository;
  final IUserRepository userRepository;

  AuthBloc({
    required this.authRepository,
    required this.userRepository,
  }) : super(const AuthState.init()) {
    on<AuthGoogleSignin>(_authGoogleSigninHandler);
    on<AuthNaverSignin>(_authNaverSigninHandler);
    on<AuthKakaoSignin>(_authKakaoSigninHandler);
    on<AuthSignout>(_authSignoutHandler);
    on<Auth3C1SSignin>(_auth3C1SSigninHandler);
    on<AuthGetUser>(_authGetUserHandler);
    on<AuthSetUser>(_authSetUserHandler);
  }

  Future<void> _authGoogleSigninHandler(
    AuthGoogleSignin event,
    Emitter<AuthState> emit,
  ) async {
    await _authSignin(emit, method: EAuthMethod.google);
  }

  Future<void> _authNaverSigninHandler(
    AuthNaverSignin event,
    Emitter<AuthState> emit,
  ) async {
    await _authSignin(emit, method: EAuthMethod.naver);
  }

  Future<void> _authKakaoSigninHandler(
    AuthKakaoSignin event,
    Emitter<AuthState> emit,
  ) async {
    await _authSignin(emit, method: EAuthMethod.kakao);
  }

  Future<void> _authSignin(
    Emitter<AuthState> emit, {
    required EAuthMethod method,
  }) async {
    if (state.status == ELoadingStatus.loading) return;

    await handleApiRequest(
      () async {
        emit(state.copyWith(status: ELoadingStatus.loading));

        String? accessToken;
        switch (method) {
          // oauth2 with google
          case EAuthMethod.google:
            accessToken = await authRepository.signinWithGoogle();
            break;
          // oauth2 with naver
          case EAuthMethod.naver:
            accessToken = await authRepository.signinWithNaver();
            break;
          // oauth2 with kakao
          case EAuthMethod.kakao:
            accessToken = await authRepository.signinWithKakao();
            break;
          default:
            break;
        }

        if (accessToken == null) {
          throw Exception('소셜 로그인에 실패했습니다.');
        }

        debugPrint('[AuthBloc/_authSignin] $accessToken');

        var res = await authRepository.signinWithOauth2(
          method: method,
          accessToken: accessToken,
        );

        var jwt = res.data;
        if (jwt == null) {
          throw Exception('로그인에 실패했습니다.');
        }
        // Save jwt at secure_storage
        _saveJwt(jwt);
        // LOGGING
        GoogleAnalytics.instance.event(GALoginEvent(
          method: method,
        ));
        // Return to splash screen
        emit(const AuthState(
          status: ELoadingStatus.loaded,
          authStatus: EAuthStatus.init,
        ));
      },
      state: state,
      emit: emit,
      finallyCall: () async {
        if (state.status == ELoadingStatus.error) {
          emit(const AuthState(
            authStatus: EAuthStatus.unknown,
            status: ELoadingStatus.init,
          ));
        }
        notifyListeners();
      },
    );
  }

  Future<void> _authSignoutHandler(
    AuthSignout event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // Remove jwt at secure_storage
      FlutterSecureStorage storage = const FlutterSecureStorage();
      await storage.delete(key: Strings.jwtToken);

      await authRepository.signoutWithGoogle();
      await authRepository.signoutWithNaver();

      emit(const AuthState(
        status: ELoadingStatus.loaded,
        authStatus: EAuthStatus.unknown,
      ));
    } catch (e) {
      emit(AuthState(
        status: ELoadingStatus.error,
        authStatus: EAuthStatus.unknown,
        message: e.toString(),
      ));
    } finally {
      notifyListeners();
    }
  }

  Future<void> _auth3C1SSigninHandler(
    Auth3C1SSignin event,
    Emitter<AuthState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;

    // Validate
    if (event.email == null || event.email == Strings.nullStr) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '이메일을 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (event.password == null || event.password == Strings.nullStr) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '비밀번호를 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }

    await handleApiRequest(
      () async {
        emit(state.copyWith(status: ELoadingStatus.loading));
        var res = await authRepository.signinWith3C1S(
          email: event.email!,
          password: event.password!,
        );

        var jwt = res.data;
        if (jwt == null) {
          throw Exception('로그인에 실패했습니다.');
        }
        // Save jwt at secure_storage
        _saveJwt(jwt);
        // LOGGING
        GoogleAnalytics.instance.event(GALoginEvent(
          method: EAuthMethod.u3C1S,
        ));
        // Return to splash screen
        emit(const AuthState(
          status: ELoadingStatus.loaded,
          authStatus: EAuthStatus.init,
        ));
      },
      state: state,
      emit: emit,
      finallyCall: () async {
        if (state.status == ELoadingStatus.error) {
          emit(const AuthState(
            authStatus: EAuthStatus.unknown,
            status: ELoadingStatus.init,
          ));
        }
        notifyListeners();
      },
    );
  }

  Future<void> _saveJwt(String jwt) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(
      key: Strings.jwtToken,
      value: jwt,
    );
  }

  Future<void> _authGetUserHandler(
    AuthGetUser event,
    Emitter<AuthState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;

    await handleApiRequest(
      () async {
        emit(state.copyWith(status: ELoadingStatus.loading));
        var res = await userRepository.getUser();
        // Signin failed
        if (res.data == null) {
          emit(const AuthState(
            status: ELoadingStatus.loaded,
            authStatus: EAuthStatus.unknown,
          ));
          return;
        }
        // Signin success, no profile
        if (res.data != null &&
            (res.data!.nickName == null ||
                res.data!.nickName == Strings.nullStr)) {
          emit(AuthState(
            status: ELoadingStatus.loaded,
            authStatus: EAuthStatus.unAuthenticated,
            user: res.data!,
          ));
          // LOGGING
          GoogleAnalytics.instance.event(GALoginEvent(
            method: EAuthMethod.auto,
          ));
          return;
        }
        // Signin success
        emit(AuthState(
          status: ELoadingStatus.loaded,
          authStatus: EAuthStatus.authenticated,
          user: res.data!,
        ));
        // LOGGING
        GoogleAnalytics.instance.event(GALoginEvent(
          method: EAuthMethod.auto,
        ));
      },
      state: state,
      emit: emit,
      finallyCall: () async {
        if (state.status == ELoadingStatus.error) {
          emit(const AuthState(
            authStatus: EAuthStatus.unknown,
            status: ELoadingStatus.init,
          ));
        }
        notifyListeners();
      },
    );
  }

  Future<void> _authSetUserHandler(
    AuthSetUser event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      user: event.user,
      authStatus: event.user.nickName?.isNotEmpty == true
          ? EAuthStatus.authenticated
          : EAuthStatus.unAuthenticated,
    ));
  }
}

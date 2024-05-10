import 'package:child_goods_store_flutter/blocs/auth/auth_bloc.dart';
import 'package:child_goods_store_flutter/repositories/interface/auth_repository_interfece.dart';
import 'package:child_goods_store_flutter/repositories/interface/user_repository_interface.dart';

class AuthBlocSingleton {
  AuthBlocSingleton._constructor();
  static final AuthBlocSingleton _signleton = AuthBlocSingleton._constructor();
  static AuthBlocSingleton get instance => _signleton;

  static late final AuthBloc _bloc;
  static AuthBloc get bloc => _bloc;

  static initializer({
    required IAuthRepository authRepository,
    required IUserRepository userRepository,
  }) {
    _bloc = AuthBloc(
      authRepository: authRepository,
      userRepository: userRepository,
    );
  }
}

library child_goods_store_flutter_app_router;

import 'package:child_goods_store_flutter/GA/ga_route_observer.dart';
import 'package:child_goods_store_flutter/blocs/auth/auth_bloc_singleton.dart';
import 'package:child_goods_store_flutter/blocs/chat/list/chat_list_bloc.dart';
import 'package:child_goods_store_flutter/blocs/chat/room/chat_room_bloc.dart';
import 'package:child_goods_store_flutter/blocs/child/child_bloc.dart';
import 'package:child_goods_store_flutter/blocs/edit_address/edit_address_bloc.dart';
import 'package:child_goods_store_flutter/blocs/edit_child/edit_child_bloc.dart';
import 'package:child_goods_store_flutter/blocs/edit_product/edit_product_bloc.dart';
import 'package:child_goods_store_flutter/blocs/edit_profile/edit_profile_bloc.dart';
import 'package:child_goods_store_flutter/blocs/edit_review/edit_review_bloc.dart';
import 'package:child_goods_store_flutter/blocs/edit_tag/edit_tag_bloc.dart';
import 'package:child_goods_store_flutter/blocs/edit_together/edit_together_bloc.dart';
import 'package:child_goods_store_flutter/blocs/fcm/fcm_cubit.dart';
import 'package:child_goods_store_flutter/blocs/fcm/fcm_cubit_singleton.dart';
import 'package:child_goods_store_flutter/blocs/follow/follow_bloc.dart';
import 'package:child_goods_store_flutter/blocs/product/detail/product_detail_bloc.dart';
import 'package:child_goods_store_flutter/blocs/product/list/product_list_bloc.dart';
import 'package:child_goods_store_flutter/blocs/profile/profile_bloc.dart';
import 'package:child_goods_store_flutter/blocs/profile/profile_tab_bloc.dart';
import 'package:child_goods_store_flutter/blocs/signup/signup_bloc.dart';
import 'package:child_goods_store_flutter/blocs/splash/splash_cubit.dart';
import 'package:child_goods_store_flutter/blocs/together/detail/together_detail_bloc.dart';
import 'package:child_goods_store_flutter/blocs/together/list/together_list_bloc.dart';
import 'package:child_goods_store_flutter/constants/routes.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/auth_status.dart';
import 'package:child_goods_store_flutter/enums/follow_mode.dart';
import 'package:child_goods_store_flutter/enums/http_method.dart';
import 'package:child_goods_store_flutter/flavors.dart';
import 'package:child_goods_store_flutter/models/address/address_model.dart';
import 'package:child_goods_store_flutter/models/child/child_model.dart';
import 'package:child_goods_store_flutter/models/go_router_extra_model.dart';
import 'package:child_goods_store_flutter/models/product/product_model.dart';
import 'package:child_goods_store_flutter/models/review/review_model.dart';
import 'package:child_goods_store_flutter/models/together/together_model.dart';
import 'package:child_goods_store_flutter/pages/chat/chat_page.dart';
import 'package:child_goods_store_flutter/pages/chat_room/chat_room_page.dart';
import 'package:child_goods_store_flutter/pages/child/child_page.dart';
import 'package:child_goods_store_flutter/pages/edit_address/edit_address_page.dart';
import 'package:child_goods_store_flutter/pages/edit_child/edit_child_page.dart';
import 'package:child_goods_store_flutter/pages/edit_product/edit_product_page.dart';
import 'package:child_goods_store_flutter/pages/edit_profile/edit_profile_page.dart';
import 'package:child_goods_store_flutter/pages/edit_review/edit_review_page.dart';
import 'package:child_goods_store_flutter/pages/edit_tag/edit_tag_page.dart';
import 'package:child_goods_store_flutter/pages/edit_together/edit_together_page.dart';
import 'package:child_goods_store_flutter/pages/follow/follow_page.dart';
import 'package:child_goods_store_flutter/pages/notification/notification_page.dart';
import 'package:child_goods_store_flutter/pages/product/product_page.dart';
import 'package:child_goods_store_flutter/pages/product_detail/product_detail_page.dart';
import 'package:child_goods_store_flutter/pages/profile/profile_page.dart';
import 'package:child_goods_store_flutter/pages/settings/settings_page.dart';
import 'package:child_goods_store_flutter/pages/ship/ship_page.dart';
import 'package:child_goods_store_flutter/pages/signin/signin_page.dart';
import 'package:child_goods_store_flutter/pages/signup/signup_page.dart';
import 'package:child_goods_store_flutter/pages/splash/splash_page.dart';
import 'package:child_goods_store_flutter/pages/together/together_page.dart';
import 'package:child_goods_store_flutter/pages/together_detail/together_detail_page.dart';
import 'package:child_goods_store_flutter/repositories/interface/auth_repository_interfece.dart';
import 'package:child_goods_store_flutter/repositories/interface/chat_repository_interface.dart';
import 'package:child_goods_store_flutter/repositories/interface/child_repository_interface.dart';
import 'package:child_goods_store_flutter/repositories/interface/data_repository_interface.dart';
import 'package:child_goods_store_flutter/repositories/interface/image_repository_interface.dart';
import 'package:child_goods_store_flutter/repositories/interface/product_repository_interfave.dart';
import 'package:child_goods_store_flutter/repositories/interface/profile_repository_interface.dart';
import 'package:child_goods_store_flutter/repositories/interface/review_repository_interface.dart';
import 'package:child_goods_store_flutter/repositories/interface/search_repository_interface.dart';
import 'package:child_goods_store_flutter/repositories/interface/together_repository_interface.dart';
import 'package:child_goods_store_flutter/repositories/interface/user_repository_interface.dart';
import 'package:child_goods_store_flutter/utils/page_transition.dart';
import 'package:child_goods_store_flutter/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

/// Seperate [_appHomeRoute]
part 'app_home_route.dart';

class AppRouter extends StatefulWidget {
  const AppRouter({super.key});

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  late GoRouter _routerConfig;

  // App start route after splash
  String _appStartRoute() {
    if (FCMCubitSingleton.cubit.state.data?.code == 1000) {
      FCMCubitSingleton.cubit.resetFCM();
      return '${Routes.chat}/${SubRoutes.chatRoom}/1';
    }
    return Routes.product;
  }

  @override
  void initState() {
    super.initState();

    // Initialize AuthBlocSingleton
    AuthBlocSingleton.initializer(
      authRepository: context.read<IAuthRepository>(),
      userRepository: context.read<IUserRepository>(),
    );

    // Setting router configs
    _routerConfig = GoRouter(
      initialLocation: Routes.root,
      refreshListenable: AuthBlocSingleton.bloc,
      observers: [GARouteObserver()],
      redirect: (context, state) {
        final authState = AuthBlocSingleton.bloc.state;
        final allowPageInUnknownState = [Routes.signup]; // Routes.phoneVerify
        final allowPageInUnAuthState = []; // Routes.phoneVerify
        final blockPageInAuthState = [Routes.root, Routes.signin];

        if (authState.authStatus == EAuthStatus.init) {
          return Routes.root;
        }
        if (authState.authStatus == EAuthStatus.unknown) {
          return allowPageInUnknownState.contains(state.uri.toString())
              ? state.uri.toString()
              : Routes.signin;
        }
        if (authState.authStatus == EAuthStatus.unAuthenticated) {
          return allowPageInUnAuthState.contains(state.uri.toString())
              ? state.uri.toString()
              : Routes.editProfile;
        }
        if (authState.authStatus == EAuthStatus.authenticated) {
          return blockPageInAuthState.contains(state.uri.toString())
              ? _appStartRoute()
              : state.uri.toString();
        }
        return state.uri.toString();
      },
      routes: [
        GoRoute(
          path: Routes.root,
          pageBuilder: (context, state) => PageTransition.cupertino(
            key: state.pageKey,
            name: state.fullPath,
            child: BlocProvider(
              create: (context) => SplashCubit(),
              child: const SplashPage(),
            ),
          ),
        ),
        GoRoute(
          path: Routes.signin,
          pageBuilder: (context, state) => PageTransition.cupertino(
            key: state.pageKey,
            name: state.fullPath,
            child: const SigninPage(),
          ),
        ),
        GoRoute(
          path: Routes.signup,
          pageBuilder: (context, state) => PageTransition.cupertino(
            key: state.pageKey,
            name: state.fullPath,
            child: BlocProvider(
              create: (context) => SignupBloc(
                authRepository: context.read<IAuthRepository>(),
              ),
              child: const SignupPage(),
            ),
          ),
        ),
        // GoRoute(
        //   path: Routes.phoneVerify,
        //   pageBuilder: (context, state) => PageTransition.cupertino(
        //     key: state.pageKey,
        //     name: state.fullPath,
        //     child: BlocProvider(
        //       create: (context) => PhoneVerifyBloc(
        //         authRepository: context.read<AuthRepository>(),
        //       ),
        //       child: const PhoneVerifyPage(),
        //     ),
        //   ),
        // ),
        GoRoute(
          path: Routes.editProfile,
          pageBuilder: (context, state) => PageTransition.cupertino(
            key: state.pageKey,
            name: state.fullPath,
            child: BlocProvider(
              create: (context) => EditProfileBloc(
                userRepository: context.read<IUserRepository>(),
                imageRepository: context.read<IImageRepository>(),
                user: AuthBlocSingleton.bloc.state.user,
                httpMethod:
                    (AuthBlocSingleton.bloc.state.user?.nickName == null ||
                            AuthBlocSingleton.bloc.state.user?.nickName ==
                                Strings.nullStr)
                        ? EHttpMethod.post
                        : EHttpMethod.patch,
              ),
              child: const EditProfilePage(),
            ),
          ),
        ),
        GoRoute(
          path: Routes.editTag,
          pageBuilder: (context, state) => PageTransition.cupertino(
            key: state.pageKey,
            name: state.fullPath,
            child: BlocProvider(
              create: (context) => EditTagBloc(
                searchRepository: context.read<ISearchRepository>(),
                tags: (state.extra as GoRouterExtraModel<List<String>>?)?.data,
              ),
              child: const EditTagPage(),
            ),
          ),
        ),
        GoRoute(
          path: Routes.editAddress,
          pageBuilder: (context, state) => PageTransition.cupertino(
            key: state.pageKey,
            name: state.fullPath,
            child: BlocProvider(
              create: (context) => EditAddressBloc(
                dataRepository: context.read<IDataRepository>(),
                httpMethod:
                    (state.extra as GoRouterExtraModel<AddressModel>?)?.data ==
                            null
                        ? EHttpMethod.post
                        : EHttpMethod.patch,
                address:
                    (state.extra as GoRouterExtraModel<AddressModel>?)?.data,
              ),
              child: const EditAddressPage(),
            ),
          ),
        ),
        _appHomeRoute(),
        GoRoute(
          path: '${Routes.productDetail}/:productId',
          pageBuilder: (context, state) => PageTransition.cupertino(
            key: state.pageKey,
            name: state.fullPath,
            arguments: {
              'id': int.parse(state.pathParameters['productId'] ?? '-1'),
            },
            child: BlocProvider(
              create: (context) => ProductDetailBloc(
                productRepository: context.read<IProductRepository>(),
                chatRepository: context.read<IChatRepository>(),
                productId: int.parse(state.pathParameters['productId'] ?? '-1'),
              ),
              child: const ProductDetailPage(),
            ),
          ),
        ),
        GoRoute(
          path: '${Routes.togetherDetail}/:togetherId',
          pageBuilder: (context, state) => PageTransition.cupertino(
            key: state.pageKey,
            name: state.fullPath,
            arguments: {
              'id': int.parse(state.pathParameters['togetherId'] ?? '-1'),
            },
            child: BlocProvider(
              create: (context) => TogetherDetailBloc(
                togetherRepository: context.read<ITogetherRepository>(),
                togetherId:
                    int.parse(state.pathParameters['togetherId'] ?? '-1'),
              ),
              child: const TogetherDetailPage(),
            ),
          ),
        ),
        GoRoute(
          path: '${Routes.profile}/:userId',
          pageBuilder: (context, state) => PageTransition.cupertino(
            key: state.pageKey,
            name: state.fullPath,
            arguments: {
              'id': int.parse(state.pathParameters['userId'] ?? '-1'),
            },
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => ProfileBloc(
                    userRepository: context.read<IUserRepository>(),
                    userId: int.parse(state.pathParameters['userId'] ?? '-1'),
                  ),
                ),
                BlocProvider(
                  create: (context) => ProfileTabBloc(
                    profileRepository: context.read<IProfileRepository>(),
                    reviewRepository: context.read<IReviewRepository>(),
                    userId: int.parse(state.pathParameters['userId'] ?? '-1'),
                  ),
                ),
              ],
              child: const ProfilePage(
                popAble: true,
              ),
            ),
          ),
        ),
        GoRoute(
          path: '${Routes.follow}/:userId',
          pageBuilder: (context, state) => PageTransition.cupertino(
            key: state.pageKey,
            name: state.fullPath,
            arguments: {
              'id': int.parse(state.pathParameters['userId'] ?? '-1'),
            },
            child: BlocProvider(
              create: (context) => FollowBloc(
                userRepository: context.read<IUserRepository>(),
                userId: int.parse(state.pathParameters['userId'] ?? '-1'),
                mode: (state.uri.queryParameters['mode'])!.followModeEnum,
              ),
              child: FollowPage(
                mode: (state.uri.queryParameters['mode'])!.followModeEnum,
              ),
            ),
          ),
        ),
        GoRoute(
          path: Routes.editProduct,
          pageBuilder: (context, state) => PageTransition.cupertino(
            key: state.pageKey,
            name: state.fullPath,
            arguments: {
              'id': (state.extra as GoRouterExtraModel<ProductModel>?)
                      ?.data
                      ?.productId ??
                  -1
            },
            child: BlocProvider(
              create: (context) => EditProductBloc(
                productRepository: context.read<IProductRepository>(),
                imageRepository: context.read<IImageRepository>(),
                httpMethod:
                    (state.extra as GoRouterExtraModel<ProductModel>?)?.data ==
                            null
                        ? EHttpMethod.post
                        : EHttpMethod.patch,
                product:
                    (state.extra as GoRouterExtraModel<ProductModel>?)?.data,
              ),
              child: const EditProductPage(),
            ),
          ),
        ),
        GoRoute(
          path: Routes.editTogether,
          pageBuilder: (context, state) => PageTransition.cupertino(
            key: state.pageKey,
            name: state.fullPath,
            arguments: {
              'id': (state.extra as GoRouterExtraModel<TogetherModel>?)
                      ?.data
                      ?.togetherId ??
                  -1
            },
            child: BlocProvider(
              create: (context) => EditTogetherBloc(
                togetherRepository: context.read<ITogetherRepository>(),
                imageRepository: context.read<IImageRepository>(),
                httpMethod:
                    (state.extra as GoRouterExtraModel<TogetherModel>?)?.data ==
                            null
                        ? EHttpMethod.post
                        : EHttpMethod.patch,
                together:
                    (state.extra as GoRouterExtraModel<TogetherModel>?)?.data,
              ),
              child: const EditTogetherPage(),
            ),
          ),
        ),
        GoRoute(
          path: Routes.editChild,
          pageBuilder: (context, state) => PageTransition.cupertino(
            key: state.pageKey,
            name: state.fullPath,
            arguments: {
              'id': (state.extra as GoRouterExtraModel<ChildModel>?)
                      ?.data
                      ?.childId ??
                  -1
            },
            child: BlocProvider(
              create: (context) => EditChildBloc(
                childRepository: context.read<IChildRepository>(),
                imageRepository: context.read<IImageRepository>(),
                httpMethod:
                    (state.extra as GoRouterExtraModel<ChildModel>?)?.data ==
                            null
                        ? EHttpMethod.post
                        : EHttpMethod.patch,
                child: (state.extra as GoRouterExtraModel<ChildModel>?)?.data,
              ),
              child: const EditChildPage(),
            ),
          ),
        ),
        GoRoute(
          path: Routes.editReview,
          pageBuilder: (context, state) => PageTransition.cupertino(
            key: state.pageKey,
            name: state.fullPath,
            arguments: {
              'id': (state.extra as GoRouterExtraModel<ReviewModel>?)
                      ?.data
                      ?.reviewId ??
                  -1
            },
            child: BlocProvider(
              create: (context) => EditReviewBloc(
                reviewRepository: context.read<IReviewRepository>(),
                productRepository: context.read<IProductRepository>(),
                togetherRepository: context.read<ITogetherRepository>(),
                httpMethod:
                    (state.extra as GoRouterExtraModel<ReviewModel>?)?.data ==
                            null
                        ? EHttpMethod.post
                        : EHttpMethod.patch,
                type:
                    (state.extra as GoRouterExtraModel<ReviewModel>).itemType!,
                id: (state.extra as GoRouterExtraModel<ReviewModel>).itemId!,
                review: (state.extra as GoRouterExtraModel<ReviewModel>?)?.data,
              ),
              child: const EditReviewPage(),
            ),
          ),
        ),

        GoRoute(
          path: Routes.settings,
          pageBuilder: (context, state) => PageTransition.cupertino(
            key: state.pageKey,
            name: state.fullPath,
            child: const SettingsPage(),
          ),
          routes: [
            GoRoute(
              path: SubRoutes.ship,
              pageBuilder: (context, state) => PageTransition.cupertino(
                key: state.pageKey,
                name: state.fullPath,
                child: const ShipPage(),
              ),
            ),
            GoRoute(
              path: SubRoutes.notification,
              pageBuilder: (context, state) => PageTransition.cupertino(
                key: state.pageKey,
                name: state.fullPath,
                child: const NotificationPage(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _routerConfig,
      debugShowCheckedModeBanner: false,
      title: F.title,
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white).copyWith(
          background: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.cyan.shade600,
        splashColor: Colors.black.withOpacity(0.1),
        dividerColor: Colors.black.withOpacity(0.2),
        bottomSheetTheme: const BottomSheetThemeData(
          surfaceTintColor: Colors.transparent,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          scrolledUnderElevation: Sizes.size1,
          titleTextStyle: TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko'),
        Locale('en'),
      ],
      locale: const Locale('ko'),
      builder: (context, child) => _flavorBanner(
        child: child ?? const SizedBox(),
        show: F.appFlavor != Flavor.prod,
      ),
    );
  }

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) =>
      show
          ? Banner(
              location: BannerLocation.topStart,
              message: F.name,
              color: Colors.green.withOpacity(0.6),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                letterSpacing: 1.0,
              ),
              textDirection: TextDirection.ltr,
              child: child,
            )
          : Container(
              child: child,
            );
}

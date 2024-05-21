part of child_goods_store_flutter_app_router;

StatefulShellRoute _appHomeRoute() {
  return StatefulShellRoute.indexedStack(
    pageBuilder: (context, state, navigationShell) => PageTransition.cupertino(
      key: state.pageKey,
      // ignore `name` field for disable GA
      child: BlocListener<FCMCubit, FCMState>(
        bloc: FCMCubitSingleton.cubit,
        listener: (context, state) {
          if (state.data != null) {
            // TODO: Replace event
            AppSnackbar.show(
              context,
              message: state.body ?? Strings.unknownFail,
            );
          }
          context.go(
            '${Routes.chat}/${SubRoutes.chatRoom}',
            extra: const GoRouterExtraModel<int>(data: 1),
          );
        },
        child: Scaffold(
          body: navigationShell,
          bottomNavigationBar: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            height: state.uri.toString().contains(SubRoutes.chatRoom)
                ? 0
                : Sizes.size60 + MediaQuery.paddingOf(context).bottom,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: Sizes.size3,
                  spreadRadius: Sizes.size1,
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: Sizes.size60 + MediaQuery.paddingOf(context).bottom,
                child: BottomNavigationBar(
                  enableFeedback: false,
                  type: BottomNavigationBarType.fixed,
                  unselectedLabelStyle: const TextStyle(fontSize: Sizes.size8),
                  selectedLabelStyle: const TextStyle(fontSize: Sizes.size10),
                  selectedIconTheme: const IconThemeData(size: Sizes.size28),
                  items: [
                    const BottomNavigationBarItem(
                      label: '중고거래',
                      icon: Icon(Icons.home),
                    ),
                    BottomNavigationBarItem(
                      label: '공동구매',
                      icon: Transform.scale(
                        scale: 0.8,
                        child: const Icon(FontAwesomeIcons.boxesStacked),
                      ),
                    ),
                    const BottomNavigationBarItem(
                      label: '자녀',
                      icon: Icon(Icons.child_care_rounded),
                    ),
                    const BottomNavigationBarItem(
                      label: '채팅',
                      icon: Icon(Icons.chat_rounded),
                    ),
                    const BottomNavigationBarItem(
                      label: '내 정보',
                      icon: Icon(Icons.person_rounded),
                    ),
                  ],
                  currentIndex: navigationShell.currentIndex,
                  onTap: (value) => navigationShell.goBranch(value),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            name: Routes.product,
            path: Routes.product,
            builder: (context, state) => BlocProvider(
              create: (context) => ProductListBloc(
                productRepository: context.read<IProductRepository>(),
              ),
              child: const ProductPage(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            name: Routes.together,
            path: Routes.together,
            builder: (context, state) => BlocProvider(
              create: (context) => TogetherListBloc(
                togetherRepository: context.read<ITogetherRepository>(),
              ),
              child: const TogetherPage(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            name: Routes.child,
            path: Routes.child,
            builder: (context, state) => BlocProvider(
              create: (context) => ChildBloc(
                childRepository: context.read<IChildRepository>(),
              ),
              child: const ChildPage(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            name: Routes.chat,
            path: Routes.chat,
            builder: (context, state) => BlocProvider(
              create: (context) => ChatListBloc(
                chatRepository: context.read<IChatRepository>(),
              ),
              child: const ChatPage(),
            ),
            routes: [
              GoRoute(
                path: SubRoutes.chatRoom,
                pageBuilder: (context, state) => PageTransition.cupertino(
                  key: state.pageKey,
                  name: state.fullPath,
                  arguments: {
                    'id': (state.extra as GoRouterExtraModel<int>).data ?? -1
                  },
                  child: BlocProvider(
                    create: (context) => ChatRoomBloc(
                      chatRepository: context.read<IChatRepository>(),
                      productRepository: context.read<IProductRepository>(),
                      togetherRepository: context.read<ITogetherRepository>(),
                      chatRoomId:
                          (state.extra as GoRouterExtraModel<int>).data ?? -1,
                    ),
                    child: const ChatRoomPage(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            name: Routes.profile,
            path: Routes.profile,
            builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => ProfileBloc(
                    userRepository: context.read<IUserRepository>(),
                    userId: AuthBlocSingleton.bloc.state.user!.userId!,
                  ),
                ),
                BlocProvider(
                  create: (context) => ProfileTabBloc(
                    profileRepository: context.read<IProfileRepository>(),
                    reviewRepository: context.read<IReviewRepository>(),
                    userId: AuthBlocSingleton.bloc.state.user!.userId!,
                  ),
                ),
              ],
              child: const ProfilePage(
                popAble: false,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

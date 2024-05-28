import 'package:child_goods_store_flutter/blocs/auth/auth_bloc.dart';
import 'package:child_goods_store_flutter/blocs/auth/auth_bloc_singleton.dart';
import 'package:child_goods_store_flutter/blocs/auth/auth_state.dart';
import 'package:child_goods_store_flutter/blocs/profile/profile_bloc.dart';
import 'package:child_goods_store_flutter/blocs/profile/profile_event.dart';
import 'package:child_goods_store_flutter/blocs/profile/profile_state.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/pages/profile/widgets/profile_card.dart';
import 'package:child_goods_store_flutter/pages/profile/widgets/profile_tab_heart.dart';
import 'package:child_goods_store_flutter/pages/profile/widgets/profile_tab_myitem.dart';
import 'package:child_goods_store_flutter/pages/profile/widgets/profile_tab_purchase.dart';
import 'package:child_goods_store_flutter/pages/profile/widgets/profile_tab_review.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:child_goods_store_flutter/widgets/app_snackbar.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  final bool popAble;

  const ProfilePage({
    super.key,
    required this.popAble,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final GlobalKey<ExtendedNestedScrollViewState> _nestedScrollKey =
      GlobalKey<ExtendedNestedScrollViewState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.popAble ? 2 : 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTapRetryGetProfile() {
    context.read<ProfileBloc>().add(ProfileGet());
  }

  void _onTapTab(int index) {
    if (!_tabController.indexIsChanging) {
      _nestedScrollKey.currentState?.innerController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileBloc, ProfileState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == ELoadingStatus.error &&
                state.profileStatus == ELoadingStatus.loaded) {
              AppSnackbar.show(
                context,
                message: state.message ?? Strings.unknownFail,
              );
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          bloc: AuthBlocSingleton.bloc,
          listenWhen: (previous, current) => previous.user != current.user,
          listener: (context, state) {
            context.read<ProfileBloc>().add(ProfileGet());
          },
        )
      ],
      child: Scaffold(
        appBar: widget.popAble
            ? AppBar(
                title: const AppFont('프로필'),
              )
            : null,
        body: SafeArea(
          bottom: widget.popAble ? true : false,
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state.profileStatus == ELoadingStatus.loaded) {
                return _buildBody(context, state: state);
              }
              if (state.status == ELoadingStatus.error &&
                  state.profileStatus == ELoadingStatus.loading) {
                return _buildError(
                  context,
                  message: state.message ?? Strings.unknownFail,
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context, {
    required ProfileState state,
  }) {
    return ExtendedNestedScrollView(
      key: _nestedScrollKey,
      physics: const BouncingScrollPhysics(),
      onlyOneScrollInBody: true,
      pinnedHeaderSliverHeightBuilder: () => Sizes.size52,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverToBoxAdapter(
          child: ProfileCard(
            userProfile: state.userProfile!,
            popAble: widget.popAble,
          ),
        ),
        SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          toolbarHeight: Sizes.size52,
          title: SizedBox(
            height: Sizes.size52,
            child: TabBar(
              controller: _tabController,
              onTap: _onTapTab,
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size20,
              ),
              labelPadding: const EdgeInsets.symmetric(
                horizontal: Sizes.size20,
              ),
              tabs: [
                const Tab(
                  text: '게시한 글',
                  height: Sizes.size52,
                ),
                if (!widget.popAble)
                  const Tab(
                    text: '관심 목록',
                    height: Sizes.size52,
                  ),
                if (!widget.popAble)
                  const Tab(
                    text: '구매 내역',
                    height: Sizes.size52,
                  ),
                const Tab(
                  text: '받은 후기',
                  height: Sizes.size52,
                ),
              ],
            ),
          ),
        ),
      ],
      body: TabBarView(
        controller: _tabController,
        children: [
          ProfileTabMyItem(
            nestedScrollKey: _nestedScrollKey,
          ),
          if (!widget.popAble)
            ProfileTabHeart(
              nestedScrollKey: _nestedScrollKey,
            ),
          if (!widget.popAble)
            ProfileTabPurchase(
              nestedScrollKey: _nestedScrollKey,
            ),
          ProfileTabReview(
            nestedScrollKey: _nestedScrollKey,
          ),
        ],
      ),
    );
  }

  Widget _buildError(
    BuildContext context, {
    required String message,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppFont(message),
          Gaps.v20,
          AppInkButton(
            onTap: _onTapRetryGetProfile,
            child: const AppFont(
              '재시도',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

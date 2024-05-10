import 'package:child_goods_store_flutter/blocs/child/child_bloc.dart';
import 'package:child_goods_store_flutter/blocs/child/child_event.dart';
import 'package:child_goods_store_flutter/blocs/child/child_state.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/pages/child/widgets/child_app_bar.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:child_goods_store_flutter/widgets/common/product_listitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChildPage extends StatefulWidget {
  const ChildPage({super.key});

  @override
  State<ChildPage> createState() => _ChildPageState();
}

class _ChildPageState extends State<ChildPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent) {
        _getProducts();
      }
    });
  }

  void _getProducts({bool force = false}) {
    var bloc = context.read<ChildBloc>();
    if (bloc.state.status != ELoadingStatus.error || force) {
      bloc.add(ChildGetProductList());
    }
  }

  void _onTapRetryGetChildren() {
    context.read<ChildBloc>().add(ChildGetChildren());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppFont('자녀 맞춤추천'),
        elevation: Sizes.size1,
      ),
      body: SafeArea(
        child: BlocBuilder<ChildBloc, ChildState>(
          builder: (context, state) {
            if (state.childListStatus == ELoadingStatus.loaded) {
              return _buildBody(context, state: state);
            }
            if (state.status == ELoadingStatus.error &&
                state.childListStatus == ELoadingStatus.loading) {
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
    );
  }

  Widget _buildBody(
    BuildContext context, {
    required ChildState state,
  }) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          flexibleSpace: ChildAppBar(
            children: state.childList,
            selectedChild: state.selectedChild,
          ),
          collapsedHeight: 160,
          floating: true,
          snap: true,
        ),
        BlocConsumer<ChildBloc, ChildState>(
          listener: (context, state) {
            if (state.status == ELoadingStatus.loaded) {
              _scrollListener();
            }
          },
          builder: (context, state) => SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size20,
              vertical: Sizes.size10,
            ),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: Sizes.size16,
                mainAxisSpacing: Sizes.size16,
              ),
              itemBuilder: (context, index) => ProductListItem(
                product: state.productList[index],
              ),
              itemCount: state.productList.length,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
            child: Center(
              child: BlocBuilder<ChildBloc, ChildState>(
                builder: (context, state) {
                  if (state.selectedChild == null) {
                    return const Center(
                      child: AppFont('자녀를 추가하여 맟춤 추천을 받아보세요!'),
                    );
                  }
                  if (state.status == ELoadingStatus.error) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppFont(state.message ?? Strings.unknownFail),
                        Gaps.v20,
                        AppInkButton(
                          onTap: () => _getProducts(force: true),
                          child: const AppFont(
                            '재시도',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
        ),
      ],
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
            onTap: _onTapRetryGetChildren,
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

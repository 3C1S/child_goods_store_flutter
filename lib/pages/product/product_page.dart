import 'package:child_goods_store_flutter/blocs/product/list/product_list_bloc.dart';
import 'package:child_goods_store_flutter/blocs/product/list/product_list_event.dart';
import 'package:child_goods_store_flutter/blocs/product/list/product_list_state.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/routes.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/flavors.dart';
import 'package:child_goods_store_flutter/models/go_router_extra_model.dart';
import 'package:child_goods_store_flutter/pages/product/widgets/product_app_bar.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:child_goods_store_flutter/widgets/app_snackbar.dart';
import 'package:child_goods_store_flutter/widgets/common/product_listitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
    var bloc = context.read<ProductListBloc>();
    if (bloc.state.status != ELoadingStatus.error || force) {
      bloc.add(ProductListGet());
    }
  }

  void _pushAddProduct() async {
    var res = await context.push<GoRouterExtraModel<int>>(Routes.editProduct);

    if (res?.data != null && mounted) {
      AppSnackbar.show(
        context,
        message: '상품이 등록되었습니다!',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppFont(F.title),
        elevation: Sizes.size1,
      ),
      floatingActionButton: AppInkButton(
        padding: const EdgeInsets.all(Sizes.size16),
        borderRadSize: Sizes.size40,
        color: Theme.of(context).primaryColor.withOpacity(0.6),
        onTap: _pushAddProduct,
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const SliverAppBar(
            flexibleSpace: ProductAppBar(),
            collapsedHeight: 210,
            floating: true,
            snap: true,
          ),
          BlocConsumer<ProductListBloc, ProductListState>(
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
                  product: state.products[index],
                ),
                itemCount: state.products.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
              child: Center(
                child: BlocBuilder<ProductListBloc, ProductListState>(
                  builder: (context, state) {
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
      ),
    );
  }
}

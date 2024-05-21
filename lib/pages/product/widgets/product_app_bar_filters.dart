import 'package:child_goods_store_flutter/blocs/product/list/product_list_bloc.dart';
import 'package:child_goods_store_flutter/blocs/product/list/product_list_event.dart';
import 'package:child_goods_store_flutter/blocs/product/list/product_list_state.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/enums/child_age.dart';
import 'package:child_goods_store_flutter/utils/other_extensions.dart';
import 'package:child_goods_store_flutter/widgets/app_bottom_sheet.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductAppBarFilters extends StatefulWidget {
  const ProductAppBarFilters({super.key});

  @override
  State<ProductAppBarFilters> createState() => ProductAppBarFiltersState();
}

class ProductAppBarFiltersState extends State<ProductAppBarFilters> {
  bool _noPriceFilter(ProductListState state) {
    return state.minPrice == ProductListState.MIN_PRICE &&
        state.maxPrice == ProductListState.MAX_PRICE;
  }

  void _onTapAgeFilter() {
    AppBottomSheet.show(
      context,
      child: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var age in EChildAge.values)
              AppInkButton(
                color: Colors.transparent,
                shadowColor: Colors.transparent,
                onTap: () {
                  context
                      .read<ProductListBloc>()
                      .add(ProductListChangeAgeFilter(age: age));
                  context.pop();
                },
                child: Center(
                  child: AppFont(
                    age.text,
                    color: age == context.read<ProductListBloc>().state.age
                        ? Theme.of(context).primaryColor
                        : null,
                  ),
                ),
              ),
            AppInkButton(
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              onTap: () {
                context
                    .read<ProductListBloc>()
                    .add(ProductListChangeAgeFilter(reset: true));
                context.pop();
              },
              child: const Center(
                child: AppFont(
                  '필터 초기화',
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapPriceFilter(ProductListBloc bloc) {
    AppBottomSheet.show(
      context,
      child: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<ProductListBloc, ProductListState>(
              bloc: bloc,
              builder: (context, state) => Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(Sizes.size10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: Sizes.size3,
                          spreadRadius: Sizes.size1,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const AppFont('최저가'),
                                AppFont('${state.minPrice.price()} 원'),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: Sizes.size1,
                          height: Sizes.size20,
                          color: Colors.black.withOpacity(0.2),
                        ),
                        Flexible(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const AppFont('최고가'),
                                AppFont(
                                    '${state.maxPrice.price()}${state.maxPrice == ProductListState.MAX_PRICE ? '+' : ''} 원'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.v12,
                  RangeSlider(
                    activeColor: Theme.of(context).primaryColor,
                    values: RangeValues(
                      state.minPrice.toDouble(),
                      state.maxPrice.toDouble(),
                    ),
                    min: ProductListState.MIN_PRICE.toDouble(),
                    max: ProductListState.MAX_PRICE.toDouble(),
                    onChanged: (value) {
                      bloc.add(ProductListChangePriceFilter(
                        minPrice: value.start.toInt(),
                        maxPrice: value.end.toInt(),
                      ));
                    },
                  ),
                ],
              ),
            ),
            Gaps.v10,
            AppInkButton(
              onTap: () {
                context.pop();
              },
              child: const Center(
                child: AppFont(
                  '닫기',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapApply() {
    context.read<ProductListBloc>().add(ProductListApplyFilter());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      builder: (context, state) => Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size20,
                vertical: Sizes.size3,
              ),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  AppInkButton(
                    onTap: _onTapAgeFilter,
                    color: state.age == null
                        ? Theme.of(context).scaffoldBackgroundColor
                        : null,
                    child: AppFont(
                      '연령 - ${state.age?.text ?? '필터 없음'}',
                      color: state.age == null ? null : Colors.white,
                    ),
                  ),
                  Gaps.h10,
                  AppInkButton(
                    onTap: () =>
                        _onTapPriceFilter(context.read<ProductListBloc>()),
                    color: _noPriceFilter(state)
                        ? Theme.of(context).scaffoldBackgroundColor
                        : null,
                    child: AppFont(
                      '가격대 - ${_noPriceFilter(state) ? '필터 없음' : '${state.minPrice.price()} ~ ${state.maxPrice.price()}${state.maxPrice == ProductListState.MAX_PRICE ? '+' : ''}'}',
                      color: _noPriceFilter(state) ? null : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!state.applyFilter)
            Padding(
              padding: const EdgeInsets.only(
                right: Sizes.size20,
                left: Sizes.size10,
              ),
              child: AppInkButton(
                onTap: _onTapApply,
                child: const AppFont(
                  '적용',
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

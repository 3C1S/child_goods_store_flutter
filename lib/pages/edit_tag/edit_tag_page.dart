import 'package:child_goods_store_flutter/blocs/edit_tag/edit_tag_bloc.dart';
import 'package:child_goods_store_flutter/blocs/edit_tag/edit_tag_event.dart';
import 'package:child_goods_store_flutter/blocs/edit_tag/edit_tag_state.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/models/go_router_extra_model.dart';
import 'package:child_goods_store_flutter/pages/edit_tag/widgets/edit_tag_item.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_h_spliter.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:child_goods_store_flutter/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditTagPage extends StatefulWidget {
  const EditTagPage({super.key});

  @override
  State<EditTagPage> createState() => _EditTagPageState();
}

class _EditTagPageState extends State<EditTagPage> {
  late final TextEditingController _queryController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _queryController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _queryController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onChangeQuery(String query) {
    context.read<EditTagBloc>().add(EditTagChangeQuery(query));
  }

  void _onAddTag(String tag) {
    context.read<EditTagBloc>().add(EditTagAdd(tag));
    _queryController.text = '';
    _scrollController.jumpTo(0);
  }

  void _onTapComplete() {
    var res = context.read<EditTagBloc>().state.tags;
    context.pop(GoRouterExtraModel<List<String>>(data: res));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppFont('태그 수정'),
        centerTitle: false,
      ),
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<EditTagBloc, EditTagState>(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size20,
                vertical: Sizes.size10,
              ),
              child: AppTextFormField(
                controller: _queryController,
                hintText: '태그 검색',
                onChange: _onChangeQuery,
              ),
            ),
            SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size20,
              ),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var tag in state.tags.reversed) EditTagItem(tag: tag),
                ],
              ),
            ),
            Gaps.v10,
            const AppHSpliter(),
            Expanded(
              child: Material(
                child: ListView.separated(
                  itemBuilder: (context, index) => AppInkButton(
                    onTap: () => _onAddTag(state.queryResult[index]),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shadowColor: Colors.transparent,
                    borderRadSize: 0,
                    child: AppFont(
                      state.queryResult[index],
                    ),
                  ),
                  separatorBuilder: (context, index) => const AppHSpliter(),
                  itemCount: state.queryResult.length,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppInkButton(
        onTap: _onTapComplete,
        borderRadSize: 0,
        padding: EdgeInsets.zero,
        child: Container(
          width: double.infinity,
          height: Sizes.size60,
          margin: EdgeInsets.only(
            bottom: MediaQuery.viewPaddingOf(context).bottom,
          ),
          child: const Center(
            child: AppFont(
              '수정 완료',
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

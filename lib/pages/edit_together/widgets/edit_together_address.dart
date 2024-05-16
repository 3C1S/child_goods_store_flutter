import 'package:child_goods_store_flutter/blocs/edit_together/edit_together_bloc.dart';
import 'package:child_goods_store_flutter/blocs/edit_together/edit_together_event.dart';
import 'package:child_goods_store_flutter/blocs/edit_together/edit_together_state.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:child_goods_store_flutter/widgets/app_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpostal/kpostal.dart';

class EditTogetherAddress extends StatefulWidget {
  const EditTogetherAddress({super.key});

  @override
  State<EditTogetherAddress> createState() => _EditTogetherAddressState();
}

class _EditTogetherAddressState extends State<EditTogetherAddress> {
  late final TextEditingController _detailAddressController;

  @override
  void initState() {
    super.initState();
    _detailAddressController = TextEditingController(
      text: context.read<EditTogetherBloc>().state.together.detailAddress,
    );
  }

  @override
  void dispose() {
    _detailAddressController.dispose();
    super.dispose();
  }

  void _onTapEditAddress() async {
    Kpostal? result = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CupertinoPageTransition(
          primaryRouteAnimation: animation,
          secondaryRouteAnimation: secondaryAnimation,
          linearTransition: false,
          child: KpostalView(
            loadingColor: Theme.of(context).primaryColorDark,
          ),
        ),
      ),
    );

    if (result?.address != null && mounted) {
      context
          .read<EditTogetherBloc>()
          .add(EditTogetherChangeAddress(result!.address));
    }
  }

  void _onChangeDetailAddress(String detailAddress) {
    context
        .read<EditTogetherBloc>()
        .add(EditTogetherChangeDetailAddress(detailAddress));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _onTapEditAddress,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const AppFont(
                    '거래 희망장소',
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w700,
                  ),
                  Gaps.h10,
                  SizedBox(
                    width: Sizes.size40,
                    height: Sizes.size40,
                    child: AppInkButton(
                      borderRadSize: Sizes.size20,
                      onTap: _onTapEditAddress,
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: Sizes.size20,
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.v5,
              Container(
                padding: const EdgeInsets.all(Sizes.size10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: Sizes.size1,
                    color: Colors.grey.shade200,
                  ),
                  borderRadius: BorderRadius.circular(Sizes.size5),
                ),
                child: BlocBuilder<EditTogetherBloc, EditTogetherState>(
                  builder: (context, state) => AppFont(
                    state.together.address ?? '도로명 주소를 검색해주세요.',
                    fontSize: Sizes.size14,
                  ),
                ),
              ),
            ],
          ),
        ),
        Gaps.v5,
        AppTextFormField(
          hintText: '상세 주소',
          controller: _detailAddressController,
          onChange: _onChangeDetailAddress,
        ),
      ],
    );
  }
}

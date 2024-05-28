import 'dart:io';
import 'package:child_goods_store_flutter/blocs/app_data/app_data_bloc.dart';
import 'package:child_goods_store_flutter/blocs/edit_profile/edit_profile_bloc.dart';
import 'package:child_goods_store_flutter/blocs/edit_profile/edit_profile_event.dart';
import 'package:child_goods_store_flutter/blocs/edit_profile/edit_profile_state.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/routes.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/http_method.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/widgets/app_dropdown.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:child_goods_store_flutter/widgets/app_snackbar.dart';
import 'package:child_goods_store_flutter/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _nickNameController;
  late final TextEditingController _introduceController;

  @override
  initState() {
    super.initState();
    _nickNameController = TextEditingController(
      text: context.read<EditProfileBloc>().state.user.nickName,
    );
    _introduceController = TextEditingController(
      text: context.read<EditProfileBloc>().state.user.introduce,
    );
  }

  @override
  void dispose() {
    _nickNameController.dispose();
    _introduceController.dispose();
    super.dispose();
  }

  void _onTapSelectImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null && mounted) {
      context.read<EditProfileBloc>().add(EditProfileChangeImage(image));
    }
  }

  void _onTapRemoveImage() {
    context.read<EditProfileBloc>().add(EditProfileChangeImage(null));
  }

  void _onNickNameChange(String nickName) {
    context.read<EditProfileBloc>().add(EditProfileChangeNickName(nickName));
  }

  void _onIntroduceChange(String introduce) {
    context.read<EditProfileBloc>().add(EditProfileChangeIntroduce(introduce));
  }

  // @Deprecated('phone verify is deprecated')
  // void _onTapPhone() async {
  //   var phoneNum = await context.push<String?>(Routes.phoneVerify);
  //   if (phoneNum != null && mounted) {
  //     context.read<EditProfileBloc>().add(EditProfileChangePhoneNum(phoneNum));
  //   }
  // }

  void _onChangedRegion(String? region) {
    context
        .read<EditProfileBloc>()
        .add(EditProfileChangeRegion(region ?? Strings.nullStr));
  }

  void _onChangedTown(String? town) {
    context
        .read<EditProfileBloc>()
        .add(EditProfileChangeTown(town ?? Strings.nullStr));
  }

  void _onTapComplete() {
    context.read<EditProfileBloc>().add(EditProfileSubmit());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state.status == ELoadingStatus.error) {
          AppSnackbar.show(
            context,
            message: state.message ?? Strings.nullStr,
          );
        }
        if (state.status == ELoadingStatus.loaded) {
          if (context.read<EditProfileBloc>().httpMethod == EHttpMethod.post) {
            context.go(Routes.product);
          } else {
            context.pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const AppFont('프로필 설정'),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        BlocBuilder<EditProfileBloc, EditProfileState>(
                          builder: (context, state) => GestureDetector(
                            onTap: _onTapSelectImage,
                            child: Container(
                              width: Sizes.size80,
                              height: Sizes.size80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor,
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: _profileImageSelector(state),
                            ),
                          ),
                        ),
                        IgnorePointer(
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: Sizes.size32,
                            shadows: [
                              Shadow(
                                color: Theme.of(context).shadowColor,
                                blurRadius: Sizes.size3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Gaps.h20,
                    AppInkButton(
                      onTap: _onTapRemoveImage,
                      child: const AppFont(
                        '사진 지우기',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Gaps.v20,
                AppTextFormField(
                  hintText: '닉네임',
                  controller: _nickNameController,
                  onChange: _onNickNameChange,
                  hasNext: true,
                ),
                Gaps.v10,
                AppTextFormField(
                  hintText: '한 줄 소개',
                  controller: _introduceController,
                  onChange: _onIntroduceChange,
                  hasNext: true,
                ),
                Gaps.v20,
                const AppFont(
                  '내 동네',
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w700,
                ),
                Gaps.v10,
                BlocBuilder<EditProfileBloc, EditProfileState>(
                  builder: (context, state) => Row(
                    children: [
                      AppDropdown(
                        width:
                            MediaQuery.sizeOf(context).width / 2 - Sizes.size28,
                        hint: '시',
                        value: state.user.region,
                        values: context
                            .read<AppDataBloc>()
                            .state
                            .region
                            .keys
                            .toList(),
                        onChanged: _onChangedRegion,
                      ),
                      Gaps.h16,
                      AppDropdown(
                        width:
                            MediaQuery.sizeOf(context).width / 2 - Sizes.size28,
                        hint: '군/구',
                        value: state.user.town,
                        values: context
                                .read<AppDataBloc>()
                                .state
                                .region[state.user.region] ??
                            [],
                        onChanged: _onChangedTown,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            return AppInkButton(
              onTap: state.status == ELoadingStatus.loading
                  ? null
                  : _onTapComplete,
              borderRadSize: 0,
              padding: EdgeInsets.zero,
              child: Container(
                width: double.infinity,
                height: Sizes.size60,
                margin: EdgeInsets.only(
                  bottom: MediaQuery.viewPaddingOf(context).bottom,
                ),
                child: Center(
                  child: state.status == ELoadingStatus.loading
                      ? const SizedBox(
                          width: Sizes.size28,
                          height: Sizes.size28,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const AppFont(
                          '저장',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _profileImageSelector(EditProfileState state) {
    if (state.removeImage) {
      return const Icon(
        Icons.person,
        size: Sizes.size60,
        color: Colors.white,
      );
    }
    if (state.image != null) {
      return Image.file(
        File(state.image!.path),
        fit: BoxFit.cover,
      );
    }
    if (state.user.profileImg?.isNotEmpty == true) {
      return Image.network(
        state.user.profileImg!,
        fit: BoxFit.cover,
      );
    }
    return const Icon(
      Icons.person,
      size: Sizes.size60,
      color: Colors.white,
    );
  }
}

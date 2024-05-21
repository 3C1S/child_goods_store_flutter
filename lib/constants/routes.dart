class Routes {
  static const String root = '/';
  static const String signin = '/signin';
  static const String signup = '/signup';

  // static const String phoneVerify = '/phone_verify'; // deprecated

  static const String settings = '/settings';

  static const String editProfile = '/edit_profile';

  /// ### Extra - optional
  /// extra: GoRouterExtraModel\<List\<String\>\>? \
  /// List\<String\>: previous tag list
  static const String editTag = '/edit_tag';

  /// ### Extra - optional
  /// extra: GoRouterExtraModel\<AddressModel\>? \
  /// AddressModel: previous address data
  static const String editAddress = '/edit_address';

  /// ### Extra - optional
  /// extra: GoRouterExtraModel\<ProductModel\>? \
  /// ProductModel: previous product data
  static const String editProduct = '/edit_product';

  /// ### Extra - optional
  /// extra: GoRouterExtraModel\<TogetherModel\>? \
  /// TogetherModel: previous together data
  static const String editTogether = '/edit_together';

  /// ### Extra - optional
  /// extra: GoRouterExtraModel\<ChildModel\>? \
  /// ChildModel: previous child data
  static const String editChild = '/edit_child';

  /// ### Extra - optional
  /// extra: GoRouterExtraModel\<ReviewModel\>? \
  /// ReviewModel: previous review data
  static const String editReview = '/edit_review';

  static const String product = '/product';
  static const String together = '/together';
  static const String child = '/child';
  static const String chat = '/chat';
  static const String profile = '/profile';

  static const String productDetail = '/product';
  static const String togetherDetail = '/together';

  static const String follow = '/follow';
}

class SubRoutes {
  static const String ship = 'ship';
  static const String notification = 'notification';

  /// ### Extra - Required
  /// extra: GoRouterExtraModel\<int\> \
  /// int: [chatRoomId]
  static const String chatRoom = 'chat_room';
}

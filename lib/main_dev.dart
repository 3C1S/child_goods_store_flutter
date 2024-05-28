// Import from dev dependency
import 'package:child_goods_store_flutter/constants/secret.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'flavors.dart';

import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.dev;

  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(nativeAppKey: Secret.kakaoNativeAppKeyDev);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await runner.main();
}

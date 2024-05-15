import 'package:child_goods_store_flutter/app_router.dart';
import 'package:child_goods_store_flutter/blocs/app_data/app_data_bloc.dart';
import 'package:child_goods_store_flutter/flavors.dart';
import 'package:child_goods_store_flutter/repositories/dev/auth_repository_impl_dev.dart';
import 'package:child_goods_store_flutter/repositories/dev/chat_repository_impl_dev.dart';
import 'package:child_goods_store_flutter/repositories/dev/child_repository_impl_dev.dart';
import 'package:child_goods_store_flutter/repositories/dev/data_repository_impl_dev.dart';
import 'package:child_goods_store_flutter/repositories/dev/image_repository_impl_dev.dart';
import 'package:child_goods_store_flutter/repositories/dev/product_repository_impl_dev.dart';
import 'package:child_goods_store_flutter/repositories/dev/profile_repository_impl_dev.dart';
import 'package:child_goods_store_flutter/repositories/dev/review_repository_impl_dav.dart';
import 'package:child_goods_store_flutter/repositories/dev/search_repository_impl_dev.dart';
import 'package:child_goods_store_flutter/repositories/dev/together_repository_impl_dev.dart';
import 'package:child_goods_store_flutter/repositories/dev/user_repository_impl_dev.dart';
import 'package:child_goods_store_flutter/repositories/interface/data_repository_interface.dart';
import 'package:child_goods_store_flutter/repositories/prod/auth_repository_impl_prod.dart';
import 'package:child_goods_store_flutter/repositories/prod/chat_repository_impl_prod.dart';
import 'package:child_goods_store_flutter/repositories/prod/child_repository_impl_prod.dart';
import 'package:child_goods_store_flutter/repositories/prod/data_repository_impl_prod.dart';
import 'package:child_goods_store_flutter/repositories/prod/image_repository_impl_prod.dart';
import 'package:child_goods_store_flutter/repositories/prod/product_repository_impl_prod.dart';
import 'package:child_goods_store_flutter/repositories/prod/profile_repository_impl_prod.dart';
import 'package:child_goods_store_flutter/repositories/prod/review_repository_impl_prod.dart';
import 'package:child_goods_store_flutter/repositories/prod/search_repository_impl_prod.dart';
import 'package:child_goods_store_flutter/repositories/prod/together_repository_impl_prod.dart';
import 'package:child_goods_store_flutter/repositories/prod/user_repository_impl_prod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => F.appFlavor == Flavor.prod
              ? AuthRepositoryImplProd()
              : AuthRepositoryImplDev(),
        ),
        RepositoryProvider(
          create: (context) => F.appFlavor == Flavor.prod
              ? UserRepositoryImplProd()
              : UserRepositoryImplDev(),
        ),
        RepositoryProvider(
          create: (context) => F.appFlavor == Flavor.prod
              ? ChildRepositoryImplProd()
              : ChildRepositoryImplDev(),
        ),
        RepositoryProvider(
          create: (context) => F.appFlavor == Flavor.prod
              ? ProductRepositoryImplProd()
              : ProductRepositoryImplDev(),
        ),
        RepositoryProvider(
          create: (context) => F.appFlavor == Flavor.prod
              ? TogetherRepositoryImplProd()
              : TogetherRepositoryImplDev(),
        ),
        RepositoryProvider(
          create: (context) => F.appFlavor == Flavor.prod
              ? ProfileRepositoryImplProd()
              : ProfileRepositoryImplDev(),
        ),
        RepositoryProvider(
          create: (context) => F.appFlavor == Flavor.prod
              ? ReviewRepositoryImplProd()
              : ReviewRepositoryImplDev(),
        ),
        RepositoryProvider(
          create: (context) => F.appFlavor == Flavor.prod
              ? ChatRepositoryImplProd()
              : ChatRepositoryImplDev(),
        ),
        RepositoryProvider(
          create: (context) => F.appFlavor == Flavor.prod
              ? ImageRepositoryImplProd()
              : ImageRepositoryImplDev(),
        ),
        RepositoryProvider(
          create: (context) => F.appFlavor == Flavor.prod
              ? SearchRepositoryImplProd()
              : SearchRepositoryimplDev(),
        ),
        RepositoryProvider(
          create: (context) => F.appFlavor == Flavor.prod
              ? DataRepositoryImplProd()
              : DataRepositoryImplDev(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppDataBloc(
              dataRepository: context.read<IDataRepository>(),
            ),
          ),
        ],
        child: const AppRouter(),
      ),
    );
  }
}

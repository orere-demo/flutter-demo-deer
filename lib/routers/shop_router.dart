import 'package:fluro/fluro.dart';

import 'package:demo2_deer/pages/shop/shop_page.dart';
import 'package:demo2_deer/routers/i_router.dart';

class ShopRouter implements IRouterProvider {
  static String shopPage = '/shop';

  @override
  void initRouter(FluroRouter router) {
    router.define(shopPage,
        handler: Handler(handlerFunc: (_, __) => const ShopPage()));
  }
}

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo2_deer/routers/i_router.dart';
import 'package:demo2_deer/pages/home/home_page.dart';
import 'package:demo2_deer/routers/shop_router.dart';

class Routes {
  static String home = '/home';

  static final List<IRouterProvider> _listRouter = [];

  static final FluroRouter router = FluroRouter();

  static void initRoutes() {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      debugPrint('未找到目标页');
    });
    router.define(home,
        handler: Handler(
            handlerFunc:
                (BuildContext? context, Map<String, List<String>> params) =>
                    const Home()));
    _listRouter.clear();
    _listRouter.add(ShopRouter());

    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}

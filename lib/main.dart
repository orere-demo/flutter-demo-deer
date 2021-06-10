import 'package:flutter/material.dart';
import 'package:demo2_deer/util/log_utils.dart';
import 'package:demo2_deer/util/device_utils.dart';
import 'package:provider/provider.dart';
import 'package:demo2_deer/routers/routers.dart';
import 'package:demo2_deer/net/dio_utils.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:demo2_deer/demo/demo_page.dart';

void main() {
  /// 确保初始化完成 - WidgetsFlutterBinding
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    Log.init();
    Routes.initRoutes();
    initDio();
    initQuickActions();
  }

  // 全局变量 - 导航的Globalkey
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  void initDio() {
    // print('initDio');
    configDio(
      baseUrl: 'http://poetry.apiopen.top/',
    );
  }

  void initQuickActions() {
    if (Device.isMobile) {
      final QuickActions quickActions = QuickActions();
      // Android每次是重新启动activity，所以放在了splash_page处理。
      // 总体来说使用不方便，这种动态的方式在安卓中局限性高。这里仅做练习使用。
      if (Device.isIOS) {
        quickActions.initialize((String shortcutType) async {
          if (shortcutType == 'demo') {
            navigatorKey.currentState?.push<dynamic>(MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const DemoPage(),
            ));
          }
        });
      }

      quickActions.setShortcutItems(<ShortcutItem>[
        const ShortcutItem(type: 'demo', localizedTitle: 'Demo')
      ]);
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:demo2_deer/util/theme_utils.dart';
import 'package:demo2_deer/res/resources.dart';
import 'my_button.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar(
      {Key? key,
      this.backgroundColor,
      this.title = '',
      this.centerTitle = '',
      this.backImg = 'assets/images/ic_back_black.png',
      this.backImgColor,
      this.actionName = '',
      this.onPressed,
      this.isBack = true})
      : super(key: key);

  final Color? backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String? backImgColor;
  final String actionName;
  final VoidCallback? onPressed;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    final Color _backgroundColor = backgroundColor ?? context.backgroundColor;

    // SystemUiOverlayStyle 状态栏颜色
    final SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(_backgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;

    final Widget back = isBack
        ? IconButton(
            icon: Image.asset(backImg,
                color: backImgColor ?? ThemeUtils.getIconColor(context)),
            onPressed: () {})
        : Gaps.empty;
    // static const Widget empty = SizedBox.shrink();

    final Widget action = actionName.isNotEmpty
        ? Positioned(
            child: Theme(
              data: Theme.of(context).copyWith(
                  buttonTheme: const ButtonThemeData(
                      padding: EdgeInsets.symmetric(horizontal: 16.0))),
              child: MyButton(
                key: const Key('actionName'),
                fontSize: Dimens.font_sp14,
                text: actionName,
                textColor: context.isDark ? Colours.dark_text : Colours.text,
              ),
            ),
          )
        : Gaps.empty;

    final Widget titleWidget = Semantics(
      namesRoute: true,
      header: true,
      child: Container(
        alignment:
            centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
        // double.infinity 可以强制在宽度上撑满
        width: double.infinity,
        // const TextStyle(fontSize: Dimens.font_sp18)
        child: Text(
          title.isEmpty ? centerTitle : title,
          style: TextStyle(fontSize: Dimens.font_sp18),
        ),
        margin: EdgeInsets.symmetric(horizontal: 48.0),
      ),
    );

    // AnnotatedRegion 改变状态栏颜色。AnnotatedRegion应该只包裹顶部状态栏处的控件，比如AppBar的写法就不会导致底部导航栏变黑
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: _backgroundColor,
        // SafeArea 避免与安卓的状态栏或ios的齐刘海的等冲突
        child: SafeArea(
          // Stack / Positioned 层叠布局（定位）
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[titleWidget, back, action],
          ),
        ),
      ),
    );
  }

  // PreferredSizeWidget必须要重写 preferredSize， 即AppBar高度
  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}

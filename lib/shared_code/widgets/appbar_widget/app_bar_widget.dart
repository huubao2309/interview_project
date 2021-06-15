import 'package:flutter/material.dart';
import 'package:interview_project/shared_code/style/appbar_style/appbar_style.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({
    required this.title,
    this.onBack,
    this.actions = const <Widget>[],
    this.isVisibleBackButton = true,
  });

  final String title;
  final bool isVisibleBackButton;
  final List<Widget> actions;
  final VoidCallback? onBack;

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();

  @override
  Size get preferredSize {
    return const Size.fromHeight(60);
  }
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppBarStyle.backgroundAppBar(),
      elevation: 0,
      title: Text(
        widget.title,
        style: AppBarStyle.titleAppBar(),
      ),
      leading: widget.isVisibleBackButton
          ? IconButton(
              icon: AppBarStyle.iconAppBar(),
              onPressed: widget.onBack,
            )
          : null,
      actions: widget.actions,
    );
  }
}

import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget implements PreferredSizeWidget {

  final String title;

  final TextStyle textstyle;

  final Color backgroundcolor;

  final Color foregroundColor;

  final Icon icon;

  final double elevation;

  final List<Widget>? actions;

  final VoidCallback? fallback;

  const CustomTitle({
    Key? key,
    required this.title,
    this.icon = const Icon(
      Icons.arrow_back_ios,
      size: 16,
    ),
    this.textstyle = const TextStyle(
      color: Color(0xFF000000),
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    this.backgroundcolor = const Color(0xFFFFFFFF),
    this.foregroundColor = const Color(0xFF000000),
    this.elevation = 0,
    this.actions = const [],
    this.fallback,
  }) : super(key: key);

  AppBar _getAppBar({VoidCallback? onPressed}) {
    return AppBar(
      title: Text(
        title,
        style: textstyle,
      ),
      leading: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
      backgroundColor: backgroundcolor,
      foregroundColor: foregroundColor,
      centerTitle: true,
      elevation: elevation,
      actions: actions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getAppBar(onPressed: fallback ?? () => Navigator.pop(context));
  }

  @override
  Size get preferredSize => _getAppBar().preferredSize;
}

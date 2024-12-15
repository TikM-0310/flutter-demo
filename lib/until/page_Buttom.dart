import 'package:flutter/material.dart';

class PageButtom extends StatelessWidget {
  // 按钮名称
  final String text;
  // 按钮回调函数
  VoidCallback onPressed;

  PageButtom({
    super.key,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      // 继承主题颜色
      color: Theme.of(context).primaryColor,
      child: Text(text),
    );
  }
}
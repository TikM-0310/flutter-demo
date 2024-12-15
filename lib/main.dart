// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_vlog/page/page_todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 主题色
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.yellow,
        ),
        checkboxTheme: CheckboxThemeData(
          // 设置复选框对号的颜色为白色
          checkColor: WidgetStatePropertyAll(Colors.white),
        ),
      ),
      home: PageTodo(),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_vlog/page/page_todo.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

void main() {
  // 桌面端sqllite初始化
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      // 因此为调试模式下会显示右上角的debug标志
      debugShowCheckedModeBanner: false,
      // 主题色
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
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

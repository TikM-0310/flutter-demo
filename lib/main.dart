// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_vlog/page/home_page.dart';
import 'package:my_vlog/page/page_first.dart';
import 'package:my_vlog/page/page_second.dart';
import 'package:my_vlog/page/page_setting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        //关闭右上方debug图标
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // /const HomePage(),
        // Scaffold布局容器
        home: FirstPage(),
        routes: {
          "/secondPage": (context) => SecondPage(),
          "/settingPage": (context) => SettingPage()
        },
      );
  }
}

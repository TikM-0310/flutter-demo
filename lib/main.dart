// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_vlog/page/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final List nameList = ["Job", "Pike", "Penny"];

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
        home: Scaffold(
            body: Center(
              child: GestureDetector(
                // 单击事件
                onTap: () => {
                  print("我被点击了！")
                },
                child: Container(
                  width: 300,
                  height: 300,
                  color: Colors.deepPurple,
                  child: Center(
                    child: Text("我是中心"),
                  ),
                ),
              ),
            )
        ));
  }
}

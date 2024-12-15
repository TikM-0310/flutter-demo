// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

class PageCount extends StatefulWidget {
  const PageCount({super.key});

  @override
  State<PageCount> createState() => _PageCountState();
}

class _PageCountState extends State<PageCount> {

  int _count = 0;

  // method
  void AddCount(){
    // 打开附件
    setState(() {
      _count ++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("你点击她就会变大"),
            Text(
              _count.toString(),
              style: TextStyle(fontSize: 40),
              ),
        
            ElevatedButton(onPressed: AddCount, child: Text("增加"))
          ],
        ),
      ),
    );
  }
}
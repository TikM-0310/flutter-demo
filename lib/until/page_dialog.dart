// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_vlog/until/page_Buttom.dart';

class DialogBox extends StatelessWidget {
  
  VoidCallback ok;
  VoidCallback quit;
  final TextEditingController controllerText;
  final TextEditingController controllerContent; // 新增內容控制器
  DialogBox({ 
    super.key, 
    required this.controllerText,
    required this.controllerContent, // 新增參數
    required this.ok,
    required this.quit
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      shape: RoundedRectangleBorder(
        // 边框圆角
        borderRadius: BorderRadius.circular(1)
      ),
      content: Container(
        height: 180, // 增加高度以容納新輸入框
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controllerText,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "请输入待办事项"),
            ),
            SizedBox(height: 8), // 添加間距
            TextField(
              controller: controllerContent,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "请输入待办事项内容"), // 新增內容輸入框
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
               PageButtom(text: "保存", onPressed: ok),

               SizedBox(width: 8),

               PageButtom(text: "取消", onPressed: quit),
              ],
            )
          ],
        ),
      ),
    );
  }
}
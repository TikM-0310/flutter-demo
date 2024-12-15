// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_vlog/until/page_Buttom.dart';

class DialogBox extends StatelessWidget {
  
  VoidCallback ok;
  VoidCallback quit;
  final TextEditingController controllerText;
  DialogBox({ 
    super.key, 
    required this.controllerText,
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
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controllerText,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "请输入待办事项"),
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
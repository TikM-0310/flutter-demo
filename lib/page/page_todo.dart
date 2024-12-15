// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:my_vlog/page/page_todoTitle.dart';
import 'package:my_vlog/until/page_dialog.dart';

class PageTodo extends StatefulWidget {
  const PageTodo({super.key});

  @override
  State<PageTodo> createState() => _PageTodoState();
}

class _PageTodoState extends State<PageTodo> {

  // 接收输入框返回的值
  final TextEditingController _controller = TextEditingController();
                                          
  List todoList = [
    ["阿明1", false],
    ["阿明2", true],
    ["阿明3", false],
  ];

  // 复选框点击事件
  void CheckChange(index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  // 添加待办事项
  void AddTask(){
    setState(() {
      todoList.add([_controller.text, false]);
      _controller.clear();
    });

    Navigator.of(context).pop();
  }

  // 创建待办事项弹框
  void createNewTask()
  {
    showDialog(
      context: context, 
      builder: (t){
        return DialogBox(
          controllerText: _controller,
          ok: AddTask,
          quit: () => Navigator.of(context).pop(),
        );
      });
  }

  // 删除待办
  void deleteTask(int index){
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Center(
            child: Text("To Do"),
          ),
          // 阴影效果
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:createNewTask,
          child: Icon(Icons.add
          ),),
        body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return Todotitle(
              taskName: todoList[index][0],
              taskCheck: todoList[index][1],
              onchanged: (value) => CheckChange(index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
        
  }
}

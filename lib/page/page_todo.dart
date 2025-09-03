// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:my_vlog/page/page_todoTitle.dart';
import 'package:my_vlog/until/page_dialog.dart';
import 'package:my_vlog/until/database_helper.dart';

class PageTodo extends StatefulWidget {
  const PageTodo({super.key});

  @override
  State<PageTodo> createState() => _PageTodoState();
}

class _PageTodoState extends State<PageTodo> {

  // 接收输入框返回的值
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> todoList = [];
  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    loadTodos();
    _searchController.addListener(_onSearchChanged);
  }

  // 加载数据库中的待办事项
  void loadTodos() async {
    todoList = await DatabaseHelper().getTodos();
    filteredList = todoList;
    setState(() {});
  }

  // 搜索框内容变化时过滤待办事项
  void _onSearchChanged() {
    String query = _searchController.text.trim();
    if (query.isEmpty) {
      filteredList = todoList;
    } else {
      filteredList = todoList.where((item) => item['title'].toString().contains(query)).toList();
    }
    setState(() {});
  }

  // 复选框点击事件（可扩展为更新数据库）
    void CheckChange(index) async {
      int id = todoList[index]['id'];
      bool currentDone = todoList[index]['done'] == 1;
      await DatabaseHelper().updateTodoDone(id, !currentDone);
      loadTodos();
  }

  // 添加待办事项（插入数据库）
  void AddTask() async {
    await DatabaseHelper().insertTodo({
      'title': _controller.text,
      'content': '',
    });
    _controller.clear();
    Navigator.of(context).pop();
    loadTodos();
    _onSearchChanged();
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

  // 删除待办（删除数据库记录）
  void deleteTask(int id) async {
    await DatabaseHelper().deleteTodo(id);
    loadTodos();
    _onSearchChanged();
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
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => _onSearchChanged(),
              decoration: InputDecoration(
                hintText: '搜索待办事项...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                Widget todoWidget = Todotitle(
                  taskName: filteredList[index]['title'],
                  taskCheck: filteredList[index]['done'] == 1,
                  onchanged: (value) => CheckChange(index),
                  deleteFunction: (context) => deleteTask(filteredList[index]['id']),
                );
                if (index == filteredList.length - 1) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: todoWidget,
                  );
                }
                return todoWidget;
              },
            ),
          ),
        ],
      ),
    );
  }
}
